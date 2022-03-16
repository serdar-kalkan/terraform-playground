provider "aws" {
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
  region     = var.AWS_REGION
}

module "sample-module" {
  source = "./modules/nested-module-A"

  bucket_name = "terraform-modules-pocserdar-2022-03-16"

  tags = {
    Terraform   = "true"
    Environment = "staging"
  }
}