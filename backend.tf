terraform { //this file create to change from local state to remote state via Aws S3   (s3 backend configuration)
  backend "s3" {
    bucket       = "ecommerce-dev-product-asserts-jayesh-01"
    key          = "terraform-state/dev/terraform.tfstate"
    region       = "ap-south-1"
    profile      = "jayeshdevops"
    use_lockfile = true //enable the state locking
    encrypt      = true
  }
}