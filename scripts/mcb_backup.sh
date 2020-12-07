#!/bin/bash


#### Variables ####
docker_volume_dir=/var/lib/docker/volumes/
mcb_volume_prefix=mcb_*
mcb_volume_files="${docker_volume_dir}${mcb_volume_prefix}"
backup_folder=/home/etch/mc_bedrock_server/backups/


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

	# Create an archive of the volume
	tar -zcf $backup_file $vol_file


	# Restart the associated Docker container
	docker start $vol_file

done



#### Cleanup - Remove the Oldest Backup Files ####

# Keeps the 12 most recent backups
cd $backup_folder
ls -t | sed -e '1,12d' | xargs -d '\n' rm

