#terraform block 
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

#provider Configuration 
provider "aws" {
  region = "ap-south-1"
}

#Resoursec Configuration
resource "aws_s3_bucket" "product_asserts" {
  bucket = "ecommerce-dev-product-asserts-jayesh"
}