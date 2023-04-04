provider "aws" {
  
}

variable "aws-region" {
  type = string
  default = "eu-east-1"
}

variable "AMIS" {
  type = map(string)
  default = {
    "eu-east-1" = "ami-0f29c8402f8cce65c"
  }
}

# variable "instancename" {
#   type = string
# }

resource "aws_instance" "test-aws-instance" {
  # name = var.instancename
  ami = var.AMIS[var.aws-region]
  instance_type = "t2.micro"
}