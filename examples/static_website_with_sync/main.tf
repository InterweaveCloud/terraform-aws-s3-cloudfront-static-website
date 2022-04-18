module "website" {
  source = "../s3-cloudfront-static-website"

  resource_uid   = "DevOpsNavy"
  domain_name    = "XXX"
  hosted_zone_id = "XXX"
  profile        = "XXX"

  sync_directories {
    source = "./website_content"
    target = "/"
  }

  providers = {
    aws.useast1 = aws.useast1
  }
}
