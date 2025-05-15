local actions = require("fzf-lua").actions

require("fzf-lua").setup {
    fzf_opts = { ["--layout"] = "default", ["--marker"] = "+" },
    winopts = {
        width = 0.8,
        height = 0.9,
        preview = {
            hidden = "nohidden",
            vertical = "up:45%",
            horizontal = "right:50%",
            layout = "flex",
            flip_columns = 120,
            delay = 10,
            winopts = { number = false },
        },
    },
    buffers = {
        keymap = { builtin = { ["<C-d>"] = false } },
        actions = { ["ctrl-x"] = false, ["ctrl-d"] = { actions.buf_del, actions.resume } },
    },
}
