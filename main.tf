
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

resource "aws_s3_bucket" "gitops_bucket" {
  bucket = "gitops-infra-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.name}"

  tags = {
    Name        = "GitOps-Infrastructure-Bucket"
    Environment = "Dev"
    ManagedBy   = "Terraform"
    Project     = "Project-18"
  }
}

resource "aws_s3_bucket_versioning" "gitops_versioning" {
  bucket = aws_s3_bucket.gitops_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "gitops_public_access" {
  bucket = aws_s3_bucket.gitops_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "gitops_encryption" {
  bucket = aws_s3_bucket.gitops_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
