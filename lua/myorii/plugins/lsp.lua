return {
    {
	"neovim/nvim-lspconfig",
	dependencies = {
	    "williamboman/mason.nvim",
	    "williamboman/mason-lspconfig.nvim",
	    "hrsh7th/cmp-nvim-lsp",
	    "hrsh7th/cmp-buffer",
	    "hrsh7th/cmp-path",
	    "hrsh7th/cmp-cmdline",
	    "hrsh7th/nvim-cmp",
	    "hrsh7th/cmp-nvim-lsp-signature-help",
	    "L3MON4D3/LuaSnip",
	    "saadparwaiz1/cmp_luasnip",
	},
	config = function ()
	    local cmp = require("cmp")
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

	    local cmp_select = { behavior = cmp.SelectBehavior.Select }
	    cmp.setup({
		experimental = { ghost_text = true },
		snippet = {
		    expand = function (args)
			local luasnip = require("luasnip")
			luasnip.lsp_expand(args.body) -- For `luasnip` user
		    end
		},
		mapping = cmp.mapping.preset.insert({
		    ["<Up>"] = cmp.mapping.select_prev_item(cmp_select),
		    ["<Down>"] = cmp.mapping.select_next_item(cmp_select),
		    ["<Tab>"] = cmp.mapping(function (fallback)
			-- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
			if cmp.visible() then
			    local entry = cmp.get_selected_entry()
			    if not entry then
				cmp.select_next_item(cmp_select)
			    end
			    cmp.confirm()
			else
			    fallback()
			end
		    end, { "i", "s", "c" }),
		    ["<C-Space>"] = cmp.mapping.complete()
		}),
		sources = cmp.config.sources({
		    { name = "nvim_lsp" },
		    { name = "luasnip" },
		    { name = "nvim_lsp_signature_help" }
		}, {
		    { name = "buffer" },
		    { name = "path" }
		}),
		view = {
		    entries = {
			name = "custom",
			selection_order = "near_cursor"
		    }
		}
	    })

	    cmp.setup.cmdline({ "/", "?" }, {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
		    { name = "buffer" }
		}
	    })

	    cmp.setup.cmdline({ ":" }, {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
		    { name = "path" }
		}, {
		    {
			name = "cmdline",
			option = {
			    ignore_cmds = { "Man", "!" }
			}
		    }
		})
	    })
	end
    }
}
