{
	description = "permalik nixos + nix-darwin";

	inputs = {
	    # Nixos
		nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

        # Home Manager
		home-manager = {
			url = "github:nix-community/home-manager/release-24.11";
			inputs.nixpkgs.follows = "nixpkgs";
		};

        # Nix Darwin
        darwin = {
            url = "github:LnL7/nix-darwin/nix-darwin-24.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };
	};

	outputs = {
		self,
		nixpkgs,
        darwin,
		home-manager,
		...
	} @ inputs:
	let
		inherit (self) outputs;

		# User Configuration
		users = {
			permalik = {
				name = "permalik";
				email = "permalik@protonmail.com";
				homeDir = "/home/permalik";
			};
		};
	in {	
		# NixOS Configuration
		nixosConfigurations = {
			nixos = nixpkgs.lib.nixosSystem {
				specialArgs = {inherit inputs outputs;};
				modules = [./hosts/linux];
				# system = "x86_64-linux";
			};
		};

        # Nix-Darwin Configuration
        darwinConfigurations = {
            "permalik" = darwin.lib.darwinSystem {
                system = "aarch64-darwin";
                specialArgs = {
                    inherit inputs outputs;
                    userConfig = users.permalik;
                };
                modules = [
                    ./hosts/mac
                        home-manager.darwinModules.home-manager
                ];
            };
        };
		
		# Linux Home Manager Configuration
		homeConfigurations = {
			"permalik@nixos" = home-manager.lib.homeManagerConfiguration {
				pkgs = nixpkgs.legacyPackages.x86_64-linux;
				extraSpecialArgs = {
					inherit inputs outputs;
					userConfig = users.permalik;
					homeModules = "${self}/home-manager";
				};
				modules = [./home/linux];
			};
		};

		# Nix-Darwin Home Manager Configuration
		homeConfigurations = {
			"permalik@permalik" = home-manager.lib.homeManagerConfiguration {
				pkgs = nixpkgs.legacyPackages.aarch64-darwin;
				extraSpecialArgs = {
					inherit inputs outputs;
					userConfig = users.permalik;
					homeModules = "${self}/home-manager";
				};
				modules = [./home/mac];
			};
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
