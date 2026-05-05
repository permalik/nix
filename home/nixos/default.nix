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
    ../../home-manager/programs/nvim
    ../../home-manager/programs/tmux
    ../../home-manager/programs/bash
  ];

  home = {
    username = "permalik";
    homeDirectory = "/home/permalik";
  };

  # Enable Home-Manager
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    cargo
    discord
    gcc
    httpie
    just
    kdePackages.dolphin
    nodejs_24
    obsidian
    pkg-config
    pnpm_9
    rust-analyzer-unwrapped
    rustc
    slack
    starship
    tree
    turbo
  ];

  # Smooth system service reloads when changing configuration
  # systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.11"; # Did you read the comment?
}
