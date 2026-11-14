
//this is for root module 
# output "bucket_name" {
#   description = "Name of the E-commerce product asserts bucket"
#   value       = aws_s3_bucket.product_asserts
# }
# output "bucket_arn" {
#   description = "ARN of the E-commerce product asserts bucket"
#   value       = aws_s3_bucket.product_asserts.arn
# }

//output form the child module 
output "product_asserts_bucket_name_from_child" {
  description = "Name of the E-Commerce product assets S3 bucket"
  value       = module.storage.bucket_name
}
output "product_asserts_bucket_arn_from_child" {
  description = "ARN of the E-Commerce product assets S3 bucket"
  value       = module.storage.bucket_arn
}