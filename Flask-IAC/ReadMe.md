<h3> terraform commands are run in the pipleline for you check cloudbuild file</h3>
terraform apply -var-file=dev.tfvars</br>
terraform destroy -var-file=dev.tfvars</br>

<h3> 1- prepare the vm for the first time </h3>
This step is automated the init script is in starter script for the vm</br>

<h3> 2- authenticate docker </h3>
authenticate artifact registry in your host, replace region with yours</br>
gcloud auth print-access-token | sudo docker login -u oauth2accesstoken --password-stdin  us-east1-docker.pkg.dev</br>

<h3> 3- authenticate kubernetes gke </h3>
# authenticate your cluster with gcp , replace name, cluster and project with your values</br>
gcloud container clusters get-credentials pgke-cluster --region us-central1 --project exalted-kit </br>

<h3>4- manage gke </h3>
you can now start managing your cluster using kubectl command </br>
