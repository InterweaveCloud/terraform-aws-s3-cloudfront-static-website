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

output "s3_bucket_arn" {
  value = aws_s3_bucket.website_files.arn
}
