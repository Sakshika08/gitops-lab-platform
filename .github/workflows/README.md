# .github/workflows/

Will contain CI/CD:
- Build & push the sample service image (e.g., GHCR)
- (Optional) Cosign sign the image (keyless)
- Update rollout manifest with tag/digest and commit back
- Argo CD will sync and Rollouts will canary
