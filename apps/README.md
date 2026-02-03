# apps/

Will contain Argo CD "child" Applications:
- kyverno-policies.yaml  -> Applies Kyverno ClusterPolicies from /policies
- rollout-sample.yaml    -> Applies sample Rollout from /rollout
- sample-app.yaml        -> (Optional) Separate app manifest if not bundled with rollout

# Argo CD Applications

- `sample-app.yaml` → Deploys the Flask sample app from `services/sample-app/k8s`.
- `kyverno.yaml` → Deploys Kyverno policy manifests from `policies/` (Phase 5).
- `rollouts.yaml` → Deploys Argo Rollouts CRs from `rollout/` (Phase 6).

All Applications assume:
- repoURL points to this repository
- targetRevision = `main`
- Argo CD namespace = `argocd`

These are managed by the parent app in /bootstrap.
