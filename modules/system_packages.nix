{
  config,
  pkgs,
  ...
}: {
  environment.etc."current-system-packages".text = let
    packages = builtins.map (p: "${p.name}") config.environment.systemPackages;
    sortedUnique = builtins.sort builtins.lessThan (pkgs.lib.lists.unique packages);
    formatted = pkgs.lib.strings.concatLines sortedUnique;
  in
    formatted;
}
