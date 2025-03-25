{permalikModules, ...}: {
	imports = [
		"${permalikModules}/core"
	];

	# Enable Home-Manager
	programs.home-manager.enable = true;
	
	# Smooth system service reloads upon config changes
	systemd.user.startServices = "sd-services";

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It's perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	system.stateVersion = "24.11"; # Did you read the comment?
}
