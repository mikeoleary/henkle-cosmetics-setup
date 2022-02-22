# My main reference guide was this article: https://www.cloudsavvyit.com/12978/how-to-quickly-deploy-wordpress-as-a-docker-container/

# Deployed Ubuntu 20.04 VM in Azure

export COMPOSEVERSION="v2.2.3"

sudo apt-get update
sudo apt-get install docker.io -y
sudo usermod -aG docker $USER         #add current user to docker group
newgrp docker                         #apply changes to group membership so regular user can run docker commands
docker pull wordpress:php8.1-apache

#install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/$COMPOSEVERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

mkdir henkle-cosmetics
cd henkle-cosmetics
# download the compose YAML file to this location
curl -L "https://raw.githubusercontent.com/mikeoleary/henkle-cosmetics-setup/main/docker-compose.yaml" -o docker-compose.yaml
docker-compose up -d


