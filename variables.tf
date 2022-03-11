# Variable access file - values entrered through module
variable "bucket_prefix" {
  type = string
  description = "The name of the bucket without the www. prefix. Normally domain_name."
}

variable "domain_name" {
  type = string
  description = "The domain name for the website."
}

variable "s3_origin_id" {
  type = string
  description = "Origin name for the S3's CloudFront distribution"
}

variable "cloudfront_oai" {
  type = string
  description = "Origin access identity name"
}

variable "hosted_zone_id" {
  type = string
  description = "ID for the Hosted zone that handles DNS for TCP and UDP traffic"
}

# variable "domain_name" {
#   type = string
#   description = ""
# }