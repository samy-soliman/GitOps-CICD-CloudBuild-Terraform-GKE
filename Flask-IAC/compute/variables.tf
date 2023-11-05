# project id  
variable "project_id" {
    type = string    # "exalted-kit"
}
#### vm variables
# management_vm_subnet
variable "management_vm_subnet_zone" {
    type = string    # management_subnet_zone
}
# machine_type
variable "machine_type" {
    type = string       # "n2-standard-2"
}
# management_vm_subnetwork_interface
variable "management_vm_subnetwork_interface" {
    type = string       # module.network.management_subnet.name
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