.PHONY: rebuild
rebuild:
	sudo ./rebuild.sh

.PHONY: update
update:
	cd /etc/nixos && home-manager switch --flake .#permalik@nixos
