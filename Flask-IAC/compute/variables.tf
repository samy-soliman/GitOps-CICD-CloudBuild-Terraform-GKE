# project id  
variable "project_id" {
    type = string    # "exalted-kit"
}

##### gke variables
variable "location" {
    type = string       # module.network.workload_subnet.region
}
variable "network" {
    type = string       # module.network.vpc.name
}
variable "subnetwork" {
    type = string       # module.network.workload_subnet.name
}