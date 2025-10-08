return {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function ()
        local telescopeConfig = require("telescope.config")

        -- clone default telescope configuration
        local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
        -- search inside dotfiles
        table.insert(vimgrep_arguments, "--hidden")
        -- exclude .git folder
        table.insert(vimgrep_arguments, "--glob")
        table.insert(vimgrep_arguments, "!**/.git/*")

        require("telescope").setup({
            defaults = {
                file_ignore_patterns = {
                    "node_modules"
                },
                vimgrep_arguments = vimgrep_arguments
            },
            pickers = {
                find_files = {
                    find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*", "--glob", "!**/dist/*" }
                }
            }
        })

        local builtin = require("telescope.builtin")

        vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
        vim.keymap.set("n", "<leader>fg", builtin.git_files, {})
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
        vim.keymap.set("n", "<leader>fc", builtin.highlights, {})
        vim.keymap.set("n", "<leader>fs", builtin.live_grep, {})
    end
}
