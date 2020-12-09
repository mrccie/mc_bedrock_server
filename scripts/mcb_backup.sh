#!/bin/bash


#### Passed-In Variables ####
user_name=$1


#### Variables ####
docker_volume_dir=/var/lib/docker/volumes/
mcb_volume_prefix=mcb_*
mcb_volume_files="${docker_volume_dir}${mcb_volume_prefix}"
backup_folder=/home/$1/mc_bedrock_server/backups/



#### Check that the Passed-in User Has the Necessary Folders ####
if [ -d "$backup_folder" ] 
then
    # Log Start
    echo "$(date +%Y%m%d) - Starting Backup..." >> /home/$user_name/logs/backup_log.txt

else
    echo "Error: Directory /home/$1/mc_bedrock_server/backups/ does not exist.  Did you pass the username as an argument?"
    exit 1
fi



#### Check the User is Root ####
if [ "$EUID" -ne 0 ]
then
        echo "Please run as root"
        echo "$(date +%Y%m%d) - mcb_backup.sh not being run as root" >> /home/$user_name/mc_bedrock_server/alert.txt
        exit
fi



#### Backup MCB Containers ####

# CD to the docker volume directory
cd $docker_volume_dir

# For each "mcb_*" folder in the Docker volume area...
for vol_file in $mcb_volume_prefix
do
	# Stop the associated Docker container
	docker stop $vol_file


	# Create the archive name
	backup_file="${backup_folder}${vol_file}.$(date +%Y%m%d).tar.gz"

        # Log Action
        echo "$(date +%Y%m%d) - > Creating $backup_file" >> /home/$user_name/logs/backup_log.txt

	# Create an archive of the volume
	tar -zcf $backup_file $vol_file


	# Restart the associated Docker container
	docker start $vol_file

done



#### Cleanup - Remove the Oldest Backup Files ####

# Log Action
echo "$(date +%Y%m%d) - > Deleting any old files" >> /home/$user_name/logs/backup_log.txt


# Keeps the 12 most recent backups
cd $backup_folder
ls -t | sed -e '1,12d' | xargs -d '\n' rm


# Log Action
echo "$(date +%Y%m%d) - > Done." >> /home/$user_name/logs/backup_log.txt
