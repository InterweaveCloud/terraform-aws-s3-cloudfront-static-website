#AWS user ID
data "aws_caller_identity" "current" {}

locals {
  tags = {
    Environment = "${var.Environment}"
    Application = "${var.Application}"
  }
}
#------------------------------------------------------------------------------
# S3 bucket to host all website files.
#------------------------------------------------------------------------------

resource "aws_s3_bucket" "website_files" {
  # Remove all non alphanumerical characters with - and lowercase the string
  bucket_prefix = lower(join("-", regexall("[[:alnum:]]*", var.resource_uid)))
  tags          = local.tags
}

# Private S3 bucket enforced for security
resource "aws_s3_bucket_acl" "website_files" {
  bucket = aws_s3_bucket.website_files.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "website_files" {
  count  = var.bucket_versioning ? 1 : 0
  bucket = aws_s3_bucket.website_files.id
  versioning_configuration {
    status = "Enabled"
  }
}

#------------------------------------------------------------------------------
# Create SSL Certificate, route53 records for validation and then validate the certificate
#------------------------------------------------------------------------------
resource "aws_acm_certificate" "ssl_certificate" {
  provider = aws.useast1

  domain_name = var.domain_name

  # DNS validation requires the domain nameservers to already be pointing to AWS
  validation_method         = "DNS"
  subject_alternative_names = ["*.${var.domain_name}"]
  tags                      = local.tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.ssl_certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = var.hosted_zone_id
}

resource "aws_acm_certificate_validation" "ssl_certificate_validation" {
  provider = aws.useast1

  certificate_arn         = aws_acm_certificate.ssl_certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}

#------------------------------------------------------------------------------
# Cloudfront distribution for main www.s3 site. HTTP requests automatically 
# redirected to HTTPS.
#------------------------------------------------------------------------------
resource "aws_cloudfront_origin_access_identity" "cloudfront_oai" {
  comment = "${var.resource_uid}_OAI"
}

locals {
  origin_id = "${var.resource_uid}_origin_id"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  provider = aws.useast1

  origin {
    domain_name = aws_s3_bucket.website_files.bucket_regional_domain_name
    origin_id   = local.origin_id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.cloudfront_oai.cloudfront_access_identity_path
    }
  }

  enabled             = var.enable_cloudfront_distribution
  is_ipv6_enabled     = true
  comment             = "${var.resource_uid}-CloudfrontDistribution"
  default_root_object = var.default_root_object

  # Default cache behaviour
  default_cache_behavior {
    allowed_methods  = var.default_cache_allowed_methods
    cached_methods   = var.default_cache_methods
    target_origin_id = local.origin_id

    forwarded_values {
      query_string = var.default_cache_forward_query_string

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = var.default_cache_viewer_protocol_policy
    min_ttl                = var.default_cache_min_ttl
    default_ttl            = var.default_cache_default_ttl
    max_ttl                = var.default_cache_max_ttl
  }

  price_class = var.cloudfront_price_class

  restrictions {
    geo_restriction {
      restriction_type = var.cloudfront_geo_restriction_type
      locations        = var.cloudfront_geo_restriction_locations
    }

  }

  aliases = ["${var.domain_name}", "www.${var.domain_name}"]

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate_validation.ssl_certificate_validation.certificate_arn
    ssl_support_method       = var.cloudfront_ssl_support_method
    minimum_protocol_version = var.cloudfront_minimum_protocol_version
  }

}

#-----------------------------------------------------------------------------------------------
# Provide Permissions to allow the Cloudfront distribution to access the S3 bucket
#-----------------------------------------------------------------------------------------------
locals {

  cloudfront_website_bucket_access = jsonencode({
    "Version" : "2008-10-17",
    "Id" : "CloudfrontAccess to Website Files",
    "Statement" : [
      {
        "Sid" : "1",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "${aws_cloudfront_origin_access_identity.cloudfront_oai.iam_arn}"
        },
        "Action" : "s3:GetObject",
        "Resource" : "arn:aws:s3:::${aws_s3_bucket.website_files.id}/*"
      }
    ]
  })
}

resource "aws_s3_bucket_policy" "website_files" {

  bucket = aws_s3_bucket.website_files.id
  policy = local.cloudfront_website_bucket_access
}

resource "aws_route53_record" "root-a" {
  zone_id = var.hosted_zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.s3_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www-a" {
  zone_id = var.hosted_zone_id
  name    = "www.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.s3_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}
#-----------------------------------------------------------------------------------------------
# Upload Files
#-----------------------------------------------------------------------------------------------

# Create zip files to allow generation of hash and detect changes in contents
data "archive_file" "website_content_zip" {
  count       = length(var.sync_directories)
  type        = "zip"
  source_dir  = var.sync_directories[count.index].local_source_directory
  output_path = "builds/${var.sync_directories[count.index].local_source_directory}.zip"
}

resource "null_resource" "sync_remote_website_content" {
  count = length(var.sync_directories)

  provisioner "local-exec" {
    working_dir = var.sync_directories[count.index].local_source_directory
    command     = "aws s3 sync . s3://${aws_s3_bucket.website_files.id}/${var.sync_directories[count.index].s3_target_directory} --delete --profile ${var.profile}"
  }

  # Reuploads triggered by changes in directories or content
  triggers = {
    filesha256             = filesha256(data.archive_file.website_content_zip[count.index].output_path)
    local_source_directory = var.sync_directories[count.index].local_source_directory
    s3_target_directory    = var.sync_directories[count.index].s3_target_directory
  }
}
