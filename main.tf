data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "website_files" {

  bucket = lower("${var.bucket_prefix}-${data.aws_caller_identity.current.account_id}")

  acl           = "private"
  force_destroy = "true"


  #versioning {
   # enabled = "true"
  #}
}