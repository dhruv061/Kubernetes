#!/bin/bash

# Define the installation directory
INSTALL_DIR="/usr/local/bin"

# Remove Minikube binary
sudo rm -f "$INSTALL_DIR/minikube"

# Remove Minikube completion
sudo rm -f /etc/bash_completion.d/minikube

echo "Minikube has been uninstalled successfully."