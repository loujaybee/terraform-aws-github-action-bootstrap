/*



data "aws_availability_zones" "available" {}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = "${
    map(
     "Name", "cloud9",
    )
  }"
}

resource "aws_subnet" "main" {
  count = 1

  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  cidr_block        = "10.0.${count.index}.0/24"
  vpc_id            = aws_vpc.main.id

  tags = "${
    map(
     "Name", "cloud9",
    )
  }"
}

resource "aws_cloud9_environment_ec2" "default" {
  name                        = var.name
  instance_type               = var.instance_type
  automatic_stop_time_minutes = var.automatic_stop_time_minutes
  description                 = var.description
  subnet_id                   = aws_subnet.main.*.id[0]
} */
