#!/bin/bash

echo "Installing Kyverno..."

kubectl create namespace kyverno || true

kubectl apply -f https://raw.githubusercontent.com/kyverno/kyverno/main/config/release/install.yaml

echo "Waiting for Kyverno pods..."
kubectl wait --for=condition=Ready pods --all -n kyverno --timeout=300s

echo "Kyverno installed successfully!"
