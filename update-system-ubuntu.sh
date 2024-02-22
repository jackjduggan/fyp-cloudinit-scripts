#!/bin/sh

# Encountered a problem with recent Ubuntu images where when updating, a gui screen
#   pops up prompting to restart certain services. Changing config to prevent this.
config_file="/etc/needrestart/needrestart.conf"
if [ -e "$config_file" ]; then
    sed -i 's/#\$nrconf{restart} = '\''i'\'';/$nrconf{restart} = '\''a'\'';/g' "$config_file"
    echo "Line replaced in $config_file"
else
    echo "needrestart.conf file not found"
fi

# Update the system and install basic packages
sudo apt-get update
echo "apt-get update | executed successfully"
sudo apt-get install -y wget
echo "wget | installed successfully"

# add neofetch to bashrc for fun
sudo apt-get install -y neofetch
echo "neofetch | installed successfully"
echo 'neofetch' >> ~/.bashrc
echo "neofetch | added to ~/.bashrc successfully"