{ inputs, ... }: let
  utils = inputs.nixCats.utils;
in {
  imports = [
    inputs.nixcats.homeModule
  ];
  config = {
    nixCats = {
      enable = true;
      packageNames = [ "myNvimHomeModule" ];
      luaPath = ./.;
      categoryDefinitions.replace = ({ pkgs, settings, categories, extra, name, mkPlugin, ... }@packageDef: {
        lspsAndRuntimeDeps = {
	  general = with pkgs; [
	    lazygit
	  ];
	  lua = with pkgs; [
	    lua-language-server
	    stylua
	  ];
	  nix = with pkgs; [
	    nixd
	    alejandra
	  ];
	  go = with pkgs; [
	    gopls
	    delve
	    golint
	    golangci-lint
	    gotools
	    go-tools
	    go
	  ];
	};
	startupPlugins = {
	  general = with pkgs.vimPlugins; [
	    lze
	    # lzextras
	    snacks-nvim
	    rose-pine
	    nord-nvim
	    nordic-nvim
	    kanagawa-nvim
	    vim-sleuth
	  ];
	};
	optionalPlugins = {
	  go = with pkgs.vimPlugins; [
	    nvim-dap-go
	  ];
	  lua = with pkgs.vimPlugins; [
	    lazydev-nvim
	  ];
	  general = with pkgs.vimPlugins; [
	    mini-nvim
	    nvim-lspconfig
	    vim-startuptime
	    blink-cmp
	    nvim-treesitter.withAllGrammars
	    lualine-nvim
	    lualine-lsp-progress
	    gitsigns-nvim
	    which-key-nvim
	    nvim-lint
	    conform-nvim
	    nvim-dap
	    nvim-dap-ui
	    nvim-dap-virtual-text
	  ];
	};
	sharedLibraries = {
	  general = with pkgs; [ ];
	};
	environmentVariables = {
	  # test = {
	  #   CATTESTVAR = "It worked!";
	  # };
	};
	python3.libraries = {
	  # test = [ (_:[]) ];
	};
	extraWrapperArgs = {
	  test = [
	    '' --set CATTESTVAR2 "It worked again!"''
	  ];
	};
      });

      packageDefinitions.replace = {
        myNvimHomeModule = {pkgs, name, ...}: {
	  settings = {
	    suffix-path = true;
	    suffix-LD = true;
	    wrapRc = true;
	    aliases = [ "nv" ];
	    hosts.python3.enable = true;
	    hosts.node.enable = true;
	  };
	  categories = {
	    general = true;
	    lua = true;
	    nix = true;
	    go = false;
	  };
	  extra = {
	    nixdExtras.nixpkgs = ''import ${pkgs.path}'';
	  };
	};
      };
    };
  };
}
