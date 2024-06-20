output "network" {
  value = google_compute_network.vpc_network.id
}

output "subnetwork" {
  value = google_compute_subnetwork.subnetwork.id
}

output "firewall" {
  value = google_compute_firewall.firewall.name
}
