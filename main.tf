data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "website_files" {

  bucket = lower("${var.bucket_prefix}-${data.aws_caller_identity.current.account_id}")

  force_destroy = "true"


  #versioning {
   # enabled = "true"
  #}
}
resource "aws_s3_bucket_acl" "website_files" {
  bucket = aws_s3_bucket.website_files.id
  acl    = "private"
}