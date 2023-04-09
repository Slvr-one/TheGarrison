# K8s worker Instances:
resource "aws_instance" "worker" {
  count         = var.HA ? 3 : 1
  ami           = lookup(var.amis, var.region)
  instance_type = var.worker_instance_type

  subnet_id                   = var.k8s_subnet_id #module.network.k-subnet.id
  private_ip                  = cidrhost(var.vpc_cidr, 30 + count.index)
  associate_public_ip_address = true  # Instances have public, dynamic IP
  source_dest_check           = false # TODO Required??

  availability_zone      = var.zone
  vpc_security_group_ids = [var.k8s_sg_id]
  key_name               = var.keypair_name

  tags = {
    Name            = "worker-${count.index}"
    ansibleFilter   = var.ansibleFilter
    ansibleNodeType = "worker"
    ansibleNodeName = "worker${count.index}"

    Owner           = var.tags["Owner"]
    expiration_date = var.tags["expiration_date"]
    bootcamp        = var.tags["bootcamp"]
  }
}

output "kubernetes_workers_public_ip" {
  value = join(",", aws_instance.worker.*.public_ip)
}