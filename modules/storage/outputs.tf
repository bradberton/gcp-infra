output "bucket_name" {
  value = google_storage_bucket.bucket.name
}

output "bucket_location" {
  value = google_storage_bucket.bucket.location
}
