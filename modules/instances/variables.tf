#variable "instance_name" {
#  description = "Name of the instance"
#}

variable "machine_type" {
  description = "Type of the Compute Engine instance"
  type 		  = string
  default     = "e2-standard-2"
}

variable "zone" {
  description = "GCP zone where the instance will be deployed"
  type 		  = string
  default     = "us-west1-a"
}

variable "instance_name" {  # Fixed the syntax here
  description = "Name of the Instance"
  type        = string
}

variable "network_name" {  # New variable for network name
  description = "Name of the network to connect the instance"
  type        = string
}

variable "subnet_name" {
  description = "Name of the subnet in the VPC"
  type        = string
}