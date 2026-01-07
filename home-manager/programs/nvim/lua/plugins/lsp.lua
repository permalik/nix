-- ============================================================
-- LSP ATTACH: keymaps, highlights, inlay hints
-- ============================================================

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("CustomLspConfig", { clear = true }),
    callback = function(event)
        local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, {
                buffer = event.buf,
                desc = "LSP: " .. desc,
            })
        end

        local tb = require "telescope.builtin"

        map("gd", tb.lsp_definitions, "[g]oto [d]efinition")
        map("gr", tb.lsp_references, "[g]oto [r]eferences")
        map("gI", tb.lsp_implementations, "[g]oto [i]mplementation")
        map("<leader>D", tb.lsp_type_definitions, "Type [d]efinition")
        map("<leader>ds", tb.lsp_document_symbols, "[d]ocument [s]ymbols")
        map("<leader>ws", tb.lsp_dynamic_workspace_symbols, "[w]orkspace [s]ymbols")
        map("<leader>rn", vim.lsp.buf.rename, "[r]e[n]ame")
        map("<leader>ca", vim.lsp.buf.code_action, "[c]ode [a]ction", { "n", "x" })
        map("gD", vim.lsp.buf.declaration, "[g]oto [D]eclaration")

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if not client then
            return
        end

        -- Document highlights
        if client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local hl = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })

            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = event.buf,
                group = hl,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = event.buf,
                group = hl,
                callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
                buffer = event.buf,
                callback = function()
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds { group = hl, buffer = event.buf }
                end,
            })
        end

        -- Inlay hints
        if client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map("<leader>th", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, "[t]oggle inlay [h]ints")
        end
    end,
})

-- ============================================================
-- CAPABILITIES
-- ============================================================

local capabilities =
    require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- ============================================================
-- SERVER DEFINITIONS (shared defaults applied later)
-- ============================================================

local servers = {
    dockerls = {},
    astro = {},
    bashls = {},
    clangd = {},
    cmake = {},
    emmet_language_server = {},
    gopls = {},
    marksman = {},
    ocamllsp = {},
    pyright = {},
    slint_lsp = {},
    svelte = {},
    tailwindcss = {},
    terraformls = {},
    ts_ls = {},
    vimls = {},
    yamlls = {},
    zls = {},
}

-- ============================================================
-- INDIVIDUAL SERVER CONFIGS
-- ============================================================

vim.lsp.config.ccls = {
    cmd = { "/usr/bin/ccls" },
    filetypes = { "c", "cpp" },
    offset_encoding = "utf-32",

    root_dir = function(fname)
        local root = vim.fs.find({ "compile_commands.json", ".git" }, {
            upward = true,
            path = fname,
        })[1]
        return root and vim.fs.dirname(root) or vim.loop.cwd()
    end,

    init_options = {
        index = { threads = 0 },
        clang = { excludeArgs = { "-frounding-math" } },
    },
}

vim.lsp.config.lua_ls = {
    settings = {
        Lua = {
            completion = { callSnippet = "Replace" },
            diagnostics = {
                globals = { "vim" },
                disable = { "missing-fields", "lowercase-global" },
            },
        },
    },
}

vim.lsp.config.jsonls = {}
vim.lsp.config.html = {}
vim.lsp.config.cssls = {}

vim.lsp.config.racket_langserver = {
    cmd = { "racket", "-l", "racket-langserver" },
    filetypes = { "racket" },
    root_dir = function(fname)
        local root = vim.fs.find({ "racket-project.rkt", ".git" }, {
            upward = true,
            path = fname,
        })[1]
        return root and vim.fs.dirname(root) or vim.loop.cwd()
    end,
}

vim.lsp.config.rust_analyzer = {
    settings = {
        ["rust-analyzer"] = {
            imports = {
                granularity = { group = "module" },
                prefix = "self",
            },

            diagnostics = {
                disabled = { "inactive-code", "unresolved-proc-macro" },
            },

            cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                buildScripts = { enable = true },
            },

            procMacro = { enable = true },

            checkOnSave = {
                enable = true,
                command = "check",
                extraArgs = { "--all-targets" },
            },

            inlayHints = {
                enable = true,
                typeHints = true,
                parameterHints = true,
                chainingHints = true,
            },

            completion = {
                autoself = true,
                autoimport = true,
            },

            hover = {
                actions = {
                    enable = true,
                    run = true,
                },
            },

            lens = { enable = true },

            files = {
                excludeDirs = { ".git", "target", "node_modules" },
            },
        },
    },
}

-- Baseline config
-- vim.lsp.config.rust_analyzer = {
--   settings = {
--     ["rust-analyzer"] = {
--       imports = {
--         granularity = { group = "module" },
--         prefix = "self",
--       },
--       cargo = { buildScripts = { enable = true } },
--       procMacro = { enable = true },
--     },
--   },
-- }

-- ============================================================
-- APPLY SHARED DEFAULTS
-- ============================================================

for name, config in pairs(servers) do
    vim.lsp.config[name] = vim.tbl_deep_extend("force", {
        capabilities = capabilities,
    }, config)
end

-- ============================================================
-- ENABLE LSP AUTOSTART (EXPLICIT)
-- ============================================================

local enable = {
    -- bulk servers
    "dockerls",
    "astro",
    "bashls",
    "clangd",
    "cmake",
    "emmet_language_server",
    "gopls",
    "marksman",
    "ocamllsp",
    "pyright",
    "slint_lsp",
    "svelte",
    "tailwindcss",
    "terraformls",
    "ts_ls",
    "vimls",
    "yamlls",
    "zls",

    -- explicitly configured
    "ccls",
    "lua_ls",
    "jsonls",
    "html",
    "cssls",
    "racket_langserver",
    "rust_analyzer",
}

vim.lsp.enable(enable)
