# Hetzner Cloud Controller Manager Component Makefile

NAMESPACE ?= kube-system
RELEASE_NAME ?= hccm
BUILD_DIR = ../../build/hetzner-ccm
OUTPUT_DIR = ../../manifest

# Helm repository details
HELM_REPO_NAME = hcloud
HELM_REPO_URL = https://charts.hetzner.cloud
HELM_CHART = hcloud/hcloud-cloud-controller-manager

# Output files
FINAL_MANIFEST = $(OUTPUT_DIR)/hetzner-ccm.yaml

.PHONY: all helm-repo-add helm-repo-update template build clean

all: build

# Add Helm repository
helm-repo-add:
	@echo "Adding Hetzner Cloud Helm repository..."
	helm repo add $(HELM_REPO_NAME) $(HELM_REPO_URL) || true

# Update Helm repository
helm-repo-update: helm-repo-add
	@echo "Updating Helm repositories..."
	helm repo update $(HELM_REPO_NAME)

# Template the Helm chart to generate manifests
template: helm-repo-update
	@mkdir -p $(BUILD_DIR)
	@echo "Templating Hetzner CCM Helm chart..."
	helm template $(RELEASE_NAME) $(HELM_CHART) \
		--namespace $(NAMESPACE) \
		--create-namespace \
		--output-dir $(BUILD_DIR)

# Build manifest
build: template
	@mkdir -p $(OUTPUT_DIR)
	@echo "Building Hetzner CCM manifest..."
	@echo "---" > $(FINAL_MANIFEST)
	@echo "apiVersion: v1" >> $(FINAL_MANIFEST)
	@echo "kind: Namespace" >> $(FINAL_MANIFEST)
	@echo "metadata:" >> $(FINAL_MANIFEST)
	@echo "  name: $(NAMESPACE)" >> $(FINAL_MANIFEST)
	@echo "---" >> $(FINAL_MANIFEST)
	@find $(BUILD_DIR) -name "*.yaml" -exec cat {} \; >> $(FINAL_MANIFEST)

# Install via Helm (for reference, not used in manifest generation)
install: helm-repo-update
	@echo "Installing Hetzner CCM via Helm..."
	helm upgrade --install $(RELEASE_NAME) $(HELM_CHART) \
		--namespace $(NAMESPACE) \
		--create-namespace

clean:
	rm -rf $(BUILD_DIR)
