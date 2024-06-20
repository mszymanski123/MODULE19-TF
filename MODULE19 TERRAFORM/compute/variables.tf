variable "project_id" {
  description = "The ID of the GCP project."
}

variable "region" {
  description = "The region in which to create resources."
}

variable "network" {
  description = "The network to deploy instances in."
}

variable "subnetwork" {
  description = "The subnetwork to deploy instances in."
}

variable "firewall" {
  description = "The firewall to allow access."
}
