# Hetzner Cloud Controller Manager Component

This component generates Hetzner Cloud Controller Manager manifests using Helm templating. It supports two networking configurations: public network (default) and private network with Hetzner internal networking enabled.

## Variants

### 1. Public Network (Default)

- Uses Hetzner public network infrastructure
- Standard configuration without internal networking
- Suitable for most basic deployments

### 2. Private Network

- Enables Hetzner internal networking with `networking.enabled=true`
- Allows for more secure, private communication between nodes
- Recommended for production environments with internal network requirements

## Component Configuration

- **Namespace**: `kube-system` (configurable via `NAMESPACE` variable)
- **Release Name**: `hccm` (configurable via `RELEASE_NAME` variable)
- **Helm Chart**: `hcloud/hcloud-cloud-controller-manager` Cloud Controller Manager Component

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
# Build both public and private network manifests
make build

# Build only public network manifest
make build-public

# Build only private network manifest
make build-private

# Use custom namespace and release name
make build NAMESPACE=hetzner-system RELEASE_NAME=my-hccm

# Install directly via Helm (public network)
make install-public

# Install directly via Helm (private network)
make install-private

# Clean generated files
make clean
```

## Output

- `../../manifest/hetzner-ccm-public.yaml` - Public network configuration
- `../../manifest/hetzner-ccm-private.yaml` - Private network configuration

## Notes

The generated manifest includes:

- Namespace creation
- All Hetzner CCM resources templated from the official Helm chart

For direct Helm installation, you can use the install targets:

**Public Network:**

```bash
helm install hccm-public hcloud/hcloud-cloud-controller-manager -n kube-system --create-namespace
```

**Private Network:**

```bash
helm install hccm-private hcloud/hcloud-cloud-controller-manager -n kube-system --create-namespace --set networking.enabled=true
```
