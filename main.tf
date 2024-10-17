terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.0.0"  # Ensure the correct provider version
    }
  }
  #backend "gcs" {
  #  bucket  = "tf-bucket-958948"
  #  prefix  = "terraform/state"
  #}
    backend "local" {
    path = "terraform/state/terraform.tfstate"  # Store the state file locally
  }
}

#command change terraform init from local to cloud gcp
#terraform init -migrate-state 

provider "google" {
  project = var.project_id
  region  = var.region
}

# Create a VPC with global routing mode
resource "google_compute_network" "vpc" {
  name                    = "tf-vpc-755400"
  auto_create_subnetworks = false
  routing_mode            = "GLOBAL"  # Use global routing mode
}

# Create subnet-01
resource "google_compute_subnetwork" "subnet_01" {
  name          = "subnet-01"
  ip_cidr_range = "10.10.10.0/24"
  network       = google_compute_network.vpc.id
  region        = var.region
}

# Create subnet-02
resource "google_compute_subnetwork" "subnet_02" {
  name          = "subnet-02"
  ip_cidr_range = "10.10.20.0/24"
  network       = google_compute_network.vpc.id
  region        = var.region
}

resource "google_compute_firewall" "tf-firewall" {
  name    = "tf-firewall"
  network = var.vpc_name  # Pass VPC name as a variable

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]  # Allow traffic from all IPs
}

#Command terrafrom import 
#terraform import module.instances-1.google_compute_instance.vm_instance qwiklabs-gcp-04-ad2fc8cc3dae/us-west1-a/tf-instance-1
#terraform import module.instances-2.google_compute_instance.vm_instance qwiklabs-gcp-04-ad2fc8cc3dae/us-west1-a/tf-instance-2


# Call instances module
module "instances-1" {
  source        = "./modules/instances"
  instance_name = "tf-instance-1"  # Unique name for the instance
  #machine_type  = var.machine_type
  #zone          = var.zone
  network_name  = "default"  #Later change to Connect to "network-1"
  #subnet_name   = "subnet-01"      # Subnet within the VPC
}

module "instances-2" {
  source        = "./modules/instances"
  instance_name = "tf-instance-2"  # Unique name for the second instance
  #machine_type  = var.machine_type
  #zone          = var.zone
  network_name  = "default"  #Later change to Connect to "network-1"
  #subnet_name   = "subnet-02"      # Subnet within the VPC
}


#Call storage module
module "storage" {
  source      = "./modules/storage"
  bucket_name = var.bucket_name
  location    = var.storage_location
}

