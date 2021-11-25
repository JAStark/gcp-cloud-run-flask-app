resource "google_cloudbuild_trigger" "prod-flask-app-filename-trigger" {
  name            = "prod-tf-cloud-build-trigger-flask-app"
  description     = "PROD Cloud build trigger to rebuild Docker container for cloud run"
  github {
    owner         = "JAStark"
    name          = "gcp-cloud-run-flask-app"
    push {
      branch      = ".*"
      }
  }

  included_files  = ["./flask_app_cloud_run/Dockerfile", "./flask_app_cloud_run/requirements.txt", "./flask_app_cloud_run/main.py",]

  build {
    images = ["europe-west1-docker.pkg.dev/$PROJECT_ID/prod-gcp-cloud-run-flask-app-example/flask-endpoint-image:$SHORT_SHA"]
    step {
      name        = "gcr.io/cloud-builders/docker"
      args        = ["build", "t", "europe-west1-docker.pkg.dev/$PROJECT_ID/prod-gcp-cloud-run-flask-app-example/flask-endpoint-image:$SHORT_SHA", "./flask_app_cloud_run/Dockerfile"]
      id          = "build docker image for flask_app_cloud_run"
      # wait_for    = ["tf plan"]
    }
  }
}


# resource "google_cloud_run_service" "prod-flask-app-cloud-run" {
#   name      = "prod-flask-app-cloud-run-service"
#   location  = "europe-west1"
#
#   template {
#     spec {
#       containers {
#         image = "europe-west1-docker.pkg.dev/$PROJECT_ID/prod-gcp-cloud-run-flask-app-example/flask-endpoint-image:$SHORT_SHA"
#       }
#     }
#   }
#
#   traffic {
#     percent         = 100
#     latest_revision = true
#   }
# }
