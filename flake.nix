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
	};

	outputs = {
		self,
		nixpkgs,
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
		
		# Home Manager Configuration
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
