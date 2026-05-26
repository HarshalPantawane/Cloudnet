provider "aws" {
  region = "us-east-1"

assume_role {
  role_arn = ""
  session_name = "stack_project"
}

}

terraform {
  required_version = "1.13.4"
  required_providers {
    aws ={
        version = "6.35.1"
        source = "hashicorp/aws"
    }
  }
  backend "s3" {
    bucket = ""
    key = "envs/dev/app/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
    use_lockfile = true
  }
}