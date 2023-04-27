
locals {
    ansible_dest = "dvir/ansible"
    ssh_user = "ubuntu"
    private_ssh_key = "/home/ubuntu/.ssh/kp-one.pem"
}

resource "null_resource" "ansible_run" {
  
  triggers = {
    always_run = timestamp()
    # master_ready = element(aws_instance.ansible_master.*.public_ip, 0)
  }

  depends_on = [
    aws_instance.ansible_master
  ]

  connection {
    type        = "ssh"
    host        = element(aws_instance.ansible_master.*.public_ip, 0)
    user        = "ubuntu"
    timeout     = "4m"
    private_key =  var.ssh_private_key
    # private_key = file("~/.ssh/id_rsa")
  }

  provisioner "remote-exec" { # setup 
    inline = [
      "mkdir -p /home/ubuntu/{${local.ansible_dest}, .ssh} ",
      "sudo apt update -qqy",
      "sudo apt-add-repository -y --update ppa:ansible/ansible",
      "sudo apt install -qqy ansible tree curl software-properties-common",
    #   "echo '[kube-master]' > hosts",
    #   "echo '${element(aws_instance.ansible_master.*.private_ip, 0)}' >> hosts"
    # #   "echo '[kube-worker]' >> hosts",
    # #   "for i in ${var.workers.private_ip}; do echo $i >> hosts; done",
    ]
  }

#   provisioner "file" {
#     source      = local_file.ansible_inventory.filename
#     destination = "${local.ansible_dest}/inventort.ini"

#   }

  provisioner "file" { # copy dir of ansible roles, main playbook & inventory
    source      = "${path.module}/ansible_config"
    destination = "${local.ansible_dest}/"

  }

  provisioner "remote-exec" { # check everything is in place
    inline = [
      "pwd && ls -alF '${local.ansible_dest}' && tree '${local.ansible_dest}'"
    ]
  }

  provisioner "remote-exec" { # run ansible playbook
    inline = [
      "sudo chmod 777 '${local.ansible_dest}/ansible_config/inventory.ini'",
      "sudo cp '${local.ansible_dest}/ansible_config/ansible.cfg' /etc/ansible/ansible.cfg",
    #   "echo ${var.ssh_private_key} > ${local.private_ssh_key}",
      "ansible-playbook -i '${local.ansible_dest}/ansible_config/inventory.ini' '${local.ansible_dest}/ansible_config/install_kubernetes.yaml' --user ${local.ssh_user}" # --key-file ${local.private_ssh_key}
    ]
  }

}
 
 