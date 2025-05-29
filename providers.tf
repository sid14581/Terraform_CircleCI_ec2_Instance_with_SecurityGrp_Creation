terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.4.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

terraform {
  backend "s3" {
    bucket         = "ec2-with-sgp-example-tf-state-one"
    region         = "us-east-2"
    key            = "env/dev/cloudgeeks.tfstate"
    dynamodb_table = "cloudgeeks-dev-terraform-backend-state-lock"
  }
}