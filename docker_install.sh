#!/bin/bash

# Update the apt package index and install packages to allow apt to use a repository over HTTPS
sudo apt-get update
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Verify that you now have the key with the fingerprint
sudo apt-key fingerprint 0EBFCD88

# Set up the stable Docker repository
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# Update the apt package index again
sudo apt-get update

# Install the latest version of Docker Engine and containerd
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Verify that Docker Engine is installed correctly
sudo docker --version

# Verify that Docker Engine is running
sudo systemctl status docker

# Add the current user to the docker group to run Docker commands without sudo (optional)
sudo usermod -aG docker $USER

echo "Docker has been installed successfully."