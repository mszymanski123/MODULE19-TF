project_id = "playground-s-11-f2127101"
region     = "us-east1"
env        = "test"
size       = "e2-medium"
vmimage    = "debian-cloud/debian-10"
script     = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y apache2
    echo '<!DOCTYPE html><html><body><h1>Hello from $(hostname)</h1></body></html>' > /var/www/html/index.html
    systemctl restart apache2
  EOF
port_range = "80"
ip_protocol = "TCP"
ip_range   = "10.0.0.0/16"
port_range_ssh = "22"
source_ranges = ["0.0.0.0/0"]
