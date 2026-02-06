#!/bin/bash                   # Use bash shell to run this script
set -e                        # Exit immediately if any command fails

echo "[+] Installing Docker..."
sudo apt-get update -y        # Refresh apt package index (Ubuntu/Debian)
sudo apt-get install -y docker.io curl  # Install Docker engine and curl tool

sudo usermod -aG docker $USER # Add current user to 'docker' group to use Docker without sudo

echo "[+] Installing kubectl..."
# Download the latest stable kubectl binary for Linux AMD64
curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl              # Make the binary executable
sudo mv kubectl /usr/local/bin/   # Move to a directory in PATH so it's callable globally

echo "[+] Installing minikube..."
# Download latest Minikube binary for Linux
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
# Install it to /usr/local/bin as 'minikube' with correct permissions
sudo install minikube-linux-amd64 /usr/local/bin/minikube

echo "[+] Done. Run: newgrp docker"
# Note: `newgrp docker` refreshes your shell group membership so 'docker' works without relogin
