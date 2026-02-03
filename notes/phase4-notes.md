Key Concepts from Phase 4
1. Argo CD Application
A single CRD that tells Argo CD:

Which Git repo to watch
Which branch to track
Which folder contains Kubernetes manifests
Which namespace to deploy to
How to sync updates automatically

2. repoURL
Points to my GitHub repository.
Example:
https://github.com/<username>/<repo>.git

3. targetRevision
Branch Argo CD continuously watches:
main

4. path
Folder inside the repo where manifests live:
services/sample-app/k8s

5. destination
Where resources are deployed inside Kubernetes cluster:
namespace: sample-app
server: https://kubernetes.default.svc

6. syncPolicy.automated
Enables true GitOps:

prune → delete resources removed from Git
selfHeal → fix cluster drift automatically

7. syncOptions
Extra behaviors:

CreateNamespace=true → Argo auto-creates namespace if missing
ApplyOutOfSyncOnly=true → faster sync by applying only changed resources


📌 Detailed Notes per Manifest
🟦 apps/sample-app.yaml — Child Application Explanation
This Argo CD Application:

Deploys the sample Flask app
Reads manifests from: services/sample-app/k8s
Tracks the main branch
Deploys into sample-app namespace
Keeps cluster state fully aligned with Git
Uses:

prune → deletes any old resources removed from Git
selfHeal → repairs manual changes in cluster
CreateNamespace=true → auto-creates namespace
ApplyOutOfSyncOnly=true → faster sync cycles



In short:
It ensures the app is always deployed EXACTLY as defined in Git → enforcing Git as the single source of truth.

🟩 Argo CD Prune — Important Concept
Prune = delete resources that no longer exist in Git.
Why this matters:

Prevents orphaned Deployments, Services, Ingresses from lingering
Ensures old or unused workloads are removed
Keeps the cluster clean, secure, drift‑free
Avoids unexpected behavior from outdated resources

Prune is activated during sync and compares:
Git State  vs  Cluster State

Anything missing from Git = deleted from cluster.
Best practice: Always pair prune with selfHeal.

🟧 apps/kyverno.yaml — Purpose
(This will become active in Phase 5)

Tracks Kyverno policies stored in policies/
Deploys them into the kyverno namespace
Ensures all cluster security/compliance rules stay in sync with Git

Difference:

Sample app → deploys actual application workloads
Kyverno app → deploys security governance policies


🟨 apps/rollouts.yaml — Purpose
(This will become active in Phase 6)

Tracks Argo Rollouts CRDs stored in rollout/
Deploys to argo-rollouts namespace
Enables canary / blue‑green deployment strategies


🧩 Important Notes to Remember

These are child applications → The parent App-of-Apps deploys them (Phase 7).
Do NOT apply these YAMLs manually right now.
Folder structure MUST match paths in the Application manifests.
Git is the single source of truth → Argo CD enforces repo state.
automated.prune + selfHeal = ensures drift-free GitOps environment.
CreateNamespace=true removes the need for manual namespace creation.
