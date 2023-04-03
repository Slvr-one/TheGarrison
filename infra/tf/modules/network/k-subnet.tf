# Subnet (public):
resource "aws_subnet" "k8s" {
  vpc_id            = aws_vpc.k8s.id
  cidr_block        = var.vpc_cidr
  availability_zone = var.zone

  tags = {
    Name = "kubernetes"

    Owner           = var.tags["Owner"]
    expiration_date = var.tags["expiration_date"]
    bootcamp        = var.tags["bootcamp"]
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.k8s.id
  tags = {
    Name = "kubernetes"

    Owner           = var.tags["Owner"]
    expiration_date = var.tags["expiration_date"]
    bootcamp        = var.tags["bootcamp"]
  }
}