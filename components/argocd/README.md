# ArgoCD Component

This component provides ArgoCD deployment manifests using Helm charts, supporting both stable and high-availability (HA) configurations.

## Overview

The component uses the official ArgoCD Helm chart from the Argo Project to generate Kubernetes manifests that can be deployed in the `argocd` namespace.

## Usage

### Build Manifests

```bash
# Build both stable and HA manifests
make build

# Build only stable manifest
make build-stable

# Build only HA manifest  
make build-ha
```

### Deploy via Helm (Direct Installation)

```bash
# Install stable ArgoCD
make install-stable

# Install HA ArgoCD
make install-ha

# Install with default configuration (stable)
make install
```

### Deploy via kubectl (Using Generated Manifests)

```bash
# Deploy stable version
kubectl apply -f ../../manifest/argocd-namespaced-stable.yaml

# Deploy HA version
kubectl apply -f ../../manifest/argocd-namespaced-ha.yaml
```

## Deployment Variants

### Values Files

The component includes two values files for customization:

- `values-stable.yaml`: Configuration for stable deployment (single replica)
- `values-ha.yaml`: Configuration for HA deployment (multiple replicas with Redis HA)

### Key Differences

**Stable Deployment:**

- Single replica for all components
- Single Redis instance
- Suitable for development/testing environments

**HA Deployment:**

- Multiple replicas for server, repo-server, and applicationSet
- Redis HA with sentinel configuration
- Single controller replica (active/passive HA)
- Suitable for production environments

## Customization

You can modify the values files to customize the deployment:

```yaml
# Example: Custom server configuration in values-stable.yaml
server:
  replicas: 1
  service:
    type: LoadBalancer  # Change from ClusterIP
    annotations:
      service.beta.kubernetes.io/aws-load-balancer-type: nlb
```

## Manual Installation (Reference)

For manual installation using helm commands directly:

```bash
# Add ArgoCD Helm repository
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update

# Create namespace
kubectl create namespace argocd

# Install stable ArgoCD
helm upgrade --install argocd -n argocd argo/argo-cd

# Install HA ArgoCD
helm upgrade --install argocd -n argocd argo/argo-cd \
  --set redis-ha.enabled=true \
  --set controller.replicas=1 \
  --set server.replicas=2 \
  --set repoServer.replicas=2 \
  --set applicationSet.replicas=2
```

## Directory Structure

```text
components/argocd/
├── Makefile              # Build automation
├── README.md            # This file
├── values-stable.yaml   # Stable deployment values
└── values-ha.yaml       # HA deployment values
```

## Build Output

Generated manifests are placed in:

- `../../manifest/argocd-namespaced-stable.yaml`
- `../../manifest/argocd-namespaced-ha.yaml`

## Cleanup

```bash
make clean
```

This removes all generated build artifacts.
