return {
    "folke/sidekick.nvim",
    opts = {
        nes = {
            enabled = false,
        },
        cli = {
            mux = {
                backend = "tmux",
                enabled = true,
            },
            tools = {
                codex = {
                    cmd = { "codex" },
                },
            },
        },
    },
    config = function(_, opts)
        require("sidekick").setup(opts)

        local cli = require "sidekick.cli"

        local function open_codex()
            cli.toggle {
                name = "codex",
                focus = true,
            }
        end

        local function send_to_codex(msg, submit)
            cli.send {
                name = "codex",
                msg = msg,
            }
        end

        local function send_selection_to_codex(prompt)
            send_to_codex(string.format("%s\n\n{selection}", prompt))
        end

        vim.keymap.set("n", "<leader>mq", function()
            open_codex()
        end, { desc = "Sidekick Toggle Codex" })

        vim.keymap.set("x", "<leader>mn", function()
            send_to_codex "{selection}"
        end, { desc = "Send Selection to Codex" })

        vim.keymap.set("x", "<leader>mk", function()
            send_selection_to_codex "Implement / analyze / modify as needed."
        end, { desc = "Send Selection → Codex (full flow)" })

        vim.keymap.set("x", "<leader>me", function()
            send_selection_to_codex "Explain this code precisely."
        end, { desc = "Sidekick: Explain Selection" })

        vim.keymap.set("x", "<leader>mf", function()
            send_selection_to_codex "Fix this code. Preserve the existing style."
        end, { desc = "Sidekick: Fix Selection" })

        vim.keymap.set("x", "<leader>mr", function()
            send_selection_to_codex "Refactor this code. Keep behavior identical."
        end, { desc = "Sidekick: Refactor Selection." })
    end,
}
