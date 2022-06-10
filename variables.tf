variable "aws_region" {
 type = string
 description = "Used AWS Region."
}

variable "environment" {
  type = string
  description = "Production or Development setting"
}
variable "name" {
  description = "The name of the environment"
}

variable "instance_type" {
  description = "The type of instance to connect to the environment"
  default     = "t2.micro"
}

variable "automatic_stop_time_minutes" {
  description = "Minutes until the instance is shut down after inactivity"
  default     = 30
}

variable "description" {
  description = "The description of the environment"
}
variable "instance_id" {
  description = "Instance OS - see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloud9_environment_ec2#image_id"
  default     = "amazonlinux-1-x86_64"
}

variable "image_id" {
  description = "(Optional) The identifier for the Amazon Machine Image (AMI) that's used to create the EC2 instance."
  type        = string
  default     = "resolve:ssm:/aws/service/cloud9/amis/amazonlinux-2-x86_64"
  validation {
    condition = contains([
      "amazonlinux-1-x86_64",
      "amazonlinux-2-x86_64",
      "ubuntu-18.04-x86_64",
      "resolve:ssm:/aws/service/cloud9/amis/amazonlinux-1-x86_64",
      "resolve:ssm:/aws/service/cloud9/amis/amazonlinux-2-x86_64",
      "resolve:ssm:/aws/service/cloud9/amis/ubuntu-18.04-x86_64"
    ], var.image_id)
    error_message = "ImageId invalid. Please choose a valid image_id."
  }
}
variable "connection_type" {
  description = "(Optional) The connection type used for connecting to an Amazon EC2 environment. Valid values are CONNECT_SSH and CONNECT_SSM."
  type        = string
  default     = "CONNECT_SSH"
}