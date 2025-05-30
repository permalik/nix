.PHONY: rebuild
rebuild:
	sudo ./rebuild.sh

.PHONY: update_linux
update_linux:
	cd /etc/nixos && home-manager switch --flake .#permalik@nixos

.PHONY: darwin_flake
darwin_flake:
	darwin-rebuild switch --flake .#mac

.PHONY: darwin_hm
darwin_hm:
	home-manager switch --flake .#permalik@mac

.PHONY: orb_flake
orb_flake:
	sudo nixos-rebuild switch --flake .#orb

.PHONY: orb_init_hm
orb_init_hm:
	nix run .#homeConfigurations.permalik@orb.activationPackage

.PHONY: orb_hm
orb_hm:
	home-manager switch --flake .#permalik@orb

# install nix-darwin
# nix run nix-darwin/nix-darwin-24.11#darwin-rebuild --extra-experimental-features "nix-command flakes" -- switch --flake .#permalik

# uninstall home-manager
# nix run home-manager/release-24.11 -- uninstall
