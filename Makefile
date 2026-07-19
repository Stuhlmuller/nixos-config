.DEFAULT_GOAL := apply

HOST ?= macbook-pro-m4
FLAKE_SOURCE ?= path:.
FLAKE := $(FLAKE_SOURCE)\#$(HOST)
SYSTEM := $(FLAKE_SOURCE)\#darwinConfigurations.$(HOST).system

.PHONY: apply check build switch verify help

apply:
	$(MAKE) check
	$(MAKE) build
	$(MAKE) switch

check:
	nix flake check $(FLAKE_SOURCE)

build:
	nix build $(SYSTEM) --no-link

switch:
	sudo nix run github:nix-darwin/nix-darwin/master#darwin-rebuild -- switch --flake $(FLAKE)

verify:
	darwin-version
	@command -v darwin-rebuild codex curl cursor direnv gh git gpg jq nixfmt obsidian rg
	@test -d /Applications/Codex.app
	@test -d /Applications/Cursor.app
	@test -d /Applications/Obsidian.app

help:
	@echo "make          Check, build, and activate the $(HOST) configuration"
	@echo "make check    Evaluate and validate the flake"
	@echo "make build    Build without activating"
	@echo "make switch   Activate the configuration"
	@echo "make verify   Verify the activated system and installed tools"
	@echo "make help     Show these commands"
