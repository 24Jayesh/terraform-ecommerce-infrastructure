output "bucket_id" {
  description = "ID of the product assets S3 bucket"
  value       = aws_s3_bucket.product_asserts.id
}
output "bucket_arn" {
  description = "ARN of the product assets S3 bucket"
  value       = aws_s3_bucket.product_asserts.arn
}
output "bucket_name" {
  description = "Name of the product assets S3 bucket"
  value       = aws_s3_bucket.product_asserts.bucket
}