#!/bin/sh

# Write to /tmp/script_executed.txt for debugging purposes
echo "Script executed on $(date)" >> /tmp/script_executed.txt
echo "Debug file created at /tmp/script_executed.txt"

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
ip_address="100.27.65.226" #eip
dns_name="puppet"

echo "$ip_address $dns_name" >> /etc/hosts
echo "Entry added to /etc/hosts: $ip_address $dns_name"

# start and enable puppet
sudo systemctl start puppet
sudo systemctl enable puppet

# Wait for the Puppet master to automatically sign the certificate
echo "Waiting for the Puppet master to sign the certificate..."
sleep 30

# Run puppet agent to apply the initial configuration
sudo puppet agent --test
echo "Puppet agent run | Completed successfully."
