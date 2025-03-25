{inputs, ...}: {
	# Make pkgs.stable available in flake.nix
	stable-packages = final: _prev: {
		stable = import inputs.nixpkgs-stable {
			system = final.system;
			config.allowUnfree = true;
		};
	};
}
