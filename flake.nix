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
	} @ inputs: let
		inherit (self) outputs;
		
		users = {
			permalik = {
				name = "permalik";
			};
		};

		initNixosConfiguration = hostname: username:
			nixpkgs.lib.nixosSystem {
				specialArgs = {
					inherit inputs outputs hostname:
					userConfig = users.${username};
					nixosModules = "${self}/modules/nixos";
				};
				modules = [./hosts/${hostname}];
			};

		initHomeConfiguration = system: username: hostname:
			home-manager.lib.homeManagerConfiguration {
				pkgs = import nixpkgs {inherit system;};
				extraSpecialArgs = {
					inherit inputs outputs;
					userConfig = users.${username};
					permalikModules = "${self}/modules/home-manager";
				};
				modules = [
					./home/${username}/${hostname}
				];
			};

		in {
			nixosConfiguration = {
				linux = initNixosConfiguration "linux" "permalik";
			};

			homeConfiguration = {
				"permalik@linux" = initHomeConfiguration "x86_64-linux" "permalik" "linux";
			};
			
			overlays = import ./overlays {inherit inputs;};
		};
		
		/*
		nixosConfigurations = {
			nixos = nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				specialArgs = { inherit inputs; };
				modules = [
					./configuration.nix
						home-manager.nixosModules.home-manager
						{
							home-manager.useGlobalPkgs = true;
							home-manager.useUserPackages = true;
							home-manager.users.permalik = import ./home.nix;
						}
				];
			};
		};
		*/
}
