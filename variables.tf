# Variable access file - values entrered through module
variable "resource_uid" {
  type        = string
  description = "UID which will be prepended to resources created by this module"
}

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

variable "domain_name" {
  type        = string
  description = "The domain name for the website."
}


variable "hosted_zone_id" {
  type        = string
  description = "The Hosted Zone ID. This is automatically generated and can be referenced by zone records."
}

variable "website_content_directory" {
  type        = string
  description = "The Hosted Zone ID. This is automatically generated and can be referenced by zone records."
}

variable "profile" {
  type        = string
  description = "The Hosted Zone ID. This is automatically generated and can be referenced by zone records."
}