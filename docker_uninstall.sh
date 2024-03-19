#!/bin/bash

# Stop Docker services
sudo systemctl stop docker

# Remove Docker packages
sudo apt-get purge docker-ce docker-ce-cli containerd.io

# Remove Docker configuration and data
sudo rm -rf /var/lib/docker
sudo rm -rf /etc/docker

# Remove Docker user group
sudo groupdel docker

# Remove Docker related binaries
sudo rm -f /usr/local/bin/docker*
sudo rm -f /usr/bin/docker*

# Clean up any remaining Docker files
sudo apt-get autoremove -y
sudo apt-get autoclean -y

echo "Docker has been removed successfully."