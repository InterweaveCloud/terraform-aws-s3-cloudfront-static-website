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
