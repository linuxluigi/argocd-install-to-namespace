# ArgoCD Component Configuration

This component generates ArgoCD manifests with proper namespace configuration.

## Configuration

- **Namespace**: `argocd` (default, configurable via `NAMESPACE` variable)
- **Variants**:
  - Stable: Standard ArgoCD installation
  - HA: High Availability ArgoCD installation

## Usage

From the ArgoCD component directory:

```bash
# Build both stable and HA manifests
make build

# Build only stable
make build-stable

# Build only HA
make build-ha

# Use custom namespace
make build NAMESPACE=my-argocd-namespace

# Clean generated files
make clean
```

## Output

- `../../manifest/argocd-namespaced-stable.yaml`
- `../../manifest/argocd-namespaced-ha.yaml`
