{pkgs, ...}: {
	programs.neovim = {
		enable = true;
		package = pkgs.neovim-unwrapped;
		defaultEditor = true;
	};

	xdg.configFile = {
		"nvim" = {
			source = ./nvim;
			recursive = true;
		};
	};
}
