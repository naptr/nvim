return {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function ()
	require("telescope").setup({
	    defaults = {
		file_ignore_patterns = {
		    "node_modules"
		}
	    }
	})

	local builtin = require("telescope.builtin")

	vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
	vim.keymap.set("n", "<leader>fg", builtin.git_files, {})
	vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
	vim.keymap.set("n", "<leader>fs", function ()
		builtin.grep_string({ search = vim.fn.input("Grep > ")})
	end)
    end
}
