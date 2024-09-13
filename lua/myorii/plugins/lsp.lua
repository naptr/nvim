return {
    {
	"neovim/nvim-lspconfig",
	dependencies = {
	    "williamboman/mason.nvim",
	    "williamboman/mason-lspconfig.nvim",
	    "hrsh7th/cmp-nvim-lsp"
	},
	config = function ()
	    local cmp_lsp = require("cmp_nvim_lsp")
	    local capabilities = vim.tbl_deep_extend(
		"force",
		{},
		vim.lsp.protocol.make_client_capabilities(),
		cmp_lsp.default_capabilities()
	    )
	    capabilities.textDocument.completion.completionItem.snippetSupport = true

	    require("mason").setup({})
	    require("mason-lspconfig").setup({
		ensure_installed = {
		    "lua_ls",
		    "ts_ls",
		    "volar",
		    "eslint",
		    "bashls",
		    "dockerls",
		    "docker_compose_language_service",
		    "cssls",
		    "tailwindcss"
		},
		handlers = {
		    function (server_name) -- default handler (optional)
			require("lspconfig")[server_name].setup({
			    capabilities = capabilities
			})
		    end,
		    ["lua_ls"] = function()
			require("lspconfig").lua_ls.setup({
			    capabilities = capabilities,
			    settings = {
				Lua = {
				    diagnostics = { globals = { "vim" } }
				}
			    }
			})
		    end,
		    ["ts_ls"] = function ()
			require("lspconfig").ts_ls.setup({
			    capabilities = capabilities,
			    init_options = {
				plugins = {
				    {
					name = "@vue/typescript-plugin",
					location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
					languages = { "vue" }
				    }
				}
			    },
			    filetypes = {
				"javascript",
				"typescript",
				"vue",
				"javascriptreact",
				"typescriptreact"
			    }
			})
		    end,
		    ["eslint"] = function ()
			require("lspconfig").eslint.setup({
			    filetypes = {
				"javascript",
				"typescript",
				"vue",
				"javascriptreact",
				"typescriptreact"
			    }
			})
		    end,
		    ["volar"] = function ()
			require("lspconfig").volar.setup({
			    capabilities = capabilities,
			    filetypes = { "vue" },
			    init_options = {
				typescript = {
				    tsdk = "/usr/local/lib/node_modules/typescript/lib"
				}
			    }
			})
		    end,
		    ["tailwindcss"] = function ()
		    	require("lspconfig").tailwindcss.setup({
			    filetypes = {
				"vue",
				"html",
				"javascriptreact",
				"typescriptreact",
				"css",
				"markdown",
				"mdx"
			    }
			})
		    end,
		    ["jsonls"] = function ()
			require("lspconfig").jsonls.setup({
			    capabilities = capabilities,
			    settings = {
				json = {
				    schemas = require("schemastore").json.schemas({
					select = {
					    "package.json",
					    "jsconfig.json"
					}
				    }),
				    validate = { enabled = true }
				}
			    }
			})
		    end
		}
	    })
	end
    }
}
