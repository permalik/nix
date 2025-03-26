#!/run/current-system/sw/bin/bash
# Backup Configuration
sudo mv /etc/nixos/flake.lock /etc/nixos/flake.lock.bak
sudo mv /etc/nixos/flake.nix /etc/nixos/flake.nix.bak
sudo mv /etc/nixos/core /etc/nixos/core_bak
sudo mv /etc/nixos/home /etc/nixos/home_bak
sudo mv /etc/nixos/home-manager /etc/nixos/home-manager_bak
sudo mv /etc/nixos/hosts /etc/nixos/hosts_bak

# Migrate Configuration
sudo cp /home/permalik/Docs/Git/nix/flake.nix /etc/nixos
sudo cp -r /home/permalik/Docs/Git/nix/core /etc/nixos
sudo cp -r /home/permalik/Docs/Git/nix/home /etc/nixos
sudo cp -r /home/permalik/Docs/Git/nix/home-manager /etc/nixos
sudo cp -r /home/permalik/Docs/Git/nix/hosts /etc/nixos

# Rebuild Environment
cd /etc/nixos
sudo nixos-rebuild switch --flake .#nixos
# sudo nixos-rebuild switch --flake /etc/nixos#linux
# home-manager switch --flake /etc/nixos#permalik@linux

if [ $? -eq 0 ]; then
	echo "Success: NixOS rebuild complete."
	sudo rm /home/permalik/Docs/Git/nix/flake.lock
	sudo cp /etc/nixos/flake.lock /home/permalik/Docs/Git/nix/flake.lock
	sudo rm /etc/nixos/flake.nix.bak
	sudo rm /etc/nixos/flake.lock.bak
	sudo rm -rf /etc/nixos/core_bak
	sudo rm -rf /etc/nixos/home_bak
	sudo rm -rf /etc/nixos/home-manager_bak
	sudo rm -rf /etc/nixos/hosts_bak
	sudo cp -f /home/permalik/.ssh/id_ed25519.pub /etc/nixos/home-manager/programs/git
else
	echo "Error: NixOS rebuild failed."
	exit 1
fi
