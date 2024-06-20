terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

module "network" {
  source = "./network"
  project_id = var.project_id
  region     = var.region
  ip_cidr_range = var.ip_range
  source_ranges = var.source_ranges
}

module "compute" {
  source = "./compute"
  project_id = var.project_id
  region     = var.region
  machine_type = var.size
  port_range  = var.port_range
  ip_protocol = var.ip_protocol
  network    = module.network.network
  subnetwork = module.network.subnetwork
  firewall   = module.network.firewall
}



