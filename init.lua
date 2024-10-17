require("myorii")

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local myorii_augroup = augroup('myorii', {})

autocmd("LspAttach", {
    group = myorii_augroup,
    callback = function (e)
	local opts = { buffer = e.buf }
	vim.keymap.set("n", "gd", function () vim.lsp.buf.definition() end, opts)
	vim.keymap.set("n", "K", function () vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "<C-h>", function () vim.lsp.buf.signature_help() end, opts)
    end
})
