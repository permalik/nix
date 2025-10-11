{
  inputs,
  lib,
  config,
  pkgs,
  userConfig,
  unstable,
  ...
}: {
  imports = [
    ../programs/nvim
    ../programs/tmux
  ];

  home = {
    username = "permalik";
    homeDirectory = "/home/permalik";
  };

  home.packages = with pkgs; [
    haskell.compiler.native-bignum.ghc983
    haskellPackages.cabal-install
    just
    nodejs_22
    pnpm_9
    rustup
    starship
    tree
    unstable.zig_0_14
    zls
    # brave
    # unstable.ghostty
    # Compression
    /*
    	   xz
    # zstd
    # p7zip

    # Utils
    ripgrep
    fzf
    jq
    # yq-go
    # eza

    # Networking
    # mtr
    # iperf3
    # dnsutils
    # ldns
    # aria2
    # socat
    # nmap
    # ipcalc

    # Monitoring
    # lsof
    # btop
    # iotop
    # iftop
    # strace
    # ltrace

    # Nix
    # nix-output-monitor

    # Other
    # cowsay
    # file
    # which
    # tree
    # gnused
    # gnutar
    # gawk
    # gnupg
    # hugo
    # glow
    */
  ];
}
