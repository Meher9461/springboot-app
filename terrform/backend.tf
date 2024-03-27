terraform {
  backend "s3" {
    bucket = var.bucket
    key = "statefile/terraform.tfstate"
    region = var.region
    
  }
}