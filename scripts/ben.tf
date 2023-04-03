 # Create Master
resource "digitalocean_droplet" "kube-master" {
  image         = "117732073"
  name          = "kube-master"
  region        = "ams3"
  size          = "s-2vcpu-4gb-intel"
  ssh_keys      = [36249860]
  user_data     = file("kickstart")
  droplet_agent = false
  vpc_uuid      = "bbd88285-7742-4609-8cb9-aa187d4907c8"
  resize_disk   = false
  ipv6          = false
  tags          = ["k8s", "internal"]
  lifecycle {
    ignore_changes = [user_data]
  }
}

 # Create Droplet
resource "digitalocean_droplet" "kube-node" {
  image         = "117732073"
  name          = "kube-node-${count.index}"
  region        = "ams3"
  size          = "s-8vcpu-16gb"
  ssh_keys      = [36249860]
  user_data     = file("kickstart")
  droplet_agent = false
  vpc_uuid      = "bbd88285-7742-4609-8cb9-aa187d4907c8"
  resize_disk   = false
  ipv6          = false
  count         = 3
  tags          = ["k8s", "internal", "kube-node"]
  lifecycle {
    ignore_changes  = [user_data]
    prevent_destroy = true

  }
  depends_on = [digitalocean_droplet.kube-master]
}

resource "local_file" "ansible_inventory" {
  content = templatefile("inventory.tmpl",
    {
      kube_master = digitalocean_droplet.kube-master.*.ipv4_address
      kube_nodes  = digitalocean_droplet.kube-node.*.ipv4_address
    }
  )
  filename = "inventory"
}