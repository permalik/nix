alias list_pkg = "nix-store -q --references /run/current-system | grep -vE '^/nix/store/.+-man$'"
