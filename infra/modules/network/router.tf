# A Cloud Router to advertise routes.
# Used with the NAT gateway to allow VMs without public IP addresses, access to the internet.
resource "google_compute_router" "router" {
  name    = "router"
  region  = "us-central1"
  network = google_compute_network.main.id
}
