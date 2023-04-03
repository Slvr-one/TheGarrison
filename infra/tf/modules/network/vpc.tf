# vpc:
resource "aws_vpc" "k8s" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name

    Owner           = var.tags["Owner"]
    expiration_date = var.tags["expiration_date"]
    bootcamp        = var.tags["bootcamp"]
  }
}

# DHCP Options (not required, identical to Default Option):
resource "aws_vpc_dhcp_options" "dns_resolver" {
  domain_name         = "${var.region}.compute.internal"
  domain_name_servers = ["AmazonProvidedDNS"]

  tags = {
    Name = var.vpc_name

    Owner           = var.tags["Owner"]
    expiration_date = var.tags["expiration_date"]
    bootcamp        = var.tags["bootcamp"]
  }
}

resource "aws_vpc_dhcp_options_association" "dns_resolver" {
  vpc_id          = aws_vpc.k8s.id
  dhcp_options_id = aws_vpc_dhcp_options.dns_resolver.id
}

# Keypair:
resource "aws_key_pair" "default_keypair" {
  key_name   = var.keypair_name
  public_key = var.keypair_public_key
}

# Routing:
resource "aws_route_table" "k8s" {
  vpc_id = aws_vpc.k8s.id

  # Default route through Internet Gateway
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "kubernetes"

    Owner           = var.tags["Owner"]
    expiration_date = var.tags["expiration_date"]
    bootcamp        = var.tags["bootcamp"]
  }
}

resource "aws_route_table_association" "k8s" {
  subnet_id      = aws_subnet.k8s.id
  route_table_id = aws_route_table.k8s.id
}

