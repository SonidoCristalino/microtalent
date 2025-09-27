# provider.tf

# Configure Terraform to use the AWS provider and define the remote backend.
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  required_version = "~> 1.13.0"

  # Remote backend configuration in S3
  backend "s3" {
    bucket         = "tfstate-microtalent-2025"      
    key            = "global/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-microtalent"   
    encrypt        = true
  }
}

# Configure the AWS provider, indicating the region where the resources will be created.
provider "aws" {
  region = var.aws_region
}
