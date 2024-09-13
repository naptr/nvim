return {
    {
	"folke/trouble.nvim",
	opts = {},
	cmd = "Trouble",
	keys = {
	    {
		"<leader>tt",
		"<cmd>Trouble diagnostics toggle<cr>",
		desc = "Diagnostics (Trouble)"
	    }
	}
    },
    {
	"folke/which-key.nvim",
	event = "VeryLazy",
	keys = {
	    {
		"<leader>?",
		function ()
		    require("which-key").show({ global = false })
		end
	    }
	}
    },
    {
	"folke/flash.nvim",
	opts = {
	    modes = {
		search = { enabled = true },
		char = { jump_labels = true }
	    }
	}
    },
    "metakirby5/codi.vim"
}
