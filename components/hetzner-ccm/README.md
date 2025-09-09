# Hetzner Cloud Controller Manager Component

This component generates Hetzner Cloud Controller Manager manifests using Helm templating.

## Configuration

- **Namespace**: `kube-system` (default, configurable via `NAMESPACE` variable)
- **Release Name**: `hccm` (configurable via `RELEASE_NAME` variable)
- **Helm Chart**: `hcloud/hcloud-cloud-controller-manager`

## Prerequisites

- Helm 3.x installed
- Access to pull from `https://charts.hetzner.cloud`

## Usage

From the Hetzner CCM component directory:

```bash
# Build manifest
make build

# Use custom namespace and release name
make build NAMESPACE=hetzner-system RELEASE_NAME=my-hccm

# Install directly via Helm (alternative to manifest)
make install

# Clean generated files
make clean
```

## Output

- `../../manifest/hetzner-ccm.yaml`

## Notes

The generated manifest includes:

- Namespace creation
- All Hetzner CCM resources templated from the official Helm chart

For direct Helm installation, you can use the `install` target which runs:

```bash
helm install hccm hcloud/hcloud-cloud-controller-manager -n kube-system --create-namespace
```
