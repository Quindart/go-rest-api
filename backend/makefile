.PHONY: help init deps tidy fmt vet test lint check run build clean

APP_NAME ?= go-rest-api
BIN_DIR ?= bin
TARGET ?= .
GO ?= go
MODULE_NAME ?=

# Go module path (if go.mod exists and has content)
MODULE := $(shell $(GO) list -m -f '{{.Path}}' 2>/dev/null)

help: ## Show available commands
	@awk 'BEGIN {FS = ":.*## "; printf "\nUsage:\n  make <target>\n\nTargets:\n"} /^[a-zA-Z_-]+:.*## / {printf "  %-12s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

init: ## Initialize Go module (usage: make init MODULE_NAME=github.com/user/project)
	@if [ -z "$(MODULE)" ]; then \
		if [ -z "$(MODULE_NAME)" ]; then \
			echo "Error: MODULE_NAME is required. Example: make init MODULE_NAME=github.com/user/project"; \
			exit 1; \
		fi; \
		$(GO) mod init $(MODULE_NAME); \
	else \
		echo "go.mod already initialized: $(MODULE)"; \
	fi

deps: ## Download dependencies
	$(GO) mod download

tidy: ## Clean and sync go.mod/go.sum
	$(GO) mod tidy

fmt: ## Format source code
	$(GO) fmt ./...

vet: ## Run go vet
	$(GO) vet ./...

test: ## Run unit tests
	$(GO) test -v ./...

lint: ## Run golangci-lint if installed (fallback to fmt+vet)
	@if command -v golangci-lint >/dev/null 2>&1; then \
		golangci-lint run ./...; \
	else \
		echo "golangci-lint not found, running fmt + vet instead"; \
		$(MAKE) fmt vet; \
	fi

check: fmt vet test ## Run basic quality checks

run: ## Run application
	$(GO) run $(TARGET)

build: ## Build binary into bin/
	@mkdir -p $(BIN_DIR)
	$(GO) build -o $(BIN_DIR)/$(APP_NAME) $(TARGET)

clean: ## Remove build artifacts
	rm -rf $(BIN_DIR)
