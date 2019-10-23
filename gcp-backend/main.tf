terraform {  
  required_version  = "=0.12.3"

  backend "gcs" {
    bucket  = "env0-gcp-backend-state-bucket"
  }
}

resource "random_id" "id" {
  byte_length = 8
}

resource "google_bigquery_dataset" "dataset" {
  dataset_id                  = "env0-test-${random_id.id.dec}"
}