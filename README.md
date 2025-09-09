# Multi-Component Kubernetes Manifest Generator

This repository provides a modular approach to generating Kubernetes manifests for multiple components with proper namespace configuration. Each component is self-contained and can be built independently or as part of a complete deployment.

## 🚀 Components

### 1. ArgoCD

- **Standard Installation**: Regular ArgoCD deployment
- **High Availability**: HA ArgoCD deployment with multiple replicas
- **Namespace**: `argocd` (configurable)

### 2. Hetzner Cloud Controller Manager (CCM)

- **Public Network**: Standard configuration for public network usage
- **Private Network**: Configuration with `networking.enabled=true` for internal networking
- **Helm-based**: Generated from official Hetzner Helm charts
- **Namespace**: `kube-system` (configurable)

## 📁 Project Structure

```text
.
├── components/
│   ├── argocd/                 # ArgoCD component
│   │   ├── Makefile
│   │   └── README.md
│   └── hetzner-ccm/           # Hetzner CCM component
│       ├── Makefile
│       └── README.md
├── manifest/                   # Generated manifests
├── build/                     # Build artifacts
├── Makefile                   # Main orchestrator
└── README.md
```

## 🛠️ Prerequisites

- [Kustomize](https://kubectl.docs.kubernetes.io/installation/kustomize/) - For ArgoCD manifest customization
- [Helm 3.x](https://helm.sh/docs/intro/install/) - For Hetzner CCM chart templating
- `curl` - For downloading upstream manifests

### macOS Installation (via Homebrew)

```bash
brew install kustomize helm
```

## 🚀 Quick Start

### Build All Components

```bash
make build
```

This generates:

- `manifest/argocd-namespaced-stable.yaml`
- `manifest/argocd-namespaced-ha.yaml`
- `manifest/hetzner-ccm-public.yaml`
- `manifest/hetzner-ccm-private.yaml`

### Build Individual Components

```bash
# Build only ArgoCD
make argocd

# Build both Hetzner CCM variants
make hetzner-ccm

# Build only Hetzner CCM public network variant
make hetzner-ccm-public

# Build only Hetzner CCM private network variant
make hetzner-ccm-private
```

### Custom Namespaces

```bash
# Build with custom namespaces
make build ARGOCD_NAMESPACE=my-argocd HETZNER_CCM_NAMESPACE=hetzner-system
```

## 🎯 Usage Examples

### Deploy ArgoCD in Custom Namespace

```bash
make argocd ARGOCD_NAMESPACE=gitops
kubectl apply -f manifest/argocd-namespaced-stable.yaml
```

### Deploy Hetzner CCM

**Public Network (Default):**

```bash
make hetzner-ccm-public
kubectl apply -f manifest/hetzner-ccm-public.yaml
```

**Private Network (Internal Networking):**

```bash
make hetzner-ccm-private
kubectl apply -f manifest/hetzner-ccm-private.yaml
```

### Complete Multi-Component Deployment

```bash
# Build all components
make build

# Apply all manifests
kubectl apply -f manifest/
```

## 🧹 Cleanup

```bash
# Clean all generated files
make clean
```

## 📖 Component Documentation

Each component has its own README with detailed usage instructions:

- [ArgoCD Component](components/argocd/README.md)
- [Hetzner CCM Component](components/hetzner-ccm/README.md)

## 🔧 Advanced Configuration

### ArgoCD Customization

The ArgoCD component supports both stable and HA deployments. You can build specific variants:

```bash
cd components/argocd
make build-stable    # Standard deployment
make build-ha       # High availability deployment
```

### Hetzner CCM Configuration

The Hetzner CCM component uses Helm templating. You can customize the release name:

```bash
cd components/hetzner-ccm
make build RELEASE_NAME=my-hccm NAMESPACE=custom-namespace
```

## 🆘 Help

```bash
make help
```

## 📝 License

This repository includes files generated from upstream projects:

- [ArgoCD](https://github.com/argoproj/argo-cd) - Apache License 2.0
- [Hetzner Cloud Controller Manager](https://github.com/hetznercloud/hcloud-cloud-controller-manager) - MIT License

See [LICENSE](LICENSE) for complete details.
