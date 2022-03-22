# output "instance-vpc-subnet-id" {
#     value = aws_instance.example.subnet_id
# }

output "instance-sg-id" {
    value = aws_instance.example.vpc_security_group_ids
}