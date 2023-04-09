
resource "local_file" "ansible_inventory" {
  filename = "${path.module}/inventory.ini"
  content = templatefile("${path.module}/templates/ansible_inventory.tftpl",
    {
      user        = "root"
      prefix      = "k8s"
      controllers = var.controllers
      workers     = var.workers
    }
  )
}