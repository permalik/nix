{ config, pkgs, ... }:

{
	home.username = "permalik";
	home.homeDirectory = "/home/permalik";

	home.packages = with pkgs; [
		lsof
		zip
		unzip
		ripgrep
		fzf
		neovim
		tmux
		jq
	];

	# home.file.".ssh/allowed_signers".text = "* ${builtins.readFile ./id_ed25519.pub}";

	programs.git = {
		enable = true;
		userName = "permalik";
		userEmail = "permalik@protonmail.com";
		extraConfig = {
			commit.gpgsign = true;
			gpg.format = "ssh";
			gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
			user.signingkey = "~/.ssh/id_ed25519.pub";
		};
	};

	programs.neovim = {
		enable = true;
	};

	home.stateVersion = "24.11";

	programs.home-manager.enable = true;
}
