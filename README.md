# mc_bedrock_server
Container-based Minecraft Bedrock Server for Ubuntu

Author: mrccie

Copyright: 2020, mrccie

Date: 6-DEC-2020

Version: 1.0


## PURPOSE

mc_bedrock_server is a package designed to install Docker and a few Bedrock Minecraft servers on a Ubuntu 20 host.  Hopefully this package will let you focus on what's important (playing Minecraft) and offload what isn't (the mundane setup stuff).

This package will also - optionally - enable a (very ugly and very basic) backup strategy to add backups to a local folder in the middle of the night.  It's on you to put the files it backs up into the cloud or USB (or whatever).


## System Requirements

This solution has been tested on the following hardware:
- Platform: Intel i7 7700 (4x CPU), 16GB of RAM, 256GB NVMe
- Hypervisor: VMWare ESXi
- OS: Ubuntu 20.04 server lts


## Ubuntu Initialization

If you're installing on Ubuntu from scratch, you'll need to do a few things first.

During Setup:
- Disable DHCP, set a Static IP
- Enable OpenSSH Server

Update the operating system:
```sh
sudo apt-get update
sudo apt-get upgrade
```

Set your local timezone:
```sh
sudo timedatectl America/New_York
```


## Installation: Pre-Requisites and Git

This is just on Git for now.

Pre-requisites:
- Ubuntu has internet connectivity
- Terminal access to the Ubuntu server (local or via SSH)

Install git:
```sh
sudo apt-get install -y git
```

Configure git:
```sh
git config --global user.email "<email>"
git config --global user.name "<username>"
```

Make a directory to clone this repository to:
```sh
mkdir git
cd git
```


## Installation

Clone this repository:
```sh
git clone https://github.com/mrccie/mc_bedrock_server
```

Go into the repository directory:
```sh
cd mc_bedrock_server
```

Use the install script:
```sh
sudo ./install.sh
```
