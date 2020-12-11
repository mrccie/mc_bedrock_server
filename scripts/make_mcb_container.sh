#!/bin/bash


#### Verify the User Wants to Continue ####

echo "Would you like to start a new minecraft container? (y/n)"
read user_choice

if [ $user_choice != 'y' ] && [ $user_choice != 'n' ]
then
	echo "Sorry, I need a 'y' or an 'n'.  Aborting!"
	exit 1
elif [ $user_choice == 'n' ]
then
	echo "OK, exiting."
	exit 1
elif [ $user_choice == 'y' ]
then
	echo "Let's go!"
fi




#### Get User Input for Parameters ####

echo ""
echo "What should we call this container? [one word]"
read in_container_name
container_name="mcb_$in_container_name"

echo ""
echo "What should we call the minecraft world?"
read level_name

echo ""
echo "What port will this container run on? (default: 19132)"
read server_port

	if ! [[ $server_port =~ ^[0-9]+$ ]]
	then
	   echo "error: Not a number" >&2
	   exit 1
	fi

echo ""
echo "What mode do you want for the game? Choices are:"
echo "- survival"
echo "- creative"
echo "- adventure"
read game_mode

	if [ $game_mode != "survival" ] && [ $game_mode != "creative" ] && [ $game_mode != "adventure" ]
	then
		echo "error: not a valid choice" >&2
		exit 1
	fi

echo ""
echo "What difficulty should this game be set to? Choices are:"
echo "- peaceful"
echo "- easy"
echo "- normal"
echo "- hard"
read difficulty

	if [ $difficulty != "peaceful" ] && [ $difficulty != "easy" ] && [ $difficulty != "normal" ] && [ $difficulty != "hard" ]
	then
		echo "error: not a valid chocie" >&2
		exit 1
	fi

echo ""
echo "What should the view distance be? (number; I suggest '10')"
read view_distance

	if ! [[ $view_distance =~ ^[0-9]+$ ]]
	then
		echo "error: Not a number" >&2
		exit 1
	fi
	if [[ $view_distance > 31 ]]
	then
		echo "error: view distance too high"
		exit 1
	fi
	if [[ $view_distance < 10 ]]
	then
		echo "error: view distance too low"
		exit 1
	fi




#### Confirm User Choices ####

echo ""
echo ""
echo "A file with the following parameters will be created:"
echo "- Container Name: $container_name"
echo "- World Name: $level_name"
echo "- Server Port: $server_port"
echo "- Game Mode: $game_mode"
echo "- Difficulty: $difficulty"
echo "- View Distance: $view_distance"
echo ""

echo "Is this OK? (y/n)"
read user_choice

if [ $user_choice != 'y' ] && [ $user_choice != 'n' ]
then
        echo "Sorry, I need a 'y' or an 'n'.  Aborting!"
        exit 1
elif [ $user_choice == 'n' ]
then
        echo "Sorry, please restart the script."
        exit 1
elif [ $user_choice == 'y' ]
then
        echo "OK - building the file!"
fi




#### Build the Container File ####

# Identify the file path
file_path=/home/${USER}/mc_bedrock_server/docker_run_commands/$container_name.conf


# Check if the file already exists
if test -f "$file_path"
then
	echo "$container_name.conf file already exists.  Exiting!"
	exit 1
fi


# Create the file
touch $file_path


# Populate the file
echo "#!/bin/bash" >> $file_path
echo "" >> $file_path
echo "docker run -it \\" >> $file_path
echo "-e EULA=TRUE \\" >> $file_path
echo "-e SERVER_PORT=$server_port \\" >> $file_path
echo "-e DIFFICULTY=\"$difficulty\" \\" >> $file_path
echo "-e VIEW_DISTANCE=$view_distance \\" >> $file_path
echo "-e LEVEL_NAME=\"$level_name\" \\" >> $file_path
echo "-e GAMEMODE=\"$game_mode\" \\" >> $file_path
echo "-p $server_port:$server_port/udp \\" >> $file_path
echo "--name $container_name \\" >> $file_path
echo "-v $container_name:/data \\" >> $file_path
echo "--restart unless-stopped \\" >> $file_path
echo "itzg/minecraft-bedrock-server" >> $file_path
echo "" >> $file_path
echo "" >> $file_path
echo "!--- Notice ---!" >> $file_path
echo ": Your container is in INTERACTIVE mode." >> $file_path
echo ": Please move it to DETACHED mode with CTRL-P then CTRL-Q." >> $file_path
echo ": You can re-attach via the 'docker attach' command." >> $file_path


# Make the file executable
chmod 777 $file_path



#### Provide Further Direction ####

echo "Your docker run script is now ready; execute it from the docker_run_commands directory."
