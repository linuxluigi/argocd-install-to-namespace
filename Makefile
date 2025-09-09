# Multi-Component Kubernetes Manifest Generator
# Orchestrates building manifests for multiple components

# Default namespace configurations
ARGOCD_NAMESPACE ?= argocd
HETZNER_CCM_NAMESPACE ?= kube-system

# Component directories
COMPONENTS_DIR = components
ARGOCD_DIR = $(COMPONENTS_DIR)/argocd
HETZNER_CCM_DIR = $(COMPONENTS_DIR)/hetzner-ccm

# Output directory
OUTPUT_DIR = manifest

# Component list
COMPONENTS = argocd hetzner-ccm

.PHONY: all build clean help list-components argocd hetzner-ccm hetzner-ccm-public hetzner-ccm-private

# Default target builds all components
all: build

# Build all components
build: argocd hetzner-ccm
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

# Clean all components
clean:
	@echo "🧹 Cleaning all components..."
	@$(MAKE) -C $(ARGOCD_DIR) clean
	@$(MAKE) -C $(HETZNER_CCM_DIR) clean
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
	@echo "  all                  - Build all components (default)"
	@echo "  build                - Build all components"
	@echo "  argocd               - Build only ArgoCD components"
	@echo "  hetzner-ccm          - Build both Hetzner CCM variants"
	@echo "  hetzner-ccm-public   - Build only Hetzner CCM (public network)"
	@echo "  hetzner-ccm-private  - Build only Hetzner CCM (private network)"
	@echo "  clean                - Clean all generated files"
	@echo "  list-components      - List available components"
	@echo "  help                 - Show this help message"
	@echo ""
	@echo "Configuration:"
	@echo "  ARGOCD_NAMESPACE      - Namespace for ArgoCD (default: argocd)"
	@echo "  HETZNER_CCM_NAMESPACE - Namespace for Hetzner CCM (default: kube-system)"
	@echo ""
	@echo "Examples:"
	@echo "  make build"
	@echo "  make argocd ARGOCD_NAMESPACE=my-argocd"
	@echo "  make hetzner-ccm HETZNER_CCM_NAMESPACE=hetzner-system"
	@echo "  make hetzner-ccm-private"
