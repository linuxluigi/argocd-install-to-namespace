# ArgoCD Component Makefile

NAMESPACE ?= argocd
BUILD_DIR = ../../build/argocd
DOWNLOAD_DIR = download
OUTPUT_DIR = ../../manifest

# URLs for manifests
MANIFEST_URL_STABLE = https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
MANIFEST_URL_HA = https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/ha/install.yaml

# Manifest file paths
MANIFEST_FILE_STABLE = $(DOWNLOAD_DIR)/install.yaml
MANIFEST_FILE_HA = $(DOWNLOAD_DIR)/ha-install.yaml

# Kustomize directories
KUSTOMIZE_DIR_STABLE = kustomize-stable
KUSTOMIZE_DIR_HA = kustomize-ha

# Output files
FINAL_MANIFEST_STABLE = $(OUTPUT_DIR)/argocd-namespaced-stable.yaml
FINAL_MANIFEST_HA = $(OUTPUT_DIR)/argocd-namespaced-ha.yaml

.PHONY: all download download-stable download-ha kustomize-stable kustomize-ha build build-stable build-ha clean

all: build-stable build-ha

# Download stable manifest
download-stable:
	@mkdir -p $(DOWNLOAD_DIR)
	curl -sSL $(MANIFEST_URL_STABLE) -o $(MANIFEST_FILE_STABLE)

# Download HA manifest
download-ha:
	@mkdir -p $(DOWNLOAD_DIR)
	curl -sSL $(MANIFEST_URL_HA) -o $(MANIFEST_FILE_HA)

# Download both
download: download-stable download-ha

# Kustomize for stable
kustomize-stable: download-stable
	@mkdir -p $(KUSTOMIZE_DIR_STABLE)
	@cp $(MANIFEST_FILE_STABLE) $(KUSTOMIZE_DIR_STABLE)/install.yaml
	@echo "apiVersion: v1\nkind: Namespace\nmetadata:\n  name: $(NAMESPACE)" > $(KUSTOMIZE_DIR_STABLE)/namespace.yaml
	@echo "resources:\n  - install.yaml\n  - namespace.yaml\nnamespace: $(NAMESPACE)" > $(KUSTOMIZE_DIR_STABLE)/kustomization.yaml

# Kustomize for HA
kustomize-ha: download-ha
	@mkdir -p $(KUSTOMIZE_DIR_HA)
	@cp $(MANIFEST_FILE_HA) $(KUSTOMIZE_DIR_HA)/install.yaml
	@echo "apiVersion: v1\nkind: Namespace\nmetadata:\n  name: $(NAMESPACE)" > $(KUSTOMIZE_DIR_HA)/namespace.yaml
	@echo "resources:\n  - install.yaml\n  - namespace.yaml\nnamespace: $(NAMESPACE)" > $(KUSTOMIZE_DIR_HA)/kustomization.yaml

# Build stable manifest
build-stable: kustomize-stable
	@mkdir -p $(OUTPUT_DIR)
	kustomize build $(KUSTOMIZE_DIR_STABLE) > $(FINAL_MANIFEST_STABLE)

# Build HA manifest
build-ha: kustomize-ha
	@mkdir -p $(OUTPUT_DIR)
	kustomize build $(KUSTOMIZE_DIR_HA) > $(FINAL_MANIFEST_HA)

# Build both
build: build-stable build-ha

clean:
	rm -rf $(KUSTOMIZE_DIR_STABLE) $(KUSTOMIZE_DIR_HA) $(DOWNLOAD_DIR)
