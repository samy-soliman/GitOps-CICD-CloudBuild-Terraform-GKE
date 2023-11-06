output "vpc" {
  value       =  google_compute_network.mongo_vpc   
  description = "compute network object"
}

output "workload_subnet" {
  value       =  google_compute_subnetwork.workload_subnet   
  description = "workload_subnet object"
}