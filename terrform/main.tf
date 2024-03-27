terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
  
}


# Create a VPC
resource "aws_vpc" "myvpc" {
  cidr_block = var.cidr_block_myvpc
  enable_dns_hostnames = true

  tags = {
    Name = "myvpc"
  }
}

  
# Create subnets
resource "aws_subnet" "public_subnet" {
  vpc_id = var.aws_vpc.id
  cidr_block = var.cidr_block_public_subnet
  availability_zone = "us-east-1a"
  depends_on = [ aws_vpc.myvpc ]

  tags = {
    Name = public_subnet
   }
}


resource "aws_subnet" "private_subnet" {
  vpc_id = var.aws_vpc.id
  cidr_block = var.cidr_block_private_subnet
  availability_zone = "us-east-1b"
  depends_on = [ aws_subnet.public_subnet ]

  tags = {
    Name = private_subnet
  }
}

# Create Internet gateway

resource "aws_internet_gateway" "my-igw" {
  vpc_id = var.aws_vpc.id

  tags = {
    Name = my-igw
  }
}

# Create Route table

resource "aws_route_table" "public-rt" {
  vpc_id = var.aws_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }

  tags = {
    Name = public-rt
  }
}

resource "aws_route_table" "private-rt" {
  vpc_id = var.aws_vpc.id

  tags = {
    Name = private-rt
  }
}

# Route table association

resource "aws_route_table_association" "public-rta" {
  subnet_id = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "private-rta" {
  subnet_id = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private-rt.id
}

# Create security group 

resource "aws_security_group" "my-sg" {
  name = "my-sg"
    vpc_id = var.aws_vpc.id

    ingress {
      protocol = -1
      self = true
      from_port = 0
      to_port = 0
    }
    egress {
      from_port = 0
      to_port = 0
      protocol = -1
      cidr_blocks = ["0.0.0.0/0"]
    }
}



 
  