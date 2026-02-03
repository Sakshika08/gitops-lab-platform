#!/bin/bash

echo "Bootstrapping GitOps via App-of-Apps..."

kubectl apply -f bootstrap/app-of-apps.yaml -n argocd

echo "Waiting for Argo CD to sync applications..."
sleep 10

echo "GitOps bootstrap triggered successfully!"
echo "Check Argo CD UI for sync status."
