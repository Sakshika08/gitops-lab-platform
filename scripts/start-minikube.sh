#!/bin/bash

echo "Starting Minikube..."
minikube start --cpus=4 --memory=6g --driver=docker

echo "Enabling Ingress..."
minikube addons enable ingress

echo "Minikube started successfully."
kubectl get nodes
