variable "AWS_REGION" {
  type    = string
  default = "eu-west-1"
}

variable "ports"{
  type = list(number)
  default = [22, 433]
}
