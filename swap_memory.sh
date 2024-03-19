#!/bin/bash

# Specify the swap size in megabytes
SWAP_SIZE_MB=4096

# Create a swap file
sudo fallocate -l ${SWAP_SIZE_MB}M /swapfile

# Set proper permissions
sudo chmod 600 /swapfile

# Set up swap space
sudo mkswap /swapfile

# Activate the swap file
sudo swapon /swapfile

# Add the swap file to fstab to make it persistent across reboots
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

# Verify the swap status
echo "Swap configuration completed. Here is the current swap status:"
sudo swapon --show
free -h

echo "Swap memory of 4GB has been added successfully."
