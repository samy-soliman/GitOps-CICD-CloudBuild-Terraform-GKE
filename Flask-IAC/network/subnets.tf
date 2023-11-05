resource "google_compute_subnetwork" "management_subnet" {
  name          = "management-subnetwork"
  ip_cidr_range = "10.0.0.0/24"
  region        = "us-east1"
  network       = google_compute_network.mongo_vpc.id
  depends_on = [google_compute_network.mongo_vpc]
}

resource "google_compute_subnetwork" "workload_subnet" {
  name          = "workload-subnetwork"
  ip_cidr_range = "10.1.0.0/24"
  region        = "us-central1"
  network       = google_compute_network.mongo_vpc.id
  secondary_ip_range {
    range_name    = "gke-secondary-range"
    ip_cidr_range = "10.2.0.0/24"
  }
  depends_on = [google_compute_network.mongo_vpc]
}