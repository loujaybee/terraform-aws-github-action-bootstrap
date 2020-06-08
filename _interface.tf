# --------------------------------
# Inputs
# --------------------------------

variable "region" {
  description = "The region to build the AWS resources in"
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block used for the VPC"
  type        = string
}

variable "subnet_count" {
  description = "The amount of subnets being created"
  type        = number
}

variable "instance_type" {
  description = "The type of instance, e.g. t2.micro"
  type        = string
}


# --------------------------------
# Outputs
# --------------------------------

output "vpc_cidr" {
  description = "The CIDR block used for the VPC"
  value       = aws_vpc.cr_vpc.cidr_block
}

output "vpc_id" {
  description = "The ID generated for the VPC"
  value       = aws_vpc.cr_vpc.id
}

output "subnet_cidr" {
  description = "The CIDR block generated for the subnet"
  value       = aws_subnet.cr_public_subnet[*].cidr_block
}

output "subnet_id" {
  description = "The ID generated for the subnet"
  value       = aws_subnet.cr_public_subnet[*].id
}