for chan in nixos nixpkgs; do
  printf "%s: %s\n" $chan $(nix-instantiate --eval --expr "(import <$chan> {}).lib.version" 2>/dev/null);
done
