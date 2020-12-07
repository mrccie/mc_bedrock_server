#!/bin/bash


#### Inform User of Purpose ####

echo "This script will create a location for container setup scripts, backups and backup scripts."
echo "Would you like to continue? (y/n)"
read user_choice

if [ $user_choice != 'y' ] && [ $user_choice != 'n' ]
then
        echo "Sorry, I need a 'y' or an 'n'.  Aborting!"
        exit 1
elif [ $user_choice == 'n' ]
then
        echo "OK then, thanks for stopping by."
        exit 1
elif [ $user_choice == 'y' ]
then
        echo "Creating file structure..."
fi



#### Create folders ####

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

