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
		transparent = true
	    })
	    vim.cmd([[ colorscheme kanagawa ]])
	end
    }
}
