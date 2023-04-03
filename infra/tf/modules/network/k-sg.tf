
# cluster - sg:
resource "aws_security_group" "k8s" {
  vpc_id = aws_vpc.k8s.id
  name   = "k8s"

  # Allow all outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow ICMP from control host IP
  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["${var.control_cidr}"]
  }

  # Allow all internal
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  # Allow all traffic from the API ELB
  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = ["${aws_security_group.k8s_api.id}"]
  }

  # Allow all traffic from control host IP
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.control_cidr}"]
  }

  tags = {
    Name = "kubernes"

    Owner           = var.tags["Owner"]
    expiration_date = var.tags["expiration_date"]
    bootcamp        = var.tags["bootcamp"]
  }
}