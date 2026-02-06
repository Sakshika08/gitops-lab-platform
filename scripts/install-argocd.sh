#!/bin/bash
set -e

echo "[+] Installing ArgoCD..."
# Create namespace (if it exists, ignore the error by redirecting to /dev/null and '|| true')
kubectl create namespace argocd 2>/dev/null || true
# Apply the official stable installation manifest (CRDs + Deployments + Services)
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

echo "[+] Waiting for ArgoCD server..."
# Wait for all deployments in argocd namespace to become Available (up to 5 minutes)
kubectl wait -n argocd deploy --all --for=condition=Available --timeout=300s

echo "[+] Get password:"
# Print the auto-generated admin password (base64-decoded) from the secret
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d
echo  # Print a newline for cleaner output
