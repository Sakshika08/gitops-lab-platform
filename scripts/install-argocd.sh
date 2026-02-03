#!/bin/bash

echo "Installing Argo CD..."

kubectl create namespace argocd || true
