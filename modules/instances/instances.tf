resource "google_compute_instance" "vm_instance" {
  name         = var.instance_name  # Use the passed instance name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = var.network_name  # You can also pass this as a variable if needed
	#subnetwork = var.subnet_name    # Use the passed subnet name
    access_config {}
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
	apt-get update;
  EOT

  allow_stopping_for_update = true
}