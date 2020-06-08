provider "aws" {
  version = "~> 2.0"
  region  = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "terraform-state-file1"
    key    = "default-infrastructure"
    region = "us-east-1"
  }
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-state-file1"

  versioning {
    enabled = true
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

# VPC configuration

# Create VPC

resource "aws_vpc" "cr_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "cr_vpc"
  }
}

# Create Internet Gateway

resource "aws_internet_gateway" "cr_internet_gateway" {
  vpc_id = aws_vpc.cr_vpc.id

  tags = {
    Name = "cr_igw"
  }
}

# Create Public Route Table

resource "aws_route_table" "cr_public_rt" {
  vpc_id = aws_vpc.cr_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.cr_internet_gateway.id
  }

  tags = {
    Name = "cr_rt"
  }
}

# Create Subnet

resource "aws_subnet" "cr_public_subnet" {
  count                   = var.subnet_count
  vpc_id                  = aws_vpc.cr_vpc.id
  cidr_block              = cidrsubnet(aws_vpc.cr_vpc.cidr_block, 8, count.index)
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "cr_public"
  }
}

# Asscociate Subnet

resource "aws_route_table_association" "cr_public_assoc" {
  subnet_id      = aws_subnet.cr_public_subnet[0].id
  route_table_id = aws_route_table.cr_public_rt.id
}

# Create Public SG

resource "aws_security_group" "cr_sg" {
  name   = "cr_sg"
  vpc_id = aws_vpc.cr_vpc.id

  # SSH Linux - open to the Cloudreach VPN

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["176.34.130.192/32"]
  }

  # RDP Windows - open to the Cloudreach VPN

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["176.34.130.192/32"]
  }

  # HTTP

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Get the latest Linux AMI published by Amazon

data "aws_ami" "linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["suse-sles-15-v*-hvm-ssd-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

# Create EC2 Instance

resource "aws_instance" "cr_instance" {
  instance_type = var.instance_type
  ami           = data.aws_ami.linux.id

  tags = {
    Name = "cr_terraform"
  }

  vpc_security_group_ids = [aws_security_group.cr_sg.id]
  subnet_id              = aws_subnet.cr_public_subnet[0].id
}

