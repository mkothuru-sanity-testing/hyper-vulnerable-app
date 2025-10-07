# Hyper Vulnerable SCA and IaC Repo

> ⚠️ WARNING: Do not use this in production or on any network-connected machine.dcxc
> Only use in isolated sandbox / VM / lab.

## Contents
- Terraform: 10+ files with public buckets, insecure IAM, open SGs
- Kubernetes: 5+ YAMLs with pods running as root, hostPath mounts
- Docker: 3 Dockerfiles with root login, world-writable dirs
- .env: hardcoded secrets

## Usage
1. Clone repo into an isolated VM.
2. Run scanners:
   - tfsec, checkov, trivy, kube-bench, snyk, etc.
3. Destroy VM or Docker images after testing.
