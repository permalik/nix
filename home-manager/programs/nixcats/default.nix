{inputs, ...}: let
  utils = inputs.nixCats.utils;
  dependencyOverlays =
    (import ./overlays inputs)
    ++ [
      (utils.standardPluginOverlay inputs)
      (final: prev: {
        blink-cmp-flake = inputs.blink-cmp.packages.${final.system}.default;
      })
    ];
in {
  imports = [
    inputs.nixcats.homeModule
  ];
  config = {
    nixCats = {
      enable = true;
      packageNames = ["myNvimHomeModule"];
      luaPath = ./.;
      categoryDefinitions.replace = {
        pkgs,
        settings,
        categories,
        extra,
        name,
        mkPlugin,
        ...
      } @ packageDef: {
        lspsAndRuntimeDeps = {
          general = with pkgs; [
            universal-ctags
            ripgrep
            fd
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
          rust = with pkgs; [
            rust-analyzer
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
            # blink-cmp
            cmp-nvim-lsp
            conform-nvim
            gitsigns-nvim
            harpoon2
            haskell-tools-nvim
            indent-blankline-nvim
            kanagawa-nvim
            lspkind-nvim
            lualine-nvim
            lualine-lsp-progress
            luasnip
            # lze
            # lzextras
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
            nvim-jdtls
            nvim-lint
            nvim-lspconfig
            nvim-nio
            nvim-treesitter.withAllGrammars
            plenary-nvim
            roslyn-nvim
            rose-pine
            # snacks-nvim
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
        };
        optionalPlugins = {
          go = with pkgs.vimPlugins; [];
          lua = with pkgs.vimPlugins; [
            lazydev-nvim
          ];
          general = with pkgs.vimPlugins; [
          ];
        };
        sharedLibraries = {
          general = with pkgs; [];
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
            ''--set CATTESTVAR2 "It worked again!"''
          ];
        };
      };

      packageDefinitions.replace = {
        myNvimHomeModule = {
          pkgs,
          name,
          ...
        }: {
          settings = {
            suffix-path = true;
            suffix-LD = true;
            wrapRc = true;
            aliases = ["nv"];
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
