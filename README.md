# argocd-kustomize-namespace

This repository automates downloading ArgoCD install manifests and customizing them with a specific namespace using Kustomize. It supports both standard and high-availability (HA) ArgoCD installations.

## Features

- Downloads the latest ArgoCD install and HA manifests
- Adds a custom namespace to all resources
- Includes the namespace object in the output manifest
- Outputs manifests to the `manifest/` directory

## Usage

1. **Install dependencies**
   - [Kustomize](https://kubectl.docs.kubernetes.io/installation/kustomize/)
   - (Optional) [Homebrew](https://brew.sh/) for macOS: `brew install kustomize`

2. **Build manifests**

   ```sh
   make build
   ```

   - Outputs:
     - `manifest/argocd-namespaced-stable.yaml`
     - `manifest/argocd-namespaced-ha.yaml`

3. **Clean generated files**

   ```sh
   make clean
   ```

## Customization

- Change the namespace by setting the `NAMESPACE` variable:

  ```sh
  make build NAMESPACE=my-namespace
  ```

## License

This repository includes files generated from the upstream [ArgoCD project](https://github.com/argoproj/argo-cd), which is licensed under the Apache License 2.0. See [LICENSE](LICENSE) for details.
