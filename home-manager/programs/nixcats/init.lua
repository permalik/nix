vim.g.mapleader = " "
vim.g.maplocalleader = " "

if vim.fn.has("termguicolors") == 1 then
  vim.opt.termguicolors = true
end

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.wo.signcolumn = "yes"
vim.wo.relativenumber = true

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Switch Colorscheme
vim.keymap.set("n", "<leader>c0", ":hi Normal guibg=NONE ctermbg=NONE<cr>", {
    desc = "set [c]olorscheme 0: transparent",
    silent = true,
})
-- colorscheme
vim.keymap.set("n", "<leader>c1", ":colorscheme rose-pine-main<cr>", {
    desc = "set [c]olorscheme 1: rose-pine-main",
    silent = true,
})
vim.keymap.set("n", "<leader>c2", ":colorscheme rose-pine-moon<cr>", {
    desc = "set [c]olorscheme 2: rose-pine-moon",
    silent = true,
})
vim.keymap.set("n", "<leader>c3", ":colorscheme rose-pine-dawn<cr>", {
    desc = "set [c]olorscheme 3: rose-pine-dawn",
    silent = true,
})
vim.keymap.set("n", "<leader>c4", ":colorscheme nord<cr>", {
    desc = "set [c]olorscheme 4: nord",
    silent = true,
})
vim.keymap.set("n", "<leader>c5", ":colorscheme nordic<cr>", {
    desc = "set [c]olorscheme 5: nordic",
    silent = true,
})
vim.keymap.set("n", "<leader>c6", ":colorscheme kanagawa-dragon<cr>", {
    desc = "set [c]olorscheme 6: kanagawa-dragon",
    silent = true,
})
vim.keymap.set("n", "<leader>c7", ":colorscheme kanagawa-wave<cr>", {
    desc = "set [c]olorscheme 7: kanagawa-wave",
    silent = true,
})
vim.keymap.set("n", "<leader>c8", ":colorscheme kanagawa-lotus<cr>", {
    desc = "set [c]olorscheme 8: kanagawa-lotus",
    silent = true,
})

vim.cmd.colorscheme("rose-pine-main")
