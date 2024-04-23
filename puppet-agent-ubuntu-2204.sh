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

# Loop to wait for the Puppet agent to successfully apply the configuration
success=0
attempts=0
while [ $success -eq 0 ] && [ $attempts -lt 10 ]; do
    sudo puppet agent --test
    if [ $? -eq 0 ]; then
        echo "Puppet agent run | Completed successfully."
        success=1
    else
        echo "Puppet agent run failed, retrying in 30 seconds..."
        sleep 30
        attempts=$((attempts+1))
    fi
done

if [ $success -eq 0 ]; then
    echo "Puppet agent failed to apply configuration after several attempts."
fi
