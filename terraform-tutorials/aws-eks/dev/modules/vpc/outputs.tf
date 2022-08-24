output "this_vpc_id" {
    description = "The ID of the vpc"
    value = ""
}

output "deve_subnet1_id" {
    description = "The ID of the vpc"
    value = aws_subnet.dev1-subnet.id
}

output "dev_subnet2_id" {
    description = "The ID of the vpc"
    value = aws_subnet.dev2-subnet.id
}

output "aws_security_group_traffice_id" {
    description = "The ID of the vpc"
    value = aws_security_group.allow-web-traffic.id
}

output "vpc_id" {
    description = "The ID of the vpc"
    value = aws_vpc.dev-vpc.id
}