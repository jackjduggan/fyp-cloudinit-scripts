#!/bin/sh

##### Installation #####
# get the puppet package from repo
wget https://apt.puppetlabs.com/puppet-release-bionic.deb
echo "puppet-release-bionic.deb | acquired successfully"

# unpack puppet package with dpkg
sudo dpkg -i puppet-release-bionic.deb
echo "puppet-release-bionic.deb | unpacked successfully"

# install puppet-master
sudo apt-get install puppet-master
echo "puppet-master | installed successfully"

# allow inbound traffic on port 8140/tcp
sudo ufw allow 8140/tcp

##### Test #####
# make production environment directory
sudo mkdir -p /etc/puppet/code/environments/production/manifests/




