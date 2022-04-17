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
# Optional Variables
#------------------------------------------------------------------------------

variable "bucket_versioning" {
  type        = bool
  description = "Enable bucket versioning"
  default     = false
}

variable "default_root_object" {
  type        = string
  description = "The object that you want CloudFront to return (for example, index.html) when an end user requests the root URL."
  default     = "index.html"
}

variable "enable_cloudfront_distribution" {
  type        = bool
  description = "Whether the distribution is enabled to accept end user requests for content."
  default     = true
}

variable "default_cache_allowed_methods" {
  type        = list(string)
  description = "Controls which HTTP methods CloudFront processes and forwards to your Amazon S3 bucket or your custom origin."
  default     = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
}

variable "default_cache_methods" {
  type        = list(string)
  description = "Controls whether CloudFront caches the response to requests using the specified HTTP methods."
  default     = ["GET", "HEAD", "OPTIONS"]
}

variable "default_cache_min_ttl" {
  type        = number
  description = "The minimum amount of time that you want objects to stay in CloudFront caches before CloudFront queries your origin to see whether the object has been updated."
  default     = 0
}

variable "default_cache_default_ttl" {
  type        = number
  description = "The default amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request in the absence of an Cache-Control max-age or Expires header."
  default     = 3600
}

variable "default_cache_max_ttl" {
  type        = number
  description = "The maximum amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request to your origin to determine whether the object has been updated. Only effective in the presence of Cache-Control max-age, Cache-Control s-maxage, and Expires headers"
  default     = 86400
}

variable "default_cache_viewer_protocol_policy" {
  type        = string
  description = "Use this element to specify the protocol that users can use to access the files in the origin specified by TargetOriginId when a request matches the path pattern in PathPattern. One of allow-all, https-only, or redirect-to-https."
  default     = "redirect-to-https"
}

variable "cloudfront_price_class" {
  type        = string
  description = "The price class for this distribution. One of PriceClass_All, PriceClass_200, PriceClass_100"
  default     = "PriceClass_200"
}

variable "cloudfront_geo_restriction_type" {
  type        = string
  description = "The method that you want to use to restrict distribution of your content by country: none, whitelist, or blacklist."
  default     = "none"
}

variable "cloudfront_geo_restriction_locations" {
  type        = list(string)
  description = "The ISO 3166-1-alpha-2 codes for which you want CloudFront either to distribute your content (whitelist) or not distribute your content (blacklist)."
  default     = []
}

variable "cloudfront_ssl_support_method" {
  type        = string
  description = "Specifies how you want CloudFront to serve HTTPS requests. One of vip or sni-only."
  default     = "sni-only"
}

variable "cloudfront_minimum_protocol_version" {
  type        = string
  description = "The minimum version of the SSL protocol that you want CloudFront to use for HTTPS connections. "
  default     = "TLSv1.1_2016"
}



#------------------------------------------------------------------------------
# Advanced Optional Variables
#------------------------------------------------------------------------------

variable "default_cache_forward_query_string" {
  type        = bool
  description = "Indicates whether you want CloudFront to forward query strings to the origin that is associated with this cache behavior."
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