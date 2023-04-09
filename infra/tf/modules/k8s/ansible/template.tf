
resource "local_file" "ansible_inventory" {

  content = templatefile("${path.module}/templates/ansible_inventory.tftpl",
    {
      user        = "ubuntu"
      prefix      = "k8s"
      controllers = var.controllers
      workers     = var.workers
    }
  )

  filename        = "${path.module}/inventory.ini"
  file_permission = 644
}