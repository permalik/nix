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
    '';
  };

  xdg.configFile."./bash/git-log.sh".source = ./git-log.sh;
}
