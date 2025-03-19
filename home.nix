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
		plugins = [
			## Language Utilities
			pkgs.vimPlugins.nvim-treesitter
			pkgs.vimPlugins.nvim-treesitter.withAllGrammars
			pkgs.vimPlugins.nvim-treesitter-textobjects
			pkgs.vimPlugins.nvim-lspconfig
			pkgs.vimPlugins.clangd_extensions-nvim
			pkgs.vimPlugins.gitsigns-nvim
				
			## Treesitter
			pkgs.vimPlugins.telescope-nvim
			pkgs.vimPlugins.telescope-fzf-native-nvim

			## Tooling
			pkgs.vimPlugins.trouble-nvim
			pkgs.vimPlugins.plenary-nvim
			pkgs.vimPlugins.lualine-nvim
			pkgs.vimPlugins.fidget-nvim

			## CMP
			pkgs.vimPlugins.nvim-cmp
			pkgs.vimPlugins.cmp-nvim-lsp
			pkgs.vimPlugins.cmp-buffer
			pkgs.vimPlugins.cmp-cmdline
			pkgs.vimPlugins.luasnip
			pkgs.vimPlugins.cmp_luasnip

			## Debug
			pkgs.vimPlugins.nvim-dap
			pkgs.vimPlugins.nvim-dap-ui
			pkgs.vimPlugins.nvim-dap-virtual-text

			## TPope
			pkgs.vimPlugins.vim-surround
			pkgs.vimPlugins.vim-obsession
			pkgs.vimPlugins.vim-sleuth

			## Theme
			pkgs.vimPlugins.kanagawa-nvim
		];

		extraConfig = ''
			lua << EOF
			${builtins.readFile config/keymap.lua}
			${builtins.readFile config/option.lua}
			${builtins.readFile config/setup/cmp.lua}
			${builtins.readFile config/setup/treesitter.lua}
			${builtins.readFile config/setup/lspconfig.lua}
			${builtins.readFile config/setup/luasnip.lua}
			${builtins.readFile config/setup/trouble.lua}
			${builtins.readFile config/setup/telescope.lua}
			${builtins.readFile config/setup/lualine.lua}
			${builtins.readFile config/setup/fidget.lua}
			${builtins.readFile config/setup/gitsigns.lua}
			${builtins.readFile config/setup/clangd_extensions.lua}
			${builtins.readFile config/setup/dap.lua}
		'';
		enable = true;
		viAlias = true;
		vimAlias = true;
	};

	xdg.configFile."nvim/init.lua".enable = false;

	home.stateVersion = "24.11";

	programs.home-manager.enable = true;
}
