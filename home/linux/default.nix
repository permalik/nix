{homeModules, ...}: {
  imports = [
    homeModules.core
  ];

  # Enable Home-Manager
  programs.home-manager.enable = true;

  # Smooth system service reloads when changing configuration
  # systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11"; # Did you read the comment?
}
