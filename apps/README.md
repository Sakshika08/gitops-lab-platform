# apps/

Will contain Argo CD "child" Applications:
- kyverno-policies.yaml  -> Applies Kyverno ClusterPolicies from /policies
- rollout-sample.yaml    -> Applies sample Rollout from /rollout
- sample-app.yaml        -> (Optional) Separate app manifest if not bundled with rollout

These are managed by the parent app in /bootstrap.
