vim.opt.fillchars = { eob = " "}
vim.g.netrw_banner = 0

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.termguicolors = true

vim.opt.fillchars = { eob = " " }

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.clipboard = "unnamedplus"

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.wrap = false

vim.opt.smartindent = false
vim.opt.shiftwidth = 4

vim.opt.scrolloff = 8

vim.opt.colorcolumn = "80"

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.signcolumn = "number"

vim.opt.conceallevel = 2

-- terminal related vim settings
vim.api.nvim_command("autocmd TermOpen * startinsert")
vim.api.nvim_command("autocmd TermOpen * setlocal nonumber")
vim.api.nvim_command("autocmd TermEnter * setlocal signcolumn=no")
