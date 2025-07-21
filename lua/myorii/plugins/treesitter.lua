return {
    {
        "nvim-treesitter/nvim-treesitter",
        config = function ()
            require("nvim-treesitter.configs").setup({
                indent = { enable = true },
                ensure_installed = {
                    "javascript",
                    "markdown",
                    "css",
                    "html",
                    "vue",
                    "dockerfile",
                    "json",
                    "bash"
                },
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false
                }
            })
        end
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        config = true
    },
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        config = function ()
            require("ts_context_commentstring").setup({
                enable_autocmd = false
            })
            local get_option = vim.filetype.get_option
            vim.filetype.get_option = function (filetype, option)
                return option == "commentstring"
                    and require("ts_context_commentstring.internal").calculate_commentstring()
                    or get_option(filetype, option)
            end
        end
    }
}
