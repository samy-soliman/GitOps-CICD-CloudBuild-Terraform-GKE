resource "google_compute_router" "management_subnet_router" {
  name    = "management-subnet-router"
  region  = "us-east1"
  network = google_compute_network.mongo_vpc.id 
  bgp {
    asn               = 64514
    advertise_mode    = "DEFAULT"
  }
}

resource "google_compute_router_nat" "management_subnet_nat" {
  name                               = "management-subnet-nat"
  router                             = google_compute_router.management_subnet_router.name
  region                             = google_compute_router.management_subnet_router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}