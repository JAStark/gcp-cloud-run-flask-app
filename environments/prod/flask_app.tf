resource "google_cloudbuild_trigger" "prod-flask-app-filename-build-trigger" {
  name            = "prod-tf-cloud-build-filename-trigger-flask-app"
  description     = "PROD Cloud build trigger to rebuild Docker container for cloud run"
  github {
    owner         = "JAStark"
    name          = "gcp-cloud-run-flask-app"
    push {
      branch      = "^prod$"
      }
  }

  included_files  = ["flask_app_cloud_run/**"]
  filename        = "flask_app_cloud_run/cloudbuild.yaml"

  # build {
  #   images = ["europe-west1-docker.pkg.dev/$PROJECT_ID/prod-gcp-cloud-run-flask-app-example/flask-endpoint-image:$SHORT_SHA"]
  #   step {
  #     name        = "gcr.io/cloud-builders/docker"
  #     args        = ["build", "-f", "./flask_app_cloud_run/Dockerfile", "-t", "europe-west1-docker.pkg.dev/$PROJECT_ID/prod-gcp-cloud-run-flask-app-example/flask-endpoint-image:$SHORT_SHA", "./flask_app_cloud_run"]
  #     id          = "build & push flask_app_cloud_run image"
  #   }
  # }
}

# resource "google_endpoints_service" "openapi_service" {
#   service_name   = "api-name.endpoints.project-id.cloud.goog"
#   project        = var.project_id
#   openapi_config = file("openapi_spec.yml")
# }

# resource "google_cloud_run_service" "prod-flask-app-cloud-run" {
#   name      = "prod-flask-app-cloud-run-service"
#   location  = "europe-west1"
#   project = var.project_id
#
#   template {
#     spec {
#       container_concurrency = 80
#       timeout_seconds       = 300
#       containers {
#         image = "europe-west1-docker.pkg.dev/${var.project_id}/prod-gcp-cloud-run-flask-app-example/flask-endpoint-image:$SHORT_SHA"
#       }
#     }
#   }
#
#   traffic {
#     percent         = 100
#     latest_revision = true
#   }
#
#   depends_on = [google_cloudbuild_trigger.prod-flask-app-build-trigger]
# }
#
# data "google_iam_policy" "noauth" {
#   binding {
#     role = "roles/run.invoker"
#     members = [
#       "allUsers",
#     ]
#   }
# }
#
# resource "google_cloud_run_service_iam_policy" "noauth" {
#   location    = google_cloud_run_service.prod-flask-app-cloud-run.location
#   project     = google_cloud_run_service.prod-flask-app-cloud-run.project
#   service     = google_cloud_run_service.prod-flask-app-cloud-run.name
#
#   policy_data = data.google_iam_policy.noauth.policy_data
# }
