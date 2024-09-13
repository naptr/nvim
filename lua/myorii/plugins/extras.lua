return {
    {
	"folke/trouble.nvim",
	config = function ()
	    require("trouble").setup({
		icons = false
	    })

	    vim.keymap.set("n", "<leader>tt", function ()
		require("trouble").toggle()
	    end)
	end
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
    }
}
