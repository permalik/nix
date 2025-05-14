-- return {
--     {
--         "folke/lazydev.nvim",
--         ft = "lua",
--         opts = {
--             library = {
--                 { path = "luvit-meta/library", words = { "vim%.uv" } },
--             },
--         },
--     },
--     {
--         "Bilal2453/luvit-meta",
--         lazy = true,
--     },
--     {
--         "neovim/nvim-lspconfig",
--         dependencies = {
--             { "williamboman/mason.nvim", config = true },
--             "williamboman/mason-lspconfig.nvim",
--             "WhoIsSethDaniel/mason-tool-installer.nvim",
--             { "j-hui/fidget.nvim", opts = {} },
--             "hrsh7th/cmp-nvim-lsp",
--             "MunifTanjim/prettier.nvim",
--         },
--         config = function()
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("CustomLspConfig", { clear = true }),
    callback = function(event)
        local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        map("gd", require("telescope.builtin").lsp_definitions, "[g]oto [d]efinition")
        map("gr", require("telescope.builtin").lsp_references, "[g]oto [r]eferences")
        map("gI", require("telescope.builtin").lsp_implementations, "[g]oto [i]mplementation")
        map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [d]efinition")
        map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[d]ocument [s]ymbols")
        map(
            "<leader>ws",
            require("telescope.builtin").lsp_dynamic_workspace_symbols,
            "[w]orkspace [s]ymbols"
        )
        map("<leader>rn", vim.lsp.buf.rename, "[r]e[n]ame")
        map("<leader>ca", vim.lsp.buf.code_action, "[c]ode [a]ction", { "n", "x" })
        map("gD", vim.lsp.buf.declaration, "[g]oto [d]eclaration")

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if
            client
            and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight)
        then
            local highlight_augroup =
                vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
                group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
                callback = function(event2)
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds {
                        group = "lsp-highlight",
                        buffer = event2.buf,
                    }
                end,
            })
        end

        if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map("<leader>th", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, "[t]oggle inlay [h]ints")
        end
    end,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local on_attach = function(client)
    require("completion").on_attach(client)
end

local servers = {
    -- "ansiblels",
    "ccls",
    "dockerls",
    -- npm install -g @astrojs/language-server
    -- "arduino_language_server",
    astro = {},
    -- "awk_ls",
    -- npm i -g bash-language-server
    bashls = {},
    clangd = {},
    -- "clojure_lsp",
    cmake = {},
    -- "csharp",
    -- npm i -g vscode-langservers-extracted
    cssls = {},
    -- npm install -g dockerfile-language-server-nodejs
    dockerls = {},
    -- "elixirls",
    -- "elmls",
    -- npm install -g @olrtg/emmet-language-server
    emmet_language_server = {},
    -- "erlangls",
    -- "eslint",
    -- "fennel",
    -- "fsharp_language_server",
    -- "gleam",
    gopls = {},
    -- "hls",
    -- npm i -g vscode-langservers-extracted
    html = {},
    -- cargo install htmx-lsp
    -- "htmx",
    -- "intelephense",
    -- "jinja_lsp",
    -- "jqls",
    -- npm i -g vscode-langservers-extracted
    jsonls = {},
    -- kotlin_language_server = {},
    -- https://github.com/artempyanykh/marksman/releases
    marksman = {},
    -- "metals",
    -- "mojo",
    -- nginx_language_server = {},
    -- "nil_ls",
    -- "nixd",
    -- "ocamlls",
    "ocamllsp",
    -- "omnisharp",
    -- "powershell",
    -- pnpm install -g pyright
    "pyright",
    -- "qml_lsp",
    -- "qmlls",
    -- https://github.com/jeapostrophe/racket-langserver
    -- "rnix",
    -- "ruff",
    -- "ruff_lsp",
    -- https://github.com/rust-lang/rust-analyzer
    rust_analyzer = {},
    slint_lsp = {},
    -- "sqlls",
    -- "sqls",
    "stylua",
    -- npm install -g svelte-language-server
    svelte = {},
    -- npm install -g @tailwindcss/language-server
    "tailwindcss",
    "terraformls",
    -- npm install -g typescript typescript-language-server
    "ts_ls",
    -- npm install -g vim-language-server
    vimls = {},
    -- "volar",
    -- "vuels",
    "yamlls",
    -- https://github.com/zigtools/zls
    "zls",
}

require("lspconfig").cssls.setup {
    capabilities = capabilities,
}
--
-- require("lspconfig").qmlls.setup({
--     cmd = {
--         "/Users/tymalik/Qt/6.7.3/macos/bin/qmlls"
--     },
-- })
-- require("lspconfig").hls.setup({
--     filetypes = {
--         "haskell",
--         "lhaskell",
--         "cabal",
--     },
--     settings = {
--         haskell = {
--             hlintOn = true,
--             cabalFormattingProvider = "cabalfmt",
--             formattingProvider = "ormolu",
--         }
--     },
-- })

require("lspconfig").html.setup {
    capabilities = capabilities,
}

require("lspconfig").jdtls.setup {}

require("lspconfig").jsonls.setup {
    capabilities = capabilities,
}

require("lspconfig").lua_ls.setup {
    settings = {
        Lua = {
            completion = {
                callSnippet = "Replace",
            },
            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            diagnostics = {
                disable = {
                    "missing-fields",
                    "lowercase-global",
                },
            },
        },
    },
}

require("lspconfig").racket_langserver.setup {
    cmd = { "racket", "-l", "racket-langserver" },
    filetypes = { "racket" },
    root_dir = require("lspconfig").util.root_pattern("racket-project.rkt", ".git"),
}

require("lspconfig").rust_analyzer.setup {
    on_attach = on_attach,
    settings = {
        ["rust-analyzer"] = {
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
            cargo = {
                buildScripts = {
                    enable = true,
                },
            },
            procMacro = {
                enable = true,
            },
        },
    },
}

for _, lsp in ipairs(servers) do
    require("lspconfig")[lsp].setup {
        capabilities = capabilities,
    }
end
