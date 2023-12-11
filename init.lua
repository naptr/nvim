-- Essentials
vim.g.mapleader = ","
vim.opt.termguicolors = true

-- Disable providers for faster startup
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("naptr.plugins", {
    change_detection = {
        -- automatically check for config file changes and reload the ui
        enabled = true,
        notify = false
    }
})

-- Keymaps
require("naptr.keymaps")

-- Opts
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.showmatch = true
vim.opt.showmode = false

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.scrolloff = 8

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.o.shortmess = vim.o.shortmess:gsub("S", "")

vim.opt.swapfile = false
vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.nvim/undodir"

-- api
vim.api.nvim_create_autocmd("TermOpen", {
    command = [[ setlocal nonumber norelativenumber ]]
})

-- colorscheme
vim.opt.background = 'dark'
vim.cmd.colorscheme('gruvbox-material')
-- -- gruvbox
vim.g.gruvbox_material_background = 'medium'
vim.g.gruvbox_material_foreground = 'material'
vim.g.gruvbox_material_better_performance = 1
vim.g.gruvbox_material_enable_italic = 1
vim.g.gruvbox_material_show_eob = 0
vim.g.gruvbox_material_transparent_background = 2

vim.g.netrw_banner = 0

-- plugins
vim.g.skip_ts_context_commentstring_module = true
