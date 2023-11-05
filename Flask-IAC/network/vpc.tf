# VPC network is a global entity spanning all GCP regions
resource "google_compute_network" "mongo_vpc" {
    name = "mongo-vpc"
    auto_create_subnetworks = false
    project = var.project_id
}