output "vpc_id" {
    value = aws_vpc.myvpc.id
}

output "public_subnet_id" {
    value = aws_subnet.public_subnet.id
}

output "private_subnet_id" {
    value = aws_subnet.private_subnet.id
}

output "my-igw_id" {
    value = aws_internet_gateway.my-igw.id
}

output "my-sg_id" {
    value = aws_security_group.my-sg.id
}