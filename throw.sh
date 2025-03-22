#!/run/current-system/sw/bin/bash
sudo rm -rf /etc/nixos
sudo cp -r /home/permalik/.config/nix /etc
sudo mv /etc/nix /etc/nixos
