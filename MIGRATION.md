# Migration Guide

This guide helps you migrate from the old single-component setup to the new multi-component structure.

## What Changed

### Repository Structure

- **Old**: Single Makefile handling only ArgoCD
- **New**: Component-based structure with separate directories for each component

### Hetzner CCM

- **Old**: Single `hetzner-ccm.yaml` manifest
- **New**: Two variants:
  - `hetzner-ccm-public.yaml` - For public network usage
  - `hetzner-ccm-private.yaml` - For private network with `networking.enabled=true`

## Migration Steps

### 1. Update Build Commands

**Old commands:**

```bash
make build                    # Built only ArgoCD
make build NAMESPACE=custom   # Custom ArgoCD namespace
```

**New commands:**

```bash
make build                           # Builds all components
make argocd ARGOCD_NAMESPACE=custom # ArgoCD with custom namespace
make hetzner-ccm                     # Both Hetzner CCM variants
make hetzner-ccm-private             # Private network only
```

### 2. Update Manifest Paths

**Old manifests:**

- `manifest/argocd-namespaced-stable.yaml`
- `manifest/argocd-namespaced-ha.yaml`

**New manifests:**

- `manifest/argocd-namespaced-stable.yaml` (unchanged)
- `manifest/argocd-namespaced-ha.yaml` (unchanged)  
- `manifest/hetzner-ccm-public.yaml` (new)
- `manifest/hetzner-ccm-private.yaml` (new)

### 3. Choose Hetzner CCM Variant

Determine which Hetzner CCM configuration you need:

**Public Network (most common):**

```bash
kubectl apply -f manifest/hetzner-ccm-public.yaml
```

**Private Network (for internal networking):**

```bash
kubectl apply -f manifest/hetzner-ccm-private.yaml
```

### 4. Clean Old Files

The new structure is backward compatible, but you can clean old files:

```bash
make clean  # Removes all generated files and legacy directories
```

## Component-Specific Changes

### ArgoCD Component

- No breaking changes
- Same manifests and namespacing behavior
- Moved to `components/argocd/` directory

### Hetzner CCM Component  

- **Breaking Change**: Now generates two manifests instead of one
- **Public variant**: Standard configuration (equivalent to old behavior)
- **Private variant**: New option with `networking.enabled=true`

## Compatibility

### Backward Compatibility

- All existing ArgoCD manifests work exactly the same
- Old build commands still work but may show deprecation warnings

### Forward Compatibility

- New structure supports easy addition of more components
- Component isolation allows independent development and testing
