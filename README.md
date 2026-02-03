# GitOps Lab Platform – Build Log & Runbook

This repository holds a **reproducible DevSecOps GitOps platform** for temporary labs.
It is designed to rebuild in ~15–20 minutes on a fresh Kubernetes cluster (Minikube on EC2 t3/t2.medium).

## Why a Monorepo?
- All platform code (GitOps, policies, rollouts, sample service, scripts) is visible in one place.
- Argo CD pulls these manifests and reconciles the cluster after every lab reset (Git is the source of truth).

## High-Level Layout
- `bootstrap/` - Argo CD **parent** Application (app-of-apps) to bootstrap child apps.
- `apps/`      - Child Argo CD Application manifests (Kyverno policies, Rollouts, sample app).
- `policies/`  - Kyverno ClusterPolicies (PSS Restricted, best-practices, supply-chain verification).
- `rollout/`   - Argo Rollouts CRs for canary/blue-green strategies.
- `services/`  - A tiny sample microservice to deploy via Rollouts.
- `scripts/`   - Rebuild scripts (start Minikube, install Argo CD/Kyverno/Rollouts, bootstrap GitOps).
- `.github/workflows/` - CI/CD (build image, update manifests).

## Build Log (Phase 0)
- Created repo structure with empty placeholders.
- Documented intent for each folder to ensure understanding before adding content.
- Next: Phase 1 (Minikube lifecycle scripts).

## Rebuild Philosophy
- The **cluster is ephemeral**; the **repo is the truth**. If the lab resets:
  1) Create a fresh cluster (scripts/00_start_minikube.sh)
  2) Install controllers (Argo CD, Kyverno, Rollouts)
  3) Apply the parent Application (bootstrap/app-of-apps.yaml)
  4) Argo CD syncs everything else

## Notes
- Host target: EC2 t3.medium/t2.medium, Ubuntu 22.04, 40 GiB gp3
- Kubernetes target: Minikube (Docker driver) sized for low memory (2 CPU, ~3500 MB)
- Keep each phase small and verify understanding before moving on.

