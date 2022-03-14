provider "aws" {
  
}

variable "aws-region" {
  type = string
  default = "eu-east-1"
}

variable "AMIS" {
  type = map(string)
  default = {
    "eu-east-1" = "my-test-ami"
  }
}

resource "aws_instance" "sample-aws-instance" {
  ami = var.AMIS[var.awsregion]
  instance_instance_type = "t2.micro"
}