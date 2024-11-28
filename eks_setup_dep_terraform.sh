#!/bin/bash

set -e  # Exit on any error

echo "📂 Creating directory for EKS deployment..."
mkdir -p /home/ubuntu/EKS_DEP && cd /home/ubuntu/EKS_DEP
echo "✅ Directory created and switched: /home/ubuntu/EKS_DEP"

# Install Terraform
echo "🔧 Installing Terraform..."
sudo apt-get update -qq && sudo apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update -qq && sudo apt-get install -y terraform
terraform --version
echo "✅ Terraform installed successfully! 🏗️"

# Install kubectl
echo "🔧 Installing kubectl..."
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client
echo "✅ kubectl binary installed! 🧑‍💻"

# Install AWS CLI
echo "🔧 Installing AWS CLI..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt install -y unzip
unzip awscliv2.zip
sudo ./aws/install
aws --version
echo "✅ AWS CLI installed successfully! ☁️"

# Prompt user for AWS credentials
echo "🔐 Configuring AWS CLI..."
read -p "Enter AWS Access Key: " AWS_ACCESS_KEY
read -sp "Enter AWS Secret Key: " AWS_SECRET_KEY
echo ""
aws configure set aws_access_key_id "$AWS_ACCESS_KEY"
aws configure set aws_secret_access_key "$AWS_SECRET_KEY"
aws configure set default.region "us-east-1"  # Set default region or ask the user

# Verify AWS credentials
aws sts get-caller-identity
echo "✅ AWS CLI configured and verified! 🛡️"

# Create permanent aliases
echo "⚙️ Setting up aliases..."
echo "alias t='terraform'" >> ~/.bashrc
echo "alias k='kubectl'" >> ~/.bashrc
source ~/.bashrc
echo "✅ Aliases created! 🚀"

# Reload the server environment
echo "🔄 Reloading shell environment..."
exec bash

echo "🎉 Setup complete! Your environment is ready for EKS deployment."
