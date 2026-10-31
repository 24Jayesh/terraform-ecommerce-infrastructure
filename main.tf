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
  //region = "ap-south-1"    //hard code 
  region = var.aws_region
}

#Resoursec Configuration
resource "aws_s3_bucket" "product_asserts" {
  // bucket = "ecommerce-dev-product-asserts-jayesh"   ////hard code
  //bucket = "${var.project_name}-${var.environment}-product-asserts-jayesh-01" //dynamic code
  bucket = local.bucket_name //use of locals
  tags = {
    Environment = var.environment
    Purpose     = "product-assets"
  }
}