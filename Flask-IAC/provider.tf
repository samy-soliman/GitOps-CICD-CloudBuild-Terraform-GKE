provider "google" {
    # credentials = file("SA_KEY.json") # no need for it in cloud build will use his SA
    project = var.project_id
    region =  var.project_region   # default for resources
}