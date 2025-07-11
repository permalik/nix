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
    vim-plugins = {
      url = "path:./modules/plugins";
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
    vim-plugins,
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

    overlays = [
      (final: prev: {
        unstable = import inputs.nixpkgs-unstable {
          system = prev.system;
          config.allowUnfree = true;
        };
      })
      vim-plugins.overlay
    ];

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
          (import ./modules/system_packages.nix)
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;

              # users.tymalik = {
              #   imports = [
              #     {home.stateVersion = "24.11";}
              #   ];
              # };
              extraSpecialArgs = {
                inherit inputs outputs nixpkgs-unstable;
                userConfig = {
                  name = "tymalik";
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

    mkHomeConfiguration = system: username: hostname: cfg: let
      # cfgModules = {
      #   core_orbstack = import ./home-manager/core_orbstack;
      #   core_mac = import ./home-manager/core_orbstack;
      # };
      # selectedModule = cfgModules.${cfg};
      pkgs = import nixpkgs {
        inherit system;
        overlays = overlays;
        config.allowUnfree = true;
      };
    in
      home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        # pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = {
          inherit inputs outputs;
          userConfig = users.${username};
          homeModules = {
            core_orbstack = import ./home-manager/core_orbstack;
            core_mac = import ./home-manager/core_mac;
            core_parallels = import ./home-manager/core_parallels;
            core_wsl = import ./home-manager/core_wsl;
          };
          # homeModules = selectedModule;
        };
        modules = [
          ./home/${hostname}
        ];
      };
  in {
    overlays = overlays;

    nixosConfigurations = {
      nixos = mkNixosConfiguration "linux" "permalik";
      orb = mkOrbstackConfiguration "orbstack" "tymalik";
      par = mkOrbstackConfiguration "ubuntu-linux-2404" "parallels";
      wsl = mkOrbstackConfiguration "permalik-win" "permalik";
    };

    darwinConfigurations = {
      mac = mkDarwinConfiguration "mac" "tymalik";
    };

    homeConfigurations = {
      "permalik@nixos" = mkHomeConfiguration "x86_64-linux" "permalik" "linux";
      "permalik@orb" = mkHomeConfiguration "aarch64-linux" "tymalik" "orbstack" "core_orbstack";
      "permalik@mac" = mkHomeConfiguration "aarch64-darwin" "tymalik" "mac" "core_mac";
      "parallels@par" = mkHomeConfiguration "aarch64-linux" "parallels" "ubuntu-linux-2404" "core_parallels";
      "permalik@wsl" = mkHomeConfiguration "x86_64-linux" "permalik" "permalik-win" "core_wsl";
    };
  };
}
