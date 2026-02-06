# scripts/

One-click scripts for lab rebuilds. Target: EC2 t3/t2.medium (2 vCPU, 4 GiB)
- 00_start_minikube.sh   -> Start a fresh Minikube cluster sized for low memory
- 01_install_argocd.sh   -> Install Argo CD
- 02_install_kyverno.sh  -> Install Kyverno
- 03_install_rollouts.sh -> Install Argo Rollouts
- 04_bootstrap_argocd.sh -> Apply parent Application to bootstrap child apps
- 99_cleanup.sh          -> Delete Minikube profile

We'll create them in Phases 1–2.
