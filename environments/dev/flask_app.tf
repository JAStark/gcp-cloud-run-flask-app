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

}

resource "google_endpoints_service" "openapi_service" {
  service_name   = "api-name.endpoints.project-id.cloud.goog"
  project        = var.project_id
  openapi_config = file("openapi_spec.yml")
}
