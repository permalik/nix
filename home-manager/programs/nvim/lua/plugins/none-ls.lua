require("null-ls").setup {
    on_attach = function(client, bufnr)
        if client.resolved_capabilities.document_formatting then
            vim.cmd "nnoremap <silent><buffer> <Leader>f :lua vim.lsp.buf.formatting()<CR>"

            -- format on save
            vim.cmd "autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()"
        end

        if client.resolved_capabilities.document_range_formatting then
            vim.cmd "xnoremap <silent><buffer> <Leader>f :lua vim.lsp.buf.range_formatting({})<CR>"
        end
    end,
}
-- {
--     "nvimtools/none-ls.nvim",
--     config = function()
--         local null_ls = require "null-ls"
--
--         null_ls.setup {
--             on_attach = function(client, bufnr)
--                 if client.resolved_capabilities.document_formatting then
--                     vim.cmd "nnoremap <silent><buffer> <Leader>f :lua vim.lsp.buf.formatting()<CR>"
--
--                     -- format on save
--                     vim.cmd "autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()"
--                 end
--
--                 if client.resolved_capabilities.document_range_formatting then
--                     vim.cmd "xnoremap <silent><buffer> <Leader>f :lua vim.lsp.buf.range_formatting({})<CR>"
--                 end
--             end,
--         }
--
--         local prettier = require "prettier"
--
--         prettier.setup {
--             bin = "prettier", -- or `'prettierd'` (v0.23.3+)
--             filetypes = {
--                 "css",
--                 "graphql",
--                 "html",
--                 "javascript",
--                 "javascriptreact",
--                 "json",
--                 "less",
--                 "markdown",
--                 "scss",
--                 "typescript",
--                 "typescriptreact",
--                 "yaml",
--             },
--         }
--     end,
-- },
