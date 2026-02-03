# services/sample-api

A tiny HTTP service (language of your choice). Keep it minimal for fast iterations:
- Dockerfile
- app source (e.g., Node/Go/Python)
- k8s manifests or Helm chart (optional)

CI will build the image and update the Rollout manifest tag/digest.
