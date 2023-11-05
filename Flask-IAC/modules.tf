module "network" {
    source = "./network"
    project_id = var.project_id
}

module "storage" {
    source = "./storage"
}

module "compute" {
    source = "./compute"
    # global variables
    project_id = var.project_id
    # vm variables
    management_vm_subnet_zone = "us-east1-b"
    machine_type = var.machine_type
    management_vm_subnetwork_interface = module.network.management_subnet.name
    # gke variables
    location = module.network.workload_subnet.region
    network = module.network.vpc.name
    subnetwork = module.network.workload_subnet.name
    depends_on = [ module.network ]
}
