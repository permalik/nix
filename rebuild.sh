#!/run/current-system/sw/bin/bash
# Backup Configuration
sudo mv /etc/nixos/configuration.nix /etc/nixos/configuration.nix.bak
sudo mv /etc/nixos/flake.lock /etc/nixos/flake.lock.bak
sudo mv /etc/nixos/flake.nix /etc/nixos/flake.nix.bak
sudo mv /etc/nixos/hardware-configuration.nix /etc/nixos/hardware-configuration.nix.bak
sudo mv /etc/nixos/home.nix /etc/nixos/home.nix.bak

# Migrate Configuration
sudo cp /home/permalik/Docs/Git/nix/flake.lock /etc/nixos
sudo cp /home/permalik/Docs/Git/nix/flake.nix /etc/nixos
sudo cp -r /home/permalik/Docs/Git/nix/home /etc/nixos
sudo cp -r /home/permalik/Docs/Git/nix/hosts /etc/nixos
sudo cp -r /home/permalik/Docs/Git/nix/modules /etc/nixos
sudo cp -r /home/permalik/Docs/Git/nix/overlays /etc/nixos

# Rebuild Environment
cd /etc/nixos
sudo nixos-rebuild switch --flake /etc/nixos#linux

if [ $? -eq 0 ]; then
	echo "Success: NixOS rebuild complete."
else
	echo "Error: NixOS rebuild failed."
	exit 1
fi

home-manager switch --flake /etc/nixos#permalik@linux

if [ $? -eq 0 ]; then
	echo "Success: home-manager rebuild complete."
	# Remove Backups
	sudo rm /etc/nixos/configuration.nix.bak
	sudo rm /etc/nixos/flake.lock.bak
	sudo rm /etc/nixos/flake.nix.bak
	sudo rm /etc/nixos/hardware-configuration.nix.bak
	sudo rm /etc/nixos/home.nix.bak
	echo "Backups removed."
else
	echo "Error: home-manager rebuild failed."
	exit 1
fi

