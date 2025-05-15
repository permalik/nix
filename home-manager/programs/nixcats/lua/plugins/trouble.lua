vim.keymap.set(
    "n",
    "<leader>xx",
    "<cmd>Trouble diagnostics toggle<cr>",
    { desc = "diagnostics (trouble)" }
)
vim.keymap.set(
    "n",
    "<leader>xX",
    "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
    { desc = "buffer diagnostics (trouble)" }
)
vim.keymap.set(
    "n",
    "<leader>cs",
    "<cmd>Trouble symbols toggle focus=false<cr>",
    { desc = "symbols (trouble)" }
)
vim.keymap.set(
    "n",
    "<leader>cl",
    "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
    { desc = "lsp definitions / references / ... (trouble)" }
)
vim.keymap.set(
    "n",
    "<leader>xL",
    "<cmd>Trouble loclist toggle<cr>",
    { desc = "location list (trouble)" }
)
vim.keymap.set(
    "n",
    "<leader>xQ",
    "<cmd>Trouble qflist toggle<cr>",
    { desc = "quickfix list (trouble)" }
)

require("trouble").setup {}
