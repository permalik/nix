{pkgs, ...}: {
	programs.neovim = {
		enable = true;
		package = pkgs.neovim-unwrapped;
		defaultEditor = true;
		withNodeJs = true;
		withPython3 = true;

		extraPackages = with pkgs; [
			golangci-lint
				gopls
				gotools
				isort
				lua-language-server
				markdownlint-cli
				nixd
				nodePackages.bash-language-server
				nodePackages.prettier
				pyright
				shellcheck
				shfmt
				stylua
				vscode-langservers-extracted
				yaml-language-server
		];
	};

	xdg.configFile = {
		"nvim" = {
			source = ./nvim;
			recursive = true;
		};
	};
}
