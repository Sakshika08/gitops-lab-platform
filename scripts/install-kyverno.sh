#!/bin/bash
set -e

echo "[+] Installing Kyverno..."
# Apply the latest Kyverno release manifest (CRDs + controller + webhooks)
kubectl apply -f https://github.com/kyverno/kyverno/releases/latest/download/install.yaml

# Wait until Kyverno deployments are Available in the 'kyverno' namespace
kubectl wait -n kyverno deploy --all --for=condition=Available --timeout=300s

