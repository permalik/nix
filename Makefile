.PHONY: rebuild
rebuild:
	sudo ./rebuild.sh

.PHONY: update_linux
update_linux:
	cd /etc/nixos && home-manager switch --flake .#permalik@nixos

.PHONY: update_darwin
update_darwin:
	sudo darwin-rebuild switch --flake .#permalik

# Home-Manager from Mac
# home-manager switch --flake .#permalik@permalik

# install nix-darwin
# nix run nix-darwin/nix-darwin-24.11#darwin-rebuild --extra-experimental-features "nix-command flakes" -- switch --flake .#permalik
