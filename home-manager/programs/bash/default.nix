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
      source "$HOME/.config/bash/git-log.sh"
      source "$HOME/.config/bash/new-line.sh"
    '';
  };

  xdg.configFile."./bash/git-log.sh".source = ./git-log.sh;
  xdg.configFile."./bash/new-line.sh".source = ./new-line.sh;
}
