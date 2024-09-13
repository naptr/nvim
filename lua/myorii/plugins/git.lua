return {
    {
	"lewis6991/gitsigns.nvim",
	opts = {
	    signcolumn = true,
	    current_line_blame = true,
	    current_line_blame_opts = {
		delay = 200,
		ignore_whitespace = true
	    },
	    current_line_blame_formatter = " <author> • <author_time:%x, %R> • <summary>",
	}
    }
}
