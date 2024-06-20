provider "google" {
  region = var.region
}

resource "google_compute_network" "vpc_network" {
  name                    = "${var.env}-vpc-network"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "subnetwork" {
  name          = "${var.env}-subnetwork"
  ip_cidr_range = var.ip_range
  region        = var.region
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_firewall" "firewall" {
  name    = "${var.env}-firewall"
  network = google_compute_network.vpc_network.id

  allow {
    protocol = "tcp"
    ports    = [var.port_range_ssh, var.port_range]
  }

  source_ranges = var.source_ranges
}


