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

.PHONY: all build clean help list-components argocd hetzner-ccm

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

# Build Hetzner CCM component
hetzner-ccm:
	@echo "🏗️  Building Hetzner CCM component..."
	@$(MAKE) -C $(HETZNER_CCM_DIR) build NAMESPACE=$(HETZNER_CCM_NAMESPACE)

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
	@echo "  all              - Build all components (default)"
	@echo "  build            - Build all components"
	@echo "  argocd           - Build only ArgoCD components"
	@echo "  hetzner-ccm      - Build only Hetzner CCM component"
	@echo "  clean            - Clean all generated files"
	@echo "  list-components  - List available components"
	@echo "  help             - Show this help message"
	@echo ""
	@echo "Configuration:"
	@echo "  ARGOCD_NAMESPACE      - Namespace for ArgoCD (default: argocd)"
	@echo "  HETZNER_CCM_NAMESPACE - Namespace for Hetzner CCM (default: kube-system)"
	@echo ""
	@echo "Examples:"
	@echo "  make build"
	@echo "  make argocd ARGOCD_NAMESPACE=my-argocd"
	@echo "  make hetzner-ccm HETZNER_CCM_NAMESPACE=hetzner-system"
