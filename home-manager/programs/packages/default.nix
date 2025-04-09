{
	inputs,
	lib,
	config,
	pkgs,
	nixpkgs-unstable,
	userConfig,
	...
}: {
	home.packages = with pkgs; [
		# Compression
		zip
		unzip
    /*
		xz
		# zstd
		# p7zip

		# Utils
		ripgrep
		fzf
		jq
		# yq-go
		# eza

		# Networking
		# mtr
		# iperf3
		# dnsutils
		# ldns
		# aria2
		# socat
		# nmap
		# ipcalc

		# Monitoring
		# lsof
		# btop
		# iotop
		# iftop
		# strace
		# ltrace

		# Nix
		# nix-output-monitor

		# Other
		# cowsay
		# file
		# which
		# tree
		# gnused
		# gnutar
		# gawk
		# gnupg
		# hugo
		# glow
    */
	];
}
