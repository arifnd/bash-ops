#!/bin/bash

# Check if user is running script as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

# Check if the system is Debian-based or Red Hat-based
if [[ $(command -v apt-get) ]]; then
   # Install UFW on Debian-based systems
   apt-get update
   apt-get install ufw -y
elif [[ $(command -v yum) ]]; then
   # Install UFW on Red Hat-based systems
   yum install epel-release -y
   yum install ufw -y
else
   echo "Unsupported operating system"
   exit 1
fi

# Get open ports from user input
echo "Enter open ports separated by commas (e.g. 80,443,22): "
read open_ports

# Allow incoming traffic on specified ports
ufw allow in on any port {${open_ports//,/ }}

# Enable UFW
ufw enable

# Display UFW status
ufw status verbose
