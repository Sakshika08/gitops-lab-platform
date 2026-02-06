#!/bin/bash
set -e

echo "[+] Installing Argo Rollouts..."
# Create the namespace for rollouts controller (idempotent)
kubectl create namespace argo-rollouts 2>/dev/null || true
# Apply the official controller manifest (CRDs + controller deployment)
kubectl apply -n argo-rollouts -f https://github.com/argoproj/argo-rollouts/releases/latest/download/install.yaml

# Wait for controller deployment to become Available
kubectl wait -n argo-rollouts deploy --all --for=condition=Available --timeout=300s

