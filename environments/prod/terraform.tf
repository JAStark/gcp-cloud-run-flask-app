terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "~> 3.89.0"
    }
  }
  backend "gcs" {
    bucket = "flask-app-tfstate"
    prefix = "env/prod"
  }
}

provider "google" {
  # Configuration options
  project = "silver-antonym-326607"
  region  = "europe-west2"

}

resource "google_artifact_registry_repository" "prod-flask-app-cloud-run-repo"     {
  provider      = google-beta

  project       = "silver-antonym-326607"
  location      = "europe-west1"
  repository_id = "prod-gcp-cloud-run-flask-app-example"
  description   = "tf-created repo for flask with endpoints example"
  format        = "DOCKER"
}
