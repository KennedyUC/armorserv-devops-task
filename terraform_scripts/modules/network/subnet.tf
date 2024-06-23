data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  az_zones = slice(data.aws_availability_zones.available.names, 0, var.az_count)
}

resource "aws_subnet" "public_subnets" {
  count = var.az_count

  availability_zone       = element(local.az_zones, count.index)
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, var.subnet_bits, count.index)
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = true

  depends_on = [aws_vpc.vpc]

  tags = {
    Name = "${var.project_name}-${var.env}-public-${count.index}"
    Env  = var.env
  }
}

resource "aws_subnet" "private_subnets" {
  count = var.az_count

  availability_zone       = element(local.az_zones, count.index)
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, var.subnet_bits, count.index + var.az_count)
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = false

  depends_on = [aws_vpc.vpc]

  tags = {
    Name = "${var.project_name}-${var.env}-private-${count.index}"
    Env  = var.env
  }
}