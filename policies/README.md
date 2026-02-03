# policies/

Kyverno ClusterPolicies will live here, for example:
- pss-restricted-nonroot.yaml   (require runAsNonRoot)
- disallow-privileged.yaml      (block privileged containers, host namespaces)
- require-limits.yaml           (enforce CPU/mem requests/limits)
- verify-images-cosign.yaml     (optional: supply-chain, Cosign signatures, mutate to digest)

Start with `validationFailureAction: Audit` until you're confident, then switch to `enforce`.
