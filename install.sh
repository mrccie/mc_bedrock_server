#!/bin/bash


#### Installing Docker ####

# Credit to:
#   https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04

# Update your list of existing packages
sudo apt update

# Install a few prerequisite packages which let apt use packages over HTTPS:
sudo apt install apt-transport-https ca-certificates curl software-properties-common

# Then add the GPG key for the official Docker repository to your system:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add the Docker repository to APT sources:
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"

# Update the package database with the Docker packages from the newly added repo:
sudo apt update

# Install Docker
sudo apt install docker-ce

# Verify that it's running
sudo systemctl status docker



#### Pull the Minecraft Bedrock Server Image ####

# Pull the minecraft bedrock container image
sudo docker pull itzg/minecraft-bedrocker-server




#### Executing Docker without Sudo ####

## This is Optional

# Add your username to the docker group:
echo ""
echo "ATTENTION-1:"
echo "If you want your user to be able to use docker without sudo, copy+paste this:"
echo "    sudo usermod -aG docker ${USER}"
echo ""
echo "Then log out and log back in so the permission change can take effect."



#### Instructions for next steps ####

echo ""
echo ""
echo "ATTENTION-2:"
echo "Please execute the 'build-container.sh' script to create minecraft containers."
echo "You can run this script multiple times to build multiple containers."

