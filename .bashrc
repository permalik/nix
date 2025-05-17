alias list_pkg="nix-store -q --references /run/current-system | grep -vE '^/nix/store/.+-man$'"
# get path
# nix eval --raw nixpkgs#jdt-language-server.outPath

# Clean old configs
# nix-collect-garbage

# Delete all unused paths
# nix-collect-garbage -d

. /etc/os-release
if [[ "$ID" == "nixos" && "$VERSION_ID" == "24.11" ]]; then
  alias nv="/home/tymalik/.nix-profile/bin/nvim"
fi

