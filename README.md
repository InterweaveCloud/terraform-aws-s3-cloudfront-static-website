# AWS S3 Static Website Terraform Module

[Terraform Module](https://registry.terraform.io/modules/conortm/s3-static-website/aws/latest) for an AWS S3 Static Website, fronted by a CloundFront Distribution.

**Note:** This module "works" but is still in development.


## Features

This module allows for [Hosting a Static Website on Amazon S3](https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteHosting.html), provisioning the following:

 -  S3 Bucket for static public files
 -  CloudFront Distribution fronting the S3 Bucket
 -  Route 53 Record Set aliased to the CloudFront Distribution

It requires (for now?) that the following have been setup outside this module:

 -  SSL Certificate
 -  Route 53 Hosted Zone

## Usage
```javascript
# Module AP
module "website" {
  source = "github.com/DevOpsNavy/s3-cloudfront-static-website"
  
  bucket_prefix = ""
  domain_name = ""
  s3_origin_id = ""
  cloudfront_oai = ""
  hosted_zone_id = ""
  version = ""

}
```

## Inputs

| Name             | Description            | Type           | 
| ----------------- | -------------- | -------------- | 
| bucket_prefix | S3 bucket name | string |  
| domain_name | Domain name for the website (i.e. ``` www.example.com```) | string |  
| s3_origin_id | Bucket Origin ID | string |  
| cloudfront_oai | An Origin Access Identity (OAI) is used for sharing private content via CloudFront. | string |  
| hosted_zone_id | ID of the Route 53 Hosted Zone in which to create an alias record set | string |  
| version | Current terraform version | string |

## Outputs

| Name             | Description            |
| ----------------- | --------------    | 
| s3_bucket_arn | S3 bucket arn to uniquely identify AWS resource | 


## TO-DO
...
