#!/bin/bash

# delete /var/lib/man-db/auto-update to handle stuck
sudo rm /var/lib/man-db/auto-update

# install git
sudo apt update -y 
sudo apt install -y git 

# install-docker
sudo apt update -y
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu focal stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update -y

sudo apt install -y docker-ce

sudo systemctl start docker
sudo systemctl enable docker

#sudo docker --version

#sudo usermod -aG docker Lenovo

# install gcp gke auth tools
sudo apt-get install kubectl
sudo apt-get install google-cloud-sdk-gke-gcloud-auth-plugin
