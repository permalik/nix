{
  description = "tymalik nixos + nix-darwin";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixcats.url = "github:birdeehub/nixcats-nvim";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    nixcats,
    darwin,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;

    users = {
      permalik = {
        name = "permalik";
        email = "permalik@protonmail.com";
      };
      tymalik = {
        name = "tymalik";
        email = "permalik@protonmail.com";
      };
    };

    mkNixosConfiguration = hostname: username:
      nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs outputs;
          userConfig = users.${username};
        };
        modules = [./hosts/${hostname}];
      };

    mkOrbstackConfiguration = hostname: username:
      nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        specialArgs = {
          inherit inputs outputs;
          userConfig = users.${username};
        };
        modules = [
          ./hosts/${hostname}/configuration.nix
          ./hosts/${hostname}/orbstack.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;

              users.tymalik = {
                imports = [
                  {home.stateVersion = "24.11";}
                  ./home-manager/programs/git
                  ./home-manager/programs/packages
                  ./home-manager/programs/tmux
                ];
              };
              extraSpecialArgs = {
                inherit inputs outputs nixpkgs-unstable;
                userConfig = {
                  name = "permalik";
                  email = "permalik@protonmail.com";
                };
              };
            };
          }
        ];
      };

    mkDarwinConfiguration = hostname: username:
      darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = {
          inherit inputs outputs;
          userConfig = users.${username};
        };
        modules = [
          ./hosts/${hostname}
          (import ./modules/system_packages.nix)
          home-manager.darwinModules.home-manager
        ];
      };

    mkHomeConfiguration = system: username: hostname:
      home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = {
          inherit inputs outputs;
          userConfig = users.${username};
          homeModules = {
            core_mac = import ./home-manager/core_mac;
          };
        };
        modules = [./home/${hostname}];
      };
  in {
    nixosConfigurations = {
      nixos = mkNixosConfiguration "linux" "permalik";
      orbstack = mkOrbstackConfiguration "orbstack" "tymalik";
    };

    darwinConfigurations = {
      tymalik = mkDarwinConfiguration "mac" "tymalik";
    };

    homeConfigurations = {
      "permalik@nixos" = mkHomeConfiguration "x86_64-linux" "permalik" "linux";
      "tymalik@orbstack" = mkHomeConfiguration "aarch64-linux" "tymalik" "orbstack";
      "permalik@permalik" = mkHomeConfiguration "aarch64-darwin" "tymalik" "mac";
    };

    /*
    modules = [
    ./configuration.nix
    home-manager.nixosModules.home-manager
    {
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.users.permalik = import ./home.nix;
    }
    ];
    */
  };
}
