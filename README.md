# AWS S3 CloudFront Static Website Terraform Module

This module provisions the infrasructure required for a static website hosted on AWS S3 and CloudFront and optionally allows syncronisation of the website content with a local directory.

 creates an [S3 Bucket](https://aws.amazon.com/s3/) to creates a [CloudFront Distribution](https://aws.amazon.com/cloudfront/),


## Key Features

 -  [S3 Bucket](https://aws.amazon.com/s3/) to store website content.
 -  [CloudFront Distribution](https://aws.amazon.com/cloudfront/) to serve the website at edge locations at a low cost and high performance.
 -  [Route 53](https://aws.amazon.com/route53/) A records to utilise custom domain on website.
 -  Security First - S3 Bucket is private with IAM policies to provide permissions to CloudFront.
 -  Utilises aws S3 sync command to upload website content to S3 Bucket.

## Requirements

 - Domain Name
 -  [Route 53 Hosted zone](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/hosted-zones-working-with.html) which is the DNS provider for the domain. [Making Amazon Route 53 the DNS service for an existing domain](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/MigratingDNS.html). Note: the hosted zone only needs to manage the DNS service, domain registration does not need to be migrated!
 - [A second aws porovider configured in us-east-1](https://www.terraform.io/language/providers/configuration) as CloudFront and SSL certificates are only available in us-east-1.

To syncronisation of the website content with a local directory, the following is required:
 -  [AWS CLI](https://aws.amazon.com/cli/) installed locally - [installation instructions](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
 -  [Configure a named profile](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html) using `aws configure --profile NAME` command. This is used for the aws s3 sync command.


## Usage
[Example available here](https://github.com/DevOpsNavy/s3-cloudfront-static-website/tree/main/examples/static_website_with_sync)

```javascript
# Module AP

# Provider required in useast1 for cloudfront, SSLM Certificate
provider "aws" {
  alias   = "useast1"
  region  = "us-east-1"
  profile = ""
}

module "website" {
  
  source = "XXX"

  resource_uid   = "DevOpsNavy"
  domain_name    = "XXX"
  hosted_zone_id = "XXX"
  profile        = "XXX"

  sync_directories = [{
    local_source_directory = "./website_content"
    s3_target_directory    = ""
  }]

  providers = {
    aws.useast1 = aws.useast1
  }
}

```