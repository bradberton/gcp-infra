variable "project_id" {
  description = "GCP project ID"
  type 		  = string
  default     = "us-central1"
}

variable "region" {
  description = "GCP region"
  type 		  = string
  default     = "us-central1"
}

variable "machine_type" {
  description = "Type of machine to deploy"
  type 		  = string
  default     = "e2-standard-4"
}

variable "zone" {
  description = "GCP zone"
  type 		  = string
  default     = "us-west1-a"
}

variable "bucket_name" {
  description = "Name of the Cloud Storage bucket"
  type 		  = string
  default     = "tf-bucket-958948"
}

variable "storage_location" {
  description = "Location of the Cloud Storage bucket"
  type 		  = string
  default     = "US"
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "tf-vpc-755400"
}

