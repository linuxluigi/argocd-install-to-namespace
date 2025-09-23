# Multi-Component Kubernetes Manifest Generator
# Orchestrates building manifests for multiple components

# Default namespace configurations
ARGOCD_NAMESPACE ?= argocd
HETZNER_CCM_NAMESPACE ?= kube-system
CILIUM_NAMESPACE ?= kube-system

# Component directories
COMPONENTS_DIR = components
ARGOCD_DIR = $(COMPONENTS_DIR)/argocd
HETZNER_CCM_DIR = $(COMPONENTS_DIR)/hetzner-ccm
CILIUM_DIR = $(COMPONENTS_DIR)/cilium

# Output directory
OUTPUT_DIR = manifest

# Component list
COMPONENTS = argocd hetzner-ccm cilium

.PHONY: all build clean help list-components argocd hetzner-ccm hetzner-ccm-public hetzner-ccm-private cilium cilium-kube-proxy cilium-kube-proxy-gateway

# Default target builds all components
all: build

# Build all components
build: argocd hetzner-ccm cilium
	@echo "✅ All components built successfully!"
	@echo "📁 Manifests available in: $(OUTPUT_DIR)/"
	@ls -la $(OUTPUT_DIR)/

# Build ArgoCD components
argocd:
	@echo "🏗️  Building ArgoCD components..."
	@$(MAKE) -C $(ARGOCD_DIR) build NAMESPACE=$(ARGOCD_NAMESPACE)

# Build Hetzner CCM components (both public and private)
hetzner-ccm:
	@echo "🏗️  Building Hetzner CCM components..."
	@$(MAKE) -C $(HETZNER_CCM_DIR) build NAMESPACE=$(HETZNER_CCM_NAMESPACE)

# Build only Hetzner CCM public network variant
hetzner-ccm-public:
	@echo "🏗️  Building Hetzner CCM (public network)..."
	@$(MAKE) -C $(HETZNER_CCM_DIR) build-public NAMESPACE=$(HETZNER_CCM_NAMESPACE)

# Build only Hetzner CCM private network variant
hetzner-ccm-private:
	@echo "🏗️  Building Hetzner CCM (private network)..."
	@$(MAKE) -C $(HETZNER_CCM_DIR) build-private NAMESPACE=$(HETZNER_CCM_NAMESPACE)

# Build Cilium components (all variants)
cilium:
	@echo "🏗️  Building Cilium components..."
	@$(MAKE) -C $(CILIUM_DIR) build NAMESPACE=$(CILIUM_NAMESPACE)

# Build only Cilium with kube-proxy (without GatewayAPI)
cilium-kube-proxy:
	@echo "🏗️  Building Cilium with kube-proxy..."
	@$(MAKE) -C $(CILIUM_DIR) build-kube-proxy NAMESPACE=$(CILIUM_NAMESPACE)

# Build only Cilium with kube-proxy and GatewayAPI
cilium-kube-proxy-gateway:
	@echo "🏗️  Building Cilium with kube-proxy and GatewayAPI..."
	@$(MAKE) -C $(CILIUM_DIR) build-kube-proxy-gateway NAMESPACE=$(CILIUM_NAMESPACE)

# Clean all components
clean:
	@echo "🧹 Cleaning all components..."
	@$(MAKE) -C $(ARGOCD_DIR) clean
	@$(MAKE) -C $(HETZNER_CCM_DIR) clean
	@$(MAKE) -C $(CILIUM_DIR) clean
	@rm -rf $(OUTPUT_DIR)
	@rm -rf build/
	@echo "✅ Cleanup completed!"

# List available components
list-components:
	@echo "📋 Available components:"
	@for component in $(COMPONENTS); do \
		echo "  - $$component"; \
	done

# Show help
help:
	@echo "🚀 Multi-Component Kubernetes Manifest Generator"
	@echo ""
	@echo "Available targets:"
	@echo "  all                          - Build all components (default)"
	@echo "  build                        - Build all components"
	@echo "  argocd                       - Build only ArgoCD components"
	@echo "  hetzner-ccm                  - Build both Hetzner CCM variants"
	@echo "  hetzner-ccm-public           - Build only Hetzner CCM (public network)"
	@echo "  hetzner-ccm-private          - Build only Hetzner CCM (private network)"
	@echo "  cilium                       - Build all Cilium variants"
	@echo "  cilium-kube-proxy            - Build Cilium with kube-proxy"
	@echo "  cilium-kube-proxy-gateway    - Build Cilium with kube-proxy and GatewayAPI"
	@echo "  clean                        - Clean all generated files"
	@echo "  list-components              - List available components"
	@echo "  help                         - Show this help message"
	@echo ""
	@echo "Configuration:"
	@echo "  ARGOCD_NAMESPACE      - Namespace for ArgoCD (default: argocd)"
	@echo "  HETZNER_CCM_NAMESPACE - Namespace for Hetzner CCM (default: kube-system)"
	@echo "  CILIUM_NAMESPACE      - Namespace for Cilium (default: kube-system)"
	@echo ""
	@echo "Examples:"
	@echo "  make build"
	@echo "  make argocd ARGOCD_NAMESPACE=my-argocd"
	@echo "  make hetzner-ccm HETZNER_CCM_NAMESPACE=hetzner-system"
	@echo "  make hetzner-ccm-private"
	@echo "  make cilium-kube-proxy"
	@echo "  make cilium-kube-proxy-gateway CILIUM_NAMESPACE=cilium-system"
