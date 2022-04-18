#------------------------------------------------------------------------------
# S3 bucket to host all website files.
#------------------------------------------------------------------------------

output "s3_bucket_id" {
  description = "The name of the bucket."
  value       = aws_s3_bucket.website_files.id
}

output "s3_bucket_arn" {
  description = "The ARN of the bucket. Will be of format arn:aws:s3:::bucketname."
  value       = aws_s3_bucket.website_files.arn
}

output "s3_bucket_region" {
  description = "The AWS region this bucket resides in."
  value       = aws_s3_bucket.website_files.region
}

output "s3_bucket_acl" {
  description = "The ACL of the bucket."
  value       = "private"
}

output "s3_bucket_versioning" {
  description = "The bucket versioning status."
  value       = var.bucket_versioning
}

output "s3_bucket_access_policy_json" {
  description = "JSON bucket policy to allow CloudFront to access the S3 bucket."
  value       = local.cloudfront_website_bucket_access
}

output "s3_bucket_access_policy" {
  description = "Bucket policy to allow CloudFront to access the S3 bucket."
  value       = jsondecode(local.cloudfront_website_bucket_access)
}


#------------------------------------------------------------------------------
# SSL Certificate
#------------------------------------------------------------------------------

output "acm_certificate_arn" {
  description = "The ARN of the certificate"
  value       = aws_acm_certificate.ssl_certificate.arn
}

output "acm_certificate_domain_name" {
  description = "The domain name for which the certificate is issued"
  value       = aws_acm_certificate.ssl_certificate.domain_name
}

output "acm_certificate_status" {
  description = "Status of the certificate."
  value       = aws_acm_certificate.ssl_certificate.status
}

output "acm_certificate_validation_id" {
  description = "The time at which the certificate was issued"
  value       = aws_acm_certificate_validation.ssl_certificate_validation.id
}

#------------------------------------------------------------------------------
# CloudFront Origin Access Identity
#------------------------------------------------------------------------------

output "cloudfront_origin_access_identity_id" {
  description = "The identifier for the distribution. For example: EDFDVBD632BHDS5."
  value       = aws_cloudfront_origin_access_identity.cloudfront_oai.id
}

output "cloudfront_origin_access_identity_caller_reference" {
  description = "Internal value used by CloudFront to allow future updates to the origin access identity."
  value       = aws_cloudfront_origin_access_identity.cloudfront_oai.caller_reference
}

output "cloudfront_origin_access_identity_cloudfront_access_identity_path" {
  description = "A shortcut to the full path for the origin access identity to use in CloudFront, see below."
  value       = aws_cloudfront_origin_access_identity.cloudfront_oai.cloudfront_access_identity_path
}

output "cloudfront_origin_access_identity_etag" {
  description = "The current version of the origin access identity's information. For example: E2QWRUHAPOMQZL."
  value       = aws_cloudfront_origin_access_identity.cloudfront_oai.etag
}

output "cloudfront_origin_access_identity_iam_arn" {
  description = "A pre-generated ARN for use in S3 bucket policies (see below). Example: arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity E2QWRUHAPOMQZL."
  value       = aws_cloudfront_origin_access_identity.cloudfront_oai.iam_arn
}

output "cloudfront_origin_access_identity_s3_canonical_user_id" {
  description = "The Amazon S3 canonical user ID for the origin access identity, which you use when giving the origin access identity read permission to an object in Amazon S3."
  value       = aws_cloudfront_origin_access_identity.cloudfront_oai.s3_canonical_user_id
}

#------------------------------------------------------------------------------
# CloudFront Distribution
#------------------------------------------------------------------------------

output "cloudfront_distribution_id" {
  description = "The identifier for the distribution. For example: EDFDVBD632BHDS5."
  value       = aws_cloudfront_distribution.s3_distribution.id
}

output "cloudfront_distribution_arn" {
  description = "The ARN (Amazon Resource Name) for the distribution. For example: arn:aws:cloudfront::123456789012:distribution/EDFDVBD632BHDS5, where 123456789012 is your AWS account ID."
  value       = aws_cloudfront_distribution.s3_distribution.arn
}

output "cloudfront_distribution_caller_reference" {
  description = "Internal value used by CloudFront to allow future updates to the distribution configuration."
  value       = aws_cloudfront_distribution.s3_distribution.caller_reference
}

output "cloudfront_distribution_status" {
  description = "The current status of the distribution. Deployed if the distribution's information is fully propagated throughout the Amazon CloudFront system."
  value       = aws_cloudfront_distribution.s3_distribution.status
}

output "cloudfront_distribution_tags_all" {
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
  value       = aws_cloudfront_distribution.s3_distribution.tags_all
}

output "cloudfront_distribution_trusted_key_groups" {
  description = "List of nested attributes for active trusted key groups, if the distribution is set up to serve private content with signed URLs"
  value       = aws_cloudfront_distribution.s3_distribution.trusted_key_groups
}

output "cloudfront_distribution_trusted_signers" {
  description = "List of nested attributes for active trusted signers, if the distribution is set up to serve private content with signed URLs"
  value       = aws_cloudfront_distribution.s3_distribution.trusted_signers
}

output "cloudfront_distribution_domain_name" {
  description = "The domain name corresponding to the distribution. For example: d604721fxaaqy9.cloudfront.net."
  value       = aws_cloudfront_distribution.s3_distribution.domain_name
}

output "cloudfront_distribution_last_modified_time" {
  description = "The date and time the distribution was last modified."
  value       = aws_cloudfront_distribution.s3_distribution.last_modified_time
}

output "cloudfront_distribution_in_progress_validation_batches" {
  description = "The number of invalidation batches currently in progress."
  value       = aws_cloudfront_distribution.s3_distribution.in_progress_validation_batches
}

output "cloudfront_distribution_etag" {
  description = "The current version of the distribution's information. For example: E2QWRUHAPOMQZL."
  value       = aws_cloudfront_distribution.s3_distribution.etag
}

output "cloudfront_distribution_hosted_zone_id" {
  description = "The CloudFront Route 53 zone ID that can be used to route an Alias Resource Record Set to. This attribute is simply an alias for the zone ID Z2FDTNDATAQYW2."
  value       = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
}

#------------------------------------------------------------------------------
# Route 53 Records
#------------------------------------------------------------------------------

output "route53_root_a_record_name" {
  description = "The name of the root A record."
  value       = aws_route53_record.root-a.name
}

output "route53_root_www_record_name" {
  description = "The name of the www A record."
  value       = aws_route53_record.www-a.name
}

output "route53_acm_certificate_validation_records" {
  description = "Route 53 validation records for the ACM certificate."
  value       = aws_route53_record.cert_validation
}
