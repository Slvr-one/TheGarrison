# control planes - sg:
resource "aws_security_group" "k8s_api" {
  vpc_id = aws_vpc.k8s.id
  name   = "k8s-api"

  # Allow inbound traffic to the port used by K8s API HTTPS
  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "TCP"
    cidr_blocks = ["${var.control_cidr}"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, 
    {
      Name = "kubernetes-api" ##????
    }
  )
}