### VPC Network Setup
resource "aws_vpc" "main" {
  # must have DNS hostname and DNS resolution support for worker nodes to register with the cluster

  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    # Name            = format("main_%s", var.env)
    Owner           = var.tags["Owner"]
    expiration_date = var.tags["expiration_date"]
    bootcamp        = var.tags["bootcamp"]

    Name                                            = "${var.vpc_tag_name}"
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
  }
  # global_tags = {
  #   Name                                            = "${var.vpc_tag_name}"
  #   "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
  # }
}

# Create the private subnet
resource "aws_subnet" "private_subnet" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.private_subnet_cidr_blocks, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name                                            = "${var.private_subnet_tag_name}"
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared" #"owned"
    "kubernetes.io/role/internal-elb"               = 1
  }
}

# Create the public subnet
resource "aws_subnet" "public_subnet" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.public_subnet_cidr_blocks, count.index)
  availability_zone = element(var.availability_zones, count.index)

  map_public_ip_on_launch = true

  tags = {
    Name                                            = "${var.public_subnet_tag_name}"
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
    "kubernetes.io/role/elb"                        = 1
  }
}

# Create IGW for the public subnets
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.vpc_tag_name}"
  }
}

# Route the public subnet traffic through the IGW
resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.route_table_tag_name}"
  }
}

# Route table and subnet associations
resource "aws_route_table_association" "internet_access" {
  count          = length(var.availability_zones)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.main.id
}