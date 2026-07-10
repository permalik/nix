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
    '';

    plugins = with pkgs.vimPlugins; [
      catppuccin-nvim
      cmp-nvim-lsp
      conform-nvim
      fzf-lua
      gitsigns-nvim
      gruvbox-nvim
      harpoon2
      haskell-tools-nvim
      indent-blankline-nvim
      kanagawa-nvim
      lspkind-nvim
      lualine-lsp-progress
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
      nvim-lspconfig
      nvim-nio
      nvim-treesitter.withAllGrammars
      plenary-nvim
      # roslyn-nvim
      rose-pine
      sidekick-nvim
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
      astro-language-server
      black
      cargo
      ccls
      delta
      dockerfile-language-server
      emmet-language-server
      fd
      fzf
      gcc
      go
      gopls
      haskellPackages.haskell-language-server
      delve
      golint
      golangci-lint
      gotools
      go-tools
      isort
      jdt-language-server
      lua-language-server
      # ltex-ls
      nil
      nixd
      nixfmt-rfc-style
      nodePackages.eslint
      # nodePackages.sql-formatter
      nodePackages.typescript-language-server
      nodejs
      ocamlPackages.ocaml-lsp
      postgresql
      prettierd
      pyright
      ripgrep
      rust-analyzer
      rustfmt
      shellcheck
      shfmt
      stylua
      tailwindcss-language-server
      terraform-ls
      tree-sitter
      typescript
      universal-ctags
      vscode-langservers-extracted
      xsel
      yaml-language-server
    ];
  };

  xdg.configFile = {
    "nvim/lua" = {
      source = ./lua;
      recursive = true;
    };
    "nvim/init.lua".source = ./init.lua;
    "nvim/lua/nix_paths.lua".text = ''
      return {
        tsdk = "${pkgs.typescript}/lib/node_modules/typescript/lib",
      }
    '';
  };
}
