
# Deployed Ubuntu 20.04 VM in Azure

sudo apt-get update
sudo apt-get install docker.io
sudo usermod -aG docker $USER         #add current user to docker group
newgrp docker                         #apply changes to group membership so regular user can run docker commands
docker pull wordpress:php8.1-apache

#install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/v2.2.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod

mkdir henkle-cosmetics
cd henkle-cosmetics
# download the compose YAML file to this location