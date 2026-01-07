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
  ];

  home = {
    username = "permalik";
    homeDirectory = "/home/permalik";
  };

  # Enable Home-Manager
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    cargo
    gcc
    just
    nodejs_24
    pkg-config
    pnpm_9
    rust-analyzer-unwrapped
    rustc
    starship
    tree
    turbo
  ];

  # Smooth system service reloads when changing configuration
  # systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.11"; # Did you read the comment?
}
