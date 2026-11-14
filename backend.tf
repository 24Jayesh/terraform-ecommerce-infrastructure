terraform {
  backend "s3" {
    bucket       = "ecommerce-dev-product-asserts-jayesh-01"
    key          = "terraform-state/dev/terraform.tfstate"
    region       = "ap-south-1"
    profile      = "jayeshdevops"
    use_lockfile = true //enable the state locking
    encrypt      = true
  }
}