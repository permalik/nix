{
	inputs,
	outputs,
	lib,
	config,
	userConfig,
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

	# Nix settings
	nix.settings = {
		experimental-features = "nix-command flakes";
		auto-optimise-store = true;
	};

	# Boot Settings
	boot = {
		loader.efi.canTouchEfiVariables = true;
    		loader.systemd-boot.enable = true;
	};

	# Networking
	networking.networkManager.enable = true;

	# Set your time zone.
  	time.timeZone = "America/Chicago";

	# Select internationalisation properties.
	i18n.defaultLocale = "en_US.UTF-8";
	i18n.extraLocaleSettings = {
		LC_ADDRESS = "en_US.UTF-8";
		LC_IDENTIFICATION = "en_US.UTF-8";
		LC_MEASUREMENT = "en_US.UTF-8";
		LC_MONETARY = "en_US.UTF-8";
		LC_NAME = "en_US.UTF-8";
		LC_NUMERIC = "en_US.UTF-8";
		LC_PAPER = "en_US.UTF-8";
		LC_TELEPHONE = "en_US.UTF-8";
		LC_TIME = "en_US.UTF-8";
	};

	# Enable the X11 windowing system.
	services.xserver.enable = true;

	# Enable the GNOME Desktop Environment.
	services.xserver.displayManager.gdm.enable = true;
	services.xserver.desktopManager.gnome.enable = true;

	# Configure keymap in X11
	services.xserver.xkb = {
		layout = "us";
		variant = "";
	};

	# Enable CUPS to print documents.
	services.printing.enable = true;

	# Enable sound with pipewire.
	hardware.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
	# If you want to use JACK applications, uncomment this
	#jack.enable = true;

	# use the example session manager (no others are packaged yet so this is enabled by default,
	# no need to redefine it in your config for now)
	#media-session.enable = true;
	};

	# User configuration
	users.users.${userConfig.name} = {
		description = userConfig.permalik;
		extraGroups = ["networkmanager" "wheel" "docker"];
		isNormalUser = true;
	};

	# Install firefox.
  	programs.firefox.enable = true;

	# System packages
	environment.systemPackages = with pkgs; [
		gcc
		glib
		gnumake
		killall
		mesa
		pkgs.bind
		git
		vim
		curl
		wget
	];

	# Enable VMware Tools
  	virtualisation.vmware.guest.enable = true;
}
