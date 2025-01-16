#!/bin/bash

echo "Starting Docker installation..."

# Update the package database
echo "Updating package database..."
sudo apt-get update -y

# Install prerequisite packages
echo "Installing prerequisites..."
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

# Add Docker's official GPG key
echo "Adding Docker's GPG key..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Set up the Docker stable repository
echo "Setting up Docker repository..."
echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update the package database with Docker packages
echo "Updating package database with Docker packages..."
sudo apt-get update -y

# Install Docker Engine
echo "Installing Docker..."
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Enable Docker to start on boot
echo "Enabling Docker service..."
sudo systemctl enable docker
sudo systemctl start docker

# Add the current user to the Docker group
echo "Adding the current user to the Docker group..."
sudo usermod -aG docker $USER

echo "Docker installation completed successfully!"
echo "Please log out and log back in to apply the Docker group changes."
