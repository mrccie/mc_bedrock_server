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



#### Executing Docker without Sudo ####

## This is Optional, but this script will assume you chose this option

# Add your username to the docker group:
sudo usermod -aG docker ${USER}

# Now we need to log out and log back in for this to take effect
echo "Please log out now so permission changes can take effect.  Kindly run install-2.sh when you log back in."



