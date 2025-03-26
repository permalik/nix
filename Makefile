.PHONY: rebuild
rebuild:
	sudo ./rebuild.sh

.PHONY: update
update:
	cd /etc/nixos && home-manager switch --flake .#permalik@nixos


# install nix-darwin
# nix run nix-darwin/nix-darwin-24.11#darwin-rebuild --extra-experimental-features "nix-command flakes" -- switch --flake .#permalik
#
# sudo darwin-rebuild switch --flake .#permalik
