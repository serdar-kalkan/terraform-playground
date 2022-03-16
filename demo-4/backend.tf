terraform {
  backend "s3" {
    bucket = "terraform-state-pocserdar"
    key = "demo1/sample-tfstack-state"
    region = "eu-west-1"
  }
}
