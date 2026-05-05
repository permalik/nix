{
  inputs,
  lib,
  config,
  pkgs,
  nixpkgs-unstable,
  userConfig,
  ...
}: {
  programs.bash = {
    enable = true;
    initExtra = ''
      source "$HOME/.config/bash/alias.sh"
      source "$HOME/.config/bash/git-log.sh"
    '';
  };

  xdg.configFile."./bash/alias.sh".source = ./alias.sh;
  xdg.configFile."./bash/git-log.sh".source = ./git-log.sh;
}
