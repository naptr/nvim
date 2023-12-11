local opts = { noremap = true }

-- Fast saving
vim.keymap.set("n", "<C-s>", ":w!<CR>", opts)
vim.keymap.set("n", "<leader>q", ":q!<CR>", opts)

-- Better split switching
vim.keymap.set("", "<C-j>", "<C-W>j", opts)
vim.keymap.set("", "<C-k>", "<C-W>k", opts)
vim.keymap.set("", "<C-h>", "<C-W>h", opts)
vim.keymap.set("", "<C-l>", "<C-W>l", opts)

-- Tab
-- vim.keymap.set('n', '<S-t>', ':tabnew<CR>')
-- vim.keymap.set("n", "<S-l>", 'gt', opts)
-- vim.keymap.set("n", "<S-h>", 'gT', opts)

-- Terminal
vim.keymap.set('n', '<leader>t', ':terminal<CR>')

-- vim.keymap.set("", "<C-S>Tab", "gT")
-- vim.keymap.set("", "<C-Tab>", "gt")
-- vim.keymap.set("n", "<Tab>", ":lua print('test')<CR>")

vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts)

-- Telescope 

-- Undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, opts)

-- Fugitive
vim.keymap.set("n", "<leader>gs", vim.cmd.Git, opts)

-- Codi
vim.keymap.set('n', '<leader>ce', vim.cmd.CodiExpand, opts)
