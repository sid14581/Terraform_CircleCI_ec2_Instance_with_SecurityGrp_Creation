terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.0"
    }
  }

  backend "s3" {
    bucket = "ec2-with-sgp-example-tf-state-one"
    region = "us-east-2"
    key    = "env/dev/cloudgeeks-dev.tfstate"
    # dynamodb_table = "cloudgeeks-dev-terraform-backend-state-lock"
  }
}

provider "aws" {
  region = "us-east-2"
}


