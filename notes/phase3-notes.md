# Phase 3 Notes

- Created Kubernetes manifests for sample-app.
   A namespace isolates the app from other apps in the cluster.
   Running apps in separate namespaces avoids conflicts with Kyverno, ArgoCD, and Rollouts.

- Added namespace, deployment, service.
  A deployment: tells Kubernetes how to run your Flask container.
     replicas: 2 → supports blue/green & canary rollouts
     probes → required for Argo Rollouts' traffic shifting
     your-docker-image → will later be replaced by your CI pipeline

  A service: Service gives a stable IP + DNS name for your pods.
  Kubernetes pods die and respawn — Services make sure the app is reachable regardless of pod IPs.

-  Create Kustomize
   Kustomize lets ArgoCD deploy this app cleanly, and CI/CD will update the image tag.
   ArgoCD supports Kustomize natively

- Learned about readiness & liveness probes.
  🔹 Startup Probe → Ensures the app has fully started.
Used for slow‑initializing applications so Kubernetes doesn’t prematurely kill the container.
Failing = container keeps restarting until the startup check passes.
👉 Important: While the startup probe is running, liveness and readiness probes are completely disabled.

🔹 Liveness Probe → Ensures the app stays alive during runtime.
Detects deadlocks, crashes, or hangs that prevent the application from functioning.
Failing = Kubernetes restarts the container to restore health.
👉 Important: A failing liveness probe can cause CrashLoopBackOff if the issue persists.

🔹 Readiness Probe → Ensures the app is ready to serve traffic.
Confirms that all dependencies, configs, and internal components are ready before accepting requests.
Failing = Pod is removed from load balancers, but NOT restarted.
👉 Important: A Pod with failing readiness continues running but receives zero traffic.

- Deployment uses image placeholder to be updated by CI/CD.
