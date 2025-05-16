.PHONY: rebuild
rebuild:
	sudo ./rebuild.sh

.PHONY: update_linux
update_linux:
	cd /etc/nixos && home-manager switch --flake .#permalik@nixos

.PHONY: update_flake
darwin_flake:
	darwin-rebuild switch --flake .#mac

.PHONY: update_flake
darwin_hm:
	home-manager switch --flake .#permalik@mac

# install nix-darwin
# nix run nix-darwin/nix-darwin-24.11#darwin-rebuild --extra-experimental-features "nix-command flakes" -- switch --flake .#permalik
