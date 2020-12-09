#!/bin/bash


#### Variables ####
user_name=${USER}



#### Ensure Script is NOT run as root ####

#### Check the User is Root ####
if [ "$EUID" -ne 0 ]
then
	echo "Installing docker and pulling a minecraft bedrock edition container..."
else
        echo "Please DO NOT run as root.  Sudo is used when needed.  Aborting."
        exit
fi



#### Installing Docker ####

# Credit to:
#   https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04

echo "Installing docker..."

# Update your list of existing packages
sudo apt update

# Install a few prerequisite packages which let apt use packages over HTTPS:
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

# Then add the GPG key for the official Docker repository to your system:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add the Docker repository to APT sources:
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"

# Update the package database with the Docker packages from the newly added repo:
sudo apt update

# Install Docker
sudo apt-get install -y docker-ce

echo "done."




#### Pull the Minecraft Bedrock Server Image ####

echo "Pulling minecraft bedrock server (credit: itzg)..."

# Pull the minecraft bedrock container image
sudo docker pull itzg/minecraft-bedrock-server

echo "done."




#### Create Minecraft folders ####

echo ""
echo "Creating folder /home/${USER}/mc_bedrock_server/"
mkdir /home/${USER}/mc_bedrock_server

echo "Creating folder /home/${USER}/mc_bedrock_server/backups/"
mkdir /home/${USER}/mc_bedrock_server/backups

echo "Creating folder /home/${USER}/mc_bedrock_server/docker_run_commands/"
mkdir /home/${USER}/mc_bedrock_server/docker_run_commands

echo "Creating folder /home/${USER}/mc_bedrock_server/scripts/"
mkdir /home/${USER}/mc_bedrock_server/scripts

echo "Copying scripts..."
cp /home/${USER}/git/mc_bedrock_server/scripts/* /home/${USER}/mc_bedrock_server/scripts/

echo "done."




#### Next Steps for the User ####

## This is Optional

# Verify that Docker is working
echo ""
echo "ATTENTION-0:"
echo "To verify that docker is running, execute the following command:"
echo "    sudo systemctl status docker"
echo ""


# Add your username to the docker group:
echo ""
echo "ATTENTION-1:"
echo "If you want your user to be able to use docker without sudo, copy+paste this:"
echo "    sudo usermod -aG docker ${USER}"
echo ""
echo "Then log out and log back in so the permission change can take effect."
echo ""


#### Instructions for Automated Backups ####
echo ""
echo "ATTENTION-2:"
echo "If you want to enable automated backups, execute the 'setup_cron.sh' script."
echo ""


#### Instructions for Setting up a Container ####
echo ""
echo "ATTENTION-3:"
echo "Please execute the 'make_mcb_container.sh' script to create minecraft container setup scripts."
echo "Each script can then be run to create consistent containers and volumes that can be automatically backed up."
echo ""

