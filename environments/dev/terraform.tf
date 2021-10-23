terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "~> 3.89.0"
    }
  }
  backend "gcs" {
    bucket = "flask-app-tfstate"
    prefix = "env/dev"
  }
}

provider "google" {
  # Configuration options
  project = "silver-antonym-326607"
  region  = "europe-west2"

}
