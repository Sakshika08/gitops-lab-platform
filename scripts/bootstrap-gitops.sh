#!/bin/bash
set -e   # Stop script on first error

APP_NAME="sample-app"   # Your App-of-Apps root application name
NAMESPACE="argocd"      # Argo CD always runs in this namespace

echo "[+] Bootstrapping GitOps via App-of-Apps..."

# Step 1 — Validate Argo CD namespace exists
if ! kubectl get ns $NAMESPACE >/dev/null 2>&1; then
  echo "[ERROR] Namespace '$NAMESPACE' does not exist."
  echo "Did you run: bash install-argocd.sh ?"
  exit 1
fi

# Step 2 — Validate that the App-of-Apps file exists
if [ ! -f bootstrap/app-of-apps.yaml ]; then
  echo "[ERROR] File 'bootstrap/app-of-apps.yaml' does NOT exist."
  echo "Make sure your repo contains: bootstrap/app-of-apps.yaml"
  exit 1
fi

# Step 3 — Apply the App-of-Apps YAML to Argo CD
echo "[+] Applying App-of-Apps manifest..."
kubectl apply -f bootstrap/app-of-apps.yaml -n $NAMESPACE

# Step 4 — Give Argo CD time to register the new Application object
echo "[+] Waiting 10 seconds for Argo CD to detect the Application..."
sleep 10

# Step 5 — Wait until Argo CD marks the root app as Healthy
echo "[+] Waiting for Application '$APP_NAME' to become Healthy..."
kubectl wait \
  --namespace $NAMESPACE \
  --for=condition=Healthy \
  application/$APP_NAME \
  --timeout=180s || echo "[WARNING] App may still be syncing..."

# Step 6 — Display all Argo CD applications
echo "[+] Listing Argo CD applications:"
kubectl get applications -n $NAMESPACE

echo "[+] GitOps bootstrap completed successfully!"
echo "[INFO] Open the Argo CD UI and confirm all apps are syncing."
