# # terraform/ansible-inventory.tf

# resource "local_file" "ansible_inventory" {
#   content = templatefile("${path.module}/inventory.ini.tpl", {
#     node_private_ips = aws_instance.k8s_node.*.private_ip
#   })

#   filename = "${path.module}/inventory.ini"
# }