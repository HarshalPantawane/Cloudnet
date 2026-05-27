provider "aws" {
  region = "us-east-1"

  assume_role {
    role_arn     = "arn:aws:iam::022577438323:role/terraform-assume-role"
    session_name = "terraform-app-session"
  }
}

terraform {
  required_version = "1.13.8"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.34.0"
    }
  }
  backend "s3" {
    bucket       = "cheetah-mars-dev-us-east-1-tfstate"
    key          = "envs/dev/infra/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}