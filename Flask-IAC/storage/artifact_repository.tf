resource "google_artifact_registry_repository" "mongo_registry" {
  location      = "us-east1"
  repository_id = "mongo-registry"
  description   = "monogo registry"
  format        = "DOCKER"
}