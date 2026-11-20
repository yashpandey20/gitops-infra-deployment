output "s3_bucket_name" {
  description = "GitOps managed S3 bucket"
  value       = aws_s3_bucket.gitops_bucket.bucket
}

output "s3_bucket_arn" {
  description = "ARN of the GitOps S3 bucket"
  value       = aws_s3_bucket.gitops_bucket.arn
}
