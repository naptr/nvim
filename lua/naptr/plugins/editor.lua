return {
    {
        "folke/flash.nvim",
        opts = {}
    },
    {
        "numToStr/Comment.nvim",
        opts = {}
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function ()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {}
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons"
        },
        opts = {
            defaults = {
                layout_config = {
                    height = 0.80, width = 0.70,
                    prompt_position = "top"
                }
            },
        }
    },
    "metakirby5/codi.vim",
    "folke/trouble.nvim",
    "tpope/vim-fugitive",
    {
        "f-person/git-blame.nvim",
        opts = {
            ignored_filetypes = {'netrw'}
        }
    },
    "mbbill/undotree",
    "sainnhe/gruvbox-material",
    {
        "freddiehaddad/feline.nvim",
        config = function () require("naptr.statusline") end
    }
}
