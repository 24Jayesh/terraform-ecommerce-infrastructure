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
  region  = var.aws_region
  profile = "jayeshdevops"
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

//vpc 
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name        = "ecommerce-${var.environment}-vpc"
    Environment = var.environment
    Purpose     = "eccommerce-network"
  }
}

//subnet 
resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id //implicit dependency 
  cidr_block = "10.0.1.0/24"
  //availability_zone       = "${var.aws_region}a"  //manually dererived the avalibily zone name
  availability_zone       = data.aws_availability_zones.available.names[0] //refrence the data source
  map_public_ip_on_launch = true

  tags = {
    Name        = "ecommerce-${var.environment}-public-subnet"
    Environment = var.environment
    Purpose     = "ecommerce-public-subnet"
  }

}

//security group 
resource "aws_security_group" "web" {
  name        = "ecommerce-${var.environment}-web-sg"
  description = "Security group for E-Commerce web application"
  vpc_id      = aws_vpc.main.id //implicit dependency
  tags = {
    Name        = "ecommerce-${var.environment}-web-sg"
    Environment = var.environment
    Purpose     = "ecommerce-web"
  }
}

// amazon inux ami 
data "aws_ssm_parameter" "amazon_linux" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

//Availabilty zone   // data source concept
data "aws_availability_zones" "available" {
  state = "available"
}

//ec2 intance 
resource "aws_instance" "web" {
  count                  = var.web_instance_count //count funtionality
  ami                    = data.aws_ssm_parameter.amazon_linux.value
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.public.id //implicit dependency
  vpc_security_group_ids = [aws_security_group.web.id]
  tags = {
    //Name        = "ecommerce-${var.environment}-web" //for single inctance 
    Name        = "ecommerce-${var.environment}-web-${count.index + 1}" //for multiple instance
    Environment = var.environment
    Purpose     = "ecommerce-web"
  }
}