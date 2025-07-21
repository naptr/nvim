return {
    {
	"rebelot/kanagawa.nvim",
	lazy = false,
	priority = 1000,
	config = function ()
	    require("kanagawa").setup({
		background = {
		    dark = "dragon"
		},
		transparent = true,
	    })
	    -- vim.cmd([[ colorscheme kanagawa ]])
	end
    },
    {
	"mellow-theme/mellow.nvim",
	config = function ()
	    -- background
	    vim.g.mellow_transparent = true

	    -- texts
	    vim.g.mellow_italic_keywords = true
	    vim.g.mellow_italic_functions = true

	    vim.cmd([[ colorscheme mellow ]])

	    vim.cmd([[ hi! link TelescopePromptTitle TelescopeResultTitle ]])
	    vim.cmd([[ hi! link TelescopePreviewTitle TelescopeResultTitle ]])
	end
    },
    {
	"everviolet/nvim",
	name = "evergarden",
	priority = 1000,
	config = function ()
	    require("evergarden").setup({
		theme = {
		    variant = "spring",
		    accent = "pink"
		},
		editor = {
		    transparent_background = true,
		    override_terminal = false,
		    sign = { color = "none" },
		    float = {
			color = "softbase",
			invert_border = false,
		    },
		    completion = {
			color = "mantle",
		    },
		}
	    })

	    -- vim.cmd([[ colorscheme evergarden ]])
	end
    }
}
