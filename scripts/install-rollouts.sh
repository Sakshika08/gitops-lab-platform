#!/bin/bash

echo "Installing Argo Rollouts..."

kubectl create namespace argo-rollouts || true

kubectl apply -n argo-rollouts \
  -f https://github.com/argoproj/argo-rollouts/releases/latest/download/install.yaml

echo "Waiting for Rollouts pods..."
kubectl wait --for=condition=Ready pods --all -n argo-rollouts --timeout=300s

echo "Argo Rollouts installed!"
