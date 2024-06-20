output "instance_group" {
  value = google_compute_instance_group.instance_group.self_link
}

output "load_balancer_ip" {
  value = google_compute_forwarding_rule.forwarding_rule.ip_address
}
