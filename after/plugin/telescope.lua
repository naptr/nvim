local telescope_builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>fh", telescope_builtin.help_tags, {})
