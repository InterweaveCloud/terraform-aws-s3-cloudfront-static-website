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
