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
