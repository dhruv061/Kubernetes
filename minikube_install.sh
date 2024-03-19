#!/bin/bash

# Define Minikube version
MINIKUBE_VERSION="latest"

# Define the installation directory
INSTALL_DIR="/usr/local/bin"

# Define the hypervisor you want to use (e.g., virtualbox, kvm2, hyperkit)
HYPERVISOR="virtualbox"

# Check if curl is installed
if ! [ -x "$(command -v curl)" ]; then
  echo "Error: curl is not installed. Please install curl before proceeding." >&2
  exit 1
fi

# Download Minikube binary
curl -Lo minikube https://storage.googleapis.com/minikube/releases/"$MINIKUBE_VERSION"/minikube-linux-amd64
# For other architectures, replace "linux-amd64" with "darwin-amd64" for macOS or "windows-amd64.exe" for Windows.

# Make the Minikube binary executable
chmod +x minikube

# Move the Minikube binary to the installation directory
sudo mv minikube "$INSTALL_DIR"

# Download kubectl
sudo apt-get update && sudo apt-get install -y kubectl

# Install the hypervisor
if [[ "$HYPERVISOR" == "virtualbox" ]]; then
    sudo apt-get install -y virtualbox
elif [[ "$HYPERVISOR" == "kvm2" ]]; then
    sudo apt-get install -y qemu-kvm libvirt-clients libvirt-daemon-system bridge-utils virt-manager
    sudo usermod -aG libvirt $(whoami)
    newgrp libvirt
elif [[ "$HYPERVISOR" == "hyperkit" ]]; then
    # Install hyperkit (for macOS)
    echo "Hyperkit is not supported in this script. Please install it manually."
    exit 1
else
    echo "Unknown hypervisor: $HYPERVISOR"
    exit 1
fi

# Add Minikube completion to the shell
sudo curl -Lo /etc/bash_completion.d/minikube https://storage.googleapis.com/minikube/releases/"$MINIKUBE_VERSION"/minikube-linux-amd64_completion

echo "Minikube and dependencies have been installed successfully."