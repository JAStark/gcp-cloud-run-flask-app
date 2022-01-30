resource "google_cloudbuild_trigger" "dev-flask-app-filename-build-trigger" {
  name            = "dev-tf-cloud-build-filename-trigger-flask-app"
  description     = "DEV Cloud build trigger to rebuild Docker container for cloud run"
  github {
    owner         = "JAStark"
    name          = "gcp-cloud-run-flask-app"
    push {
      branch      = "^dev$"
      }
  }

  included_files  = ["flask_app_cloud_run/**"]
  filename        = "flask_app_cloud_run/cloudbuild.yaml"

  # build {
  #   images = ["europe-west1-docker.pkg.dev/$PROJECT_ID/dev-gcp-cloud-run-flask-app-example/flask-endpoint-image:$SHORT_SHA"]
  #   step {
  #     name        = "gcr.io/cloud-builders/docker"
  #     args        = ["build", "-f", "./flask_app_cloud_run/Dockerfile", "-t", "europe-west1-docker.pkg.dev/$PROJECT_ID/dev-gcp-cloud-run-flask-app-example/flask-endpoint-image:$SHORT_SHA", "./flask_app_cloud_run" ]
  #     id          = "build & push flask_app_cloud_run image"
  #   }
  # }
}

# resource "google_endpoints_service" "openapi_service" {
#   service_name   = "api-name.endpoints.project-id.cloud.goog"
#   project        = var.project_id
#   openapi_config = file("openapi_spec.yml")
# }

# resource "google_cloud_run_service" "dev-flask-app-cloud-run" {
#   name      = "dev-flask-app-cloud-run-service"
#   location  = "europe-west1"
#   project = var.project_id
#
#   template {
#     spec {
#       container_concurrency = 80
#       timeout_seconds       = 300
#       containers {
#         image = "europe-west1-docker.pkg.dev/${var.project_id}/dev-gcp-cloud-run-flask-app-example/flask-endpoint-image:$SHORT_SHA"
#       }
#     }
#   }
#
#   traffic {
#     percent         = 100
#     latest_revision = true
#   }
#
#   depends_on = [google_cloudbuild_trigger.dev-flask-app-build-trigger]
# }

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
#   location    = google_cloud_run_service.dev-flask-app-cloud-run.location
#   project     = google_cloud_run_service.dev-flask-app-cloud-run.project
#   service     = google_cloud_run_service.dev-flask-app-cloud-run.name
#
#   policy_data = data.google_iam_policy.noauth.policy_data
# }


# resource "null_resource" "dev-deploy-latest-cloud-run-revision" {
#   depends_on = [google_cloudbuild_trigger.dev-flask-app-build-trigger]
#
#   provisioner "local-exec" {
#     command = <<EOF
#     "gcloud run deploy dev-flask-app-cloud-run-service \
#            --image=europe-west1-docker.pkg.dev/${var.project_id}/dev-gcp-cloud-run-flask-app-example/flask-endpoint-image:$SHORT_SHA,
#            --region europe-west1,
#            --platform managed',
#            --allow-unauthenticated"
# EOF
#
#   }
# }


# module "cli" {
#   source = "../.."
#
#   platform              = "linux"
#   additional_components = ["kubectl", "beta"]
#
#   create_cmd_body  = "services enable youtube.googleapis.com --project ${var.project_id}"
#   destroy_cmd_body = "services disable youtube.googleapis.com --project ${var.project_id}"
#
#   module_depends_on = [
#     module.hello.wait,
#     module.two.wait
#   ]
# }
