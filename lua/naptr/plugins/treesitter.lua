return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring",
    },
    build = ":TSUpdate",
    config = function ()
        local configs = require("nvim-treesitter.configs")
        configs.setup({
            ensure_installed = {
                "javascript", "typescript", "vue", "html", "tsx", "lua","rust",
                "zig", "css", "scss", "vimdoc", "cpp", "yuck", "bash", "c_sharp",
                "yaml", "dockerfile", "go"
            },
            sync_install = false,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false
            },
            indent = {
                enable = true
            }
        })
    end
}
