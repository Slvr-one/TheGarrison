output "vpc" {
  value = google_compute_network.main.self_link
}

output "private_subnet" {
  value = google_compute_subnetwork.private.self_link
}