resource "google_cloudbuild_trigger" "dev-flask-app-build-trigger" {
  name            = "dev-tf-cloud-build-trigger-flask-app"
  description     = "DEV Cloud build trigger to rebuild Docker container for cloud run"
  github {
    owner         = "JAStark"
    name          = "gcp-cloud-run-flask-app"
    push {
      branch      = ".*"
      }
  }

  included_files  = ["./flask_app_cloud_run/Dockerfile", "./flask_app_cloud_run/requirements.txt", "./flask_app_cloud_run/main.py",]

  build {
    images = ["europe-west1-docker.pkg.dev/$PROJECT_ID/dev-gcp-cloud-run-flask-app-example/flask-endpoint-image:tag_1"]
    step {
      name        = "gcr.io/cloud-builders/docker"
      args        = ["build", "-f", "./flask_app_cloud_run/Dockerfile", "-t", "europe-west1-docker.pkg.dev/$PROJECT_ID/dev-gcp-cloud-run-flask-app-example/flask-endpoint-image:tag_1", "./flask_app_cloud_run" ]
      id          = "build & push flask_app_cloud_run image"
    }
  }
}


resource "google_cloud_run_service" "dev-flask-app-cloud-run" {
  name      = "dev-flask-app-cloud-run-service"
  location  = "europe-west1"

  template {
    spec {
      container_concurrency = 80
      timeout_seconds       = 300
      containers {
        image = "europe-west1-docker.pkg.dev/${var.project_id}/dev-gcp-cloud-run-flask-app-example/flask-endpoint-image:tag_1"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  depends_on = [google_cloudbuild_trigger.dev-flask-app-build-trigger]
}
