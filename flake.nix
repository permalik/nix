{
  description = "permalik flake";

  inputs = {
# Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";

# Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
  inherit (self) outputs;

  users = {
    permalik = {
      name = "permalik";
    };
  };

  initNixosConfiguration = hostname: username:
    nixpkgs.lib.nixosSystem {
      modules = [./hosts/${hostname}];
    };

  initHomeConfiguration = system: username: hostname:
    home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {inherit system;};
      modules = [
        ./configuration.nix
        ./home/${username}/${hostname}
      ];
    };

  in {
    nixosConfigurations = {
      linux = initNixosConfiguration "linux" "permalik";
    };

    homeConfigurations = {
      "permalik@linux" = initHomeConfiguration "aarch64-linux" "permalik" "linux";
    };

    overlays = import ./overlays {inherit inputs;};
  };

# nixosConfigurations = {
#   nixos = nixpkgs.lib.nixosSystem {
#     system = "aarch64-linux";
#     modules = [
#       ./configuration.nix
#         home-manager.nixosModules.home-manager
#         {
#           home-manager.useGlobalPkgs = true;
#           home-manager.useUserPackages = true;
#           home-manager.users.permalik = import ./home.nix;
#         }
#     ];
#   };
# };
}
