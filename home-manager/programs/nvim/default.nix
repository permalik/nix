{
  pkgs,
  userConfig,
  ...
}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraConfig = ''
      set number relativenumber
      vim.cmd("luafile ~/.config/nvim/init.lua")
    '';

    plugins = with pkgs.vimPlugins; [
      conform-nvim
      fzf-lua
      gitsigns-nvim
      gruvbox-nvim
      harpoon2
      haskell-tools-nvim
      indent-blankline-nvim
      kanagawa-nvim
      lualine-nvim
      luasnip
      mini-nvim
      none-ls-nvim
      nord-nvim
      nordic-nvim
      null-ls-nvim
      nvim-autopairs
      nvim-cmp
      nvim-colorizer-lua
      nvim-dap
      nvim-dap-go
      nvim-dap-ui
      nvim-dap-virtual-text
      nvim-lint
      nvim-nio
      nvim-treesitter.withAllGrammars
      plenary-nvim
      roslyn-nvim
      rose-pine
      telescope-nvim
      todo-comments-nvim
      trouble-nvim
      undotree
      vim-fugitive
      vim-illuminate
      vim-obsession
      vim-prettier
      vim-sleuth
      vim-startuptime
      vimtex
      which-key-nvim
    ];

    extraPackages = with pkgs; [
      alejandra
      black
      cargo
      ccls
      delta
      dockerfile-language-server-nodejs
      fd
      fzf
      gcc
      go
      gopls
      delve
      golint
      golangci-lint
      gotools
      go-tools
      isort
      # ltex-ls
      nil
      nixd
      nixfmt-rfc-style
      nodePackages.eslint
      # nodePackages.sql-formatter
      nodePackages.typescript-language-server
      nodejs
      postgresql
      prettierd
      pyright
      ripgrep
      rust-analyzer
      rustfmt
      shellcheck
      shfmt
      stylua
      terraform-ls
      tree-sitter
      universal-ctags
      xsel
    ];
  };

  xdg.configFile = {
    "nvim/lua" = {
      source = ./lua;
      recursive = true;
    };
    "nvim/init.lua".source = ./init.lua;
  };
}
