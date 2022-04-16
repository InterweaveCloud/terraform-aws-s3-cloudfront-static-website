terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = "4.10.0"
      configuration_aliases = [aws.useast1]
    }
  }
}

