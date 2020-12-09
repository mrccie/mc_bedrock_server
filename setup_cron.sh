#!/bin/bash

#### Variables ####
user_name=${USER}


#### Set Up Cron Job for Backup Service ####

echo "> Setting up cron for backup service..."

# Step 0: Add root to the cron.allow file
sudo bash -c 'echo "root" >> /etc/cron.allow'

# Step 1: Save all current cronjobs by root in a file
if [ -f /var/spool/cron/crontabs/root ]; then
	sudo crontab -l > /home/$user_name/mc_bedrock_server/scripts/cron_list.txt
fi

# Step 2: Add the cron job to the list
echo "0 3 * * * /home/$user_name/mc_bedrock_server/scripts/mcb_backup.sh $user_name" >> /home/$user_name/mc_bedrock_server/scripts/cron_list.txt

# Step 3: Reload edited list of cron jobs
sudo crontab /home/$user_name/mc_bedrock_server/scripts/cron_list.txt

# Step 4: Clean Up
sudo rm /home/$user_name/mc_bedrock_server/scripts/cron_list.txt

echo "done."



