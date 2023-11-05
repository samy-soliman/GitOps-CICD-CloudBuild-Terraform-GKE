resource "google_service_account" "compute_instance_service_account" {
  account_id   = "compute-instance"
  display_name = "compute instance"
}

resource "google_project_iam_member" "artifact_admin_iam_vm" {
  project = var.project_id
  role  = "roles/artifactregistry.admin"
  member = "serviceAccount:${google_service_account.compute_instance_service_account.email}"
}

resource "google_project_iam_member" "container_admin_iam_service_account" {
  project = var.project_id
  role    = "roles/container.admin"
  member  = "serviceAccount:${google_service_account.compute_instance_service_account.email}"
}


resource "google_compute_instance" "management_vm" {
  name         = "management-vm"
  machine_type = var.machine_type
  zone         = var.management_vm_subnet_zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"    # other type "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  network_interface {
    subnetwork = var.management_vm_subnetwork_interface
    #access_config {// Ephemeral public IP}
  }

  service_account {
    email  = google_service_account.compute_instance_service_account.email
    scopes = ["cloud-platform"]
  }


  depends_on = [google_container_cluster.gke_primary_cluster]

  # A startup script is a file that contains commands that run when
  # a virtual machine (VM) instance boots. 
  
  metadata_startup_script = "${file("init.sh")}"

}