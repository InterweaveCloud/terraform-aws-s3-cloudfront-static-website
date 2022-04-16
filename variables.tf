#------------------------------------------------------------------------------
# Required Variables
#------------------------------------------------------------------------------

variable "domain_name" {
  type        = string
  description = "The domain name for the website."
}

variable "hosted_zone_id" {
  type        = string
  description = "The Hosted Zone ID. This is automatically generated and can be referenced by zone records."
}

variable "resource_uid" {
  type        = string
  description = "UID which will be prepended to resources created by this module"
}

#------------------------------------------------------------------------------
# Optional Variables for S3 Bucket
#------------------------------------------------------------------------------

variable "bucket_versioning" {
  type        = bool
  description = "Enable bucket versioning"
  default     = false
}

#------------------------------------------------------------------------------
# Required if sync files is used
#------------------------------------------------------------------------------

variable "website_content_directory" {
  type        = string
  description = "The Hosted Zone ID. This is automatically generated and can be referenced by zone records."
}

variable "profile" {
  type        = string
  description = "The Hosted Zone ID. This is automatically generated and can be referenced by zone records."
}

#------------------------------------------------------------------------------
# Optional Variables for Tagging
#------------------------------------------------------------------------------

variable "Environment" {
  type        = string
  description = "Environment to tag all resources created by this module"
  default     = "Automation"
}

variable "Application" {
  type        = string
  description = "Environment to tag all resources created by this module"
  default     = "S3 Static Website"
}