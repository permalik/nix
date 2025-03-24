#!/run/current-system/sw/bin/bash
cd /etc/nixos
sudo nix flake update

if [ $? -eq 0 ]; then
	echo "Success: Flake rebuild complete."
else
	echo "Failed: Flake rebuild incomplete."
fi
