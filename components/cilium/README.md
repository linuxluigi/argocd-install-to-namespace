# Cilium CNI Component

This component generates Kubernetes manifests for Cilium CNI with different configurations.

## Available Variants

The component builds four different manifest variants:

### 1. With kube-proxy (without GatewayAPI)

- **File**: `cilium-with-kube-proxy.yaml`
- **Description**: Standard Cilium deployment that works alongside existing kube-proxy
- **Use case**: Traditional Kubernetes clusters with existing kube-proxy setup

### 2. With kube-proxy and GatewayAPI

- **File**: `cilium-with-kube-proxy-gateway.yaml`
- **Description**: Cilium with kube-proxy and Gateway API support enabled
- **Use case**: Modern load balancing and ingress with Gateway API while keeping kube-proxy

### 3. Without kube-proxy (without GatewayAPI)

- **File**: `cilium-without-kube-proxy.yaml`
- **Description**: Cilium replaces kube-proxy completely for better performance
- **Use case**: High-performance clusters where Cilium handles all networking

### 4. Without kube-proxy with GatewayAPI

- **File**: `cilium-without-kube-proxy-gateway.yaml`
- **Description**: Full Cilium networking with Gateway API support
- **Use case**: Modern cloud-native clusters with advanced networking features

## Configuration

All variants use these common Talos-specific settings:

- `ipam.mode=kubernetes` - Use Kubernetes IPAM
- `cgroup.autoMount.enabled=false` - Disable cgroup auto-mounting for Talos
- `cgroup.hostRoot=/sys/fs/cgroup` - Talos cgroup path
- Enhanced security capabilities for Talos compatibility

## Usage

Build all variants:

```bash
make -C components/cilium build
```

Build specific variants:

```bash
make -C components/cilium build-kube-proxy
make -C components/cilium build-kube-proxy-gateway
make -C components/cilium build-no-kube-proxy
make -C components/cilium build-no-kube-proxy-gateway
```

## Parameters

- `NAMESPACE`: Target namespace (default: `kube-system`)
- `CILIUM_VERSION`: Cilium version to deploy (default: `1.18.0`)

## Installation Notes

When deploying on Talos Linux, the cluster may appear to hang on phase 18/19 with "retrying error: node not ready". This is expected behavior as nodes are only marked ready once the CNI is installed. Apply the appropriate Cilium manifest during this window to complete the bootstrap process.
