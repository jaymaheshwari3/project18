terraform {
  backend "s3" {
    bucket       = "jay-project18-tfstate-590507089733"
    key          = "project18/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "gitops" {
  bucket = "jay-project18-gitops-590507089733"

  tags = {
    Name    = "jay-project18-gitops"
    Project = "Project18"
  }
}

resource "aws_s3_bucket_public_access_block" "gitops" {
  bucket = aws_s3_bucket.gitops.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

output "bucket_name" {
  value = aws_s3_bucket.gitops.id
}
