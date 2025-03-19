#!/run/current-system/sw/bin/bash
sudo cp ./.gitignore /etc/nixos
sudo cp ./configuration.nix /etc/nixos
sudo cp ./flake.lock /etc/nixos
sudo cp ./flake.nix /etc/nixos
sudo cp ./hardware-configuration.nix /etc/nixos
sudo cp ./home.nix /etc/nixos
sudo cp -r ./config /etc/nixos
