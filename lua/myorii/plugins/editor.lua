return {
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {
            enable_check_bracket_line = false,
            fast_wrap = {
                map = "<M-e>",
                chars = { "{", "[", "(", '"', "'" },
                pattern = [=[[%'%"%>%]%)%}%,]]=],
                end_key = "$",
                keys = "qwertyuiopzxcvbnmasdfghjkl",
                check_comma = true,
                highlight = "Search",
                highlight_grey="Comment"
            },
        }
    },
    {
        "windwp/nvim-ts-autotag",
        config = function ()
            require("nvim-ts-autotag").setup({
                opts = {
                    enable_close = true,
                    enable_rename = true,
                    enable_close_on_slash = true
                },
                per_filetype = {
                    ["html"] = {
                        enable_close = false
                    }
                }
            })
        end
    },
    "b0o/schemastore.nvim",
    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            keymaps = {
                ["<C-s>"] = false,
                ["<C-h>"] = false,
                ["<C-l>"] = false
            },
            view_options = {
                show_hidden = true
            },
            default_file_explorer = true
        }
    },
    {
        "github/copilot.vim",
        config = function ()
            vim.g.copilot_no_tab_map = true
            vim.keymap.set('i', '<M-Tab>', 'copilot#Accept("\\<CR>")', {
                expr = true,
                replace_keycodes = false
            })
        end
    },
    {
        "folke/sidekick.nvim",
        opts = {
            cli = {
                mux = {
                    backend = "tmux",
                    enabled = true
                }
            }
        },
        keys = {
            {
                "<M-Tab>",
                function ()
                    if not require("sidekick").nes_jump_or_apply() then
                        return "<Tab>"
                    end
                end,
                expr = true,
                desc = "Goto/ Apply Next Edit Suggestion"
            }
        }
    }
}
