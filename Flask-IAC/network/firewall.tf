resource "google_compute_firewall" "ssh_firewall" {
  name    = "iap-allow"
  network = google_compute_network.mongo_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"] # Add more ports as needed
  }

  source_ranges = ["35.235.240.0/20"]  # IAP ip range

}



