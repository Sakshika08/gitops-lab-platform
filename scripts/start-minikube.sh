#!/bin/bash                # Use bash shell
set -e                     # Stop if any command fails

echo "[+] Starting Minikube..."
# Start a single-node Kubernetes cluster using the Docker driver
# --memory and --cpus are sized for a t3.medium; adjust if needed
minikube start --driver=docker --memory=4096 --cpus=2

echo "[+] Enabling ingress addon..."
# Enable NGINX Ingress Controller inside Minikube (handy for services via hostnames/paths)
minikube addons enable ingress

# Show node status to confirm cluster is up and the kubeconfig is set
kubectl get nodes
