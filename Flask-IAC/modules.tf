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
   
    # gke variables
    location = module.network.workload_subnet.region
    network = module.network.vpc.name
    subnetwork = module.network.workload_subnet.name
    depends_on = [ module.network ]
}
