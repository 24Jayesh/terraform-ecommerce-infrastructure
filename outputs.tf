output "bucket_name" {
  description = "Name of the E-commerce product asserts bucket"
  value       = aws_s3_bucket.product_asserts
}
output "bucket_arn" {
  description = "ARN of the E-commerce product asserts bucket"
  value       = aws_s3_bucket.product_asserts.arn
}