return {
    {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	config = true
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
	    }
	}
    }
}
