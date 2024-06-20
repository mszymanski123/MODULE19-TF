provider "google" {
  region = var.region
  zone = var.zone
}

resource "google_compute_instance" "temp_vm" {
  name         = "${var.env}-vm"
  machine_type = var.size
  zone         = "${var.region}-a"

  boot_disk {
    initialize_params {
      image = var.vmimage
    }
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnetwork
    access_config {
      // Ephemeral IP
    }
  }

  metadata_startup_script = var.script
}

resource "google_compute_image" "app_image" {
  name       = "${var.env}-app-image"
  source_disk = google_compute_instance.temp_vm.boot_disk[0].source
  source_disk_zone = google_compute_instance.temp_vm.zone
}

resource "google_compute_instance_group" "instance_group" {
  name        = "${var.env}-instance-group"
  zone        = "${var.region}-a"
  base_instance_name = "${var.env}-app-instance"
  size        = 3

  instance_template = google_compute_instance_template.app_template.self_link
}

resource "google_compute_instance_template" "app_template" {
  name         = "${var.env}app-template"
  machine_type = var.size

  disk {
    source_image = google_compute_image.app_image.self_link
    auto_delete  = true
    boot         = true
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnetwork
    access_config {
      // Ephemeral IP
    }
  }
}

resource "google_compute_target_pool" "target_pool" {
  name = "${var.env}-target-pool"
  instances = google_compute_instance_group.instance_group.instances
}

resource "google_compute_forwarding_rule" "forwarding_rule" {
  name        = "${var.env}-forwarding-rule"
  region      = var.region
  target      = google_compute_target_pool.target_pool.self_link
  port_range  = var.port_range
  ip_protocol = var.ip_protocol
}

resource "google_compute_health_check" "health_check" {
  name               = "${var.env}-health-check"
  check_interval_sec = 10
  timeout_sec        = 5
  healthy_threshold  = 2
  unhealthy_threshold = 2

  http_health_check {
    request_path = "/"
    port         = 80
  }
}



