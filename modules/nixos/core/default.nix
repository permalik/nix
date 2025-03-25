{
	inputs,
	outputs,
	lib,
	config,
	userconfig,
	pkgs,
	...
}: {
	# Nixpkgs Configuration
	nixpkgs = {
		overlays = [
			outputs.overlays.stable-packages
		];

		config = {
			allowUnfree = true;
		};
	};
	
	# Register flake inputs for nix commands
	nix.registry = lib.mapAttrs (_: flake: {inherit flake;}) (lib.filterAttrs (_: lib.isType "flake") inputs);
	# Add inputs to legacy channels
	nix.nixPath = ["/etc/nix/path"];
	environment.etc =
		lib.mapAttrs' (name: value: {
			name = "nix/path/${name}";
			value.source = value.flake;
		})
		config.nix.registry;
	
	# Nix Settings
	nix.settings = {
		experimental-features = "nix-command flakes";
		auto-optimize-store = true;
	};

	# Boot Settings
	boot = {
		loader.grub.enable = true;
		loader.grub.device = "/dev/sda";
		loader.grub.useOSProber = true;
	};

	# Networking Settings
	networking.networkmanager.enable = true;

	# Timezone Settings
	time.timeZone = "America/Chicago";

	# Internationalization
	i18n.defaultLocale = "en_US.UTF-8";
	i18n.extraLocaleSettings = {
		LC_ADDRESS = "en_US.UTF-8";
		LC_IDENTIFICATION = "en_US.UTF-8";
		LC_MEASURMENT = "en_US.UTF-8";
		LC_MONETARY = "en_US.UTF-8";
		LC_NAME = "en_US.UTF-8";
		LC_NUMERIC = "en_US.UTF-8";
		LC_PAPER = "en_US.UTF-8";
		LC_TELEPHONE = "en_US.UTF-8";
		LC_TIME = "en_US.UTF-8";
	};

	# X11 Settings
	services.xserver = {
		enable = true;
		displayManager.gdm.enable = true;
		desktopManager.gnome.enable = true;
		xkb.layout = "us";
		xkb.variant = "";
		xkb.options = "ctrl:nocaps";
	};

	# Disable CUPS Document Print
	services.printing.enable = false;
	
	# User Configuration
	users.users.${userConfig.name} = {
		description = userConfig.name;
		extraGroups = ["networkmanager" "wheel" "docker"];
		isNormalUser = true;
		# shell = pkgs.zsh;
	};
	
	# No password
	security.sudo.wheelNeedsPassword = false;
	
	# System Packages
	environment.systemPackages = with pkgs; [
		gcc
		glib
		gnumake
		killall
		mesa
	];

	# Docker Configuration
	virtualisation.docker.enable = true;
	virtualisation.docker.rootless.enable = true;
	virtualisation.docker.rootless.setSocketVariable = true;

	# Zsh Configuration
	programs.zsh.enable = true;

	# Fonts Configuration
	fonts.packages = with pkgs; [
		nerd-fonts.jetbrains-mono
		roboto
	];

	# OpenSSH Configuration
	services.openssh.enable = true;

	# Locate Update
	services.locate.enable = true;
}
