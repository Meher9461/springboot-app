resource "aws_instance" "my-project" {
    ami = ami-080e1f13689e07408
    instance_type = t2.micro
    subnet_id = aws_subnet.public_subnet.id
    count = 2

    tags = {
        Name = "my-project"
    }   
}

