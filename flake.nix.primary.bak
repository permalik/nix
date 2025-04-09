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

		# NixOS Configuration
		mkNixosConfiguration = hostname: username:
			nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				specialArgs = {
					inherit inputs outputs;
					userConfig = users.${username};
				};
				modules = [./hosts/${hostname}];
			};

		# Nix-Darwin Configuration
		mkDarwinConfiguration = hostname: username:
			darwin.lib.darwinSystem {
				system = "aarch64-darwin";
				specialArgs = {
					inherit inputs outputs;
					userConfig = users.${username};
				};
				modules = [
					./hosts/${hostname}
					home-manager.darwinModules.home-manager
				];
			};

		# Home-Manager Configuration
		mkHomeConfiguration = system: username: hostname:
			home-manager.lib.homeManagerConfiguration {
				pkgs = nixpkgs.legacyPackages.${system};
				extraSpecialArgs = {
					inherit inputs outputs;
					userConfig = users.${username};
					homeModules = "${self}/home-manager";
				};
				modules = [./home/${hostname}];
			};

	in {	
		nixosConfigurations = {
			nixos = mkNixosConfiguration "linux" "permalik";
		};
		
		darwinConfigurations = {
			permalik = mkDarwinConfiguration "mac" "permalik";
		};
		
		homeConfigurations = {
			"permalik@nixos" = mkHomeConfiguration "x86_64-linux" "permalik" "linux";
			"permalik@permalik" = mkHomeConfiguration "aarch64-darwin" "permalik" "mac";
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
