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
	    vim.cmd([[ colorscheme kanagawa ]])
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

	    -- vim.cmd([[ colorscheme mellow ]])
	end
    }
}
