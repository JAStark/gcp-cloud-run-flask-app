resource "google_cloudbuild_trigger" "prod-flask-app-filename-trigger" {
  name            = "prod-tf-cloud-build-trigger-flask-app"
  description     = "PROD Cloud build trigger to rebuild Docker container for cloud run for the
                    learning project integrating terraform, build, run, and endpoints"
  github {
    name          = "gcp-cloud-run-flask-app"
    push          = ".*"
  }

  filename        = "./flask_app_cloud_run/Dockerfile"
  included_files  = "./flask_app_cloud_run/*"

  build {
    images = ["europe-west1-docker.pkg.dev/$PROJECT_ID/gcp-cloud-run-flask-app-test/flask-test-image:tag1"]
    step {
      name        = "gcr.io/cloud-builders/docker"
      args        = ["build", "t", 'europe-west1-docker.pkg.dev/$PROJECT_ID/gcp-cloud-run-flask-app-test/flask-test-image:tag1', '.']
      id          = "build docker image for flask_app_cloud_run"
      wait_for    = "tf plan"
    }
  }
}


resource "google_cloud_run_service" "prod-flask-app-cloud-run" {
  name      = "prod-flask-app-cloud-run-service"
  location  = "europe-west1"

  template {
    spec {
      containers {
        image = "europe-west1-docker.pkg.dev/$PROJECT_ID/gcp-cloud-run-flask-app-test/flask-test-image:tag1"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}
