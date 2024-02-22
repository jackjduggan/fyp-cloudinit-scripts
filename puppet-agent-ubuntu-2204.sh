#!/bin/sh

##### Installation #####
# get the puppet package from repo
wget https://apt.puppetlabs.com/puppet-release-bionic.deb
echo "puppet-release-bionic.deb | acquired successfully"

# unpack puppet package with dpkg
sudo dpkg -i puppet-release-bionic.deb
echo "puppet-release-bionic.deb | unpacked successfully"

# install puppet agent
sudo apt-get install -y puppet
echo "puppet | installed successfully"

# add puppet master ip address and dns name to /etc/hosts
#ip_address="$1"
ip_address="123.456.78.90"
#dns_name="$2"
dns_name="test"

echo "$ip_address $dns_name" >> /etc/hosts
echo "Entry added to /etc/hosts: $ip_address $dns_name"

# start and enable puppet
sudo systemctl start puppet
sudo systemctl enable puppet

# ! at this point, this puppet agent will have sent a cert request to puppet master
