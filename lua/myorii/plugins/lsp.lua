local node_modules
local fixed_node_modules_location = "/.n/lib/node_modules"
local home = os.getenv("HOME")
local os = jit.os

if (os == "Linux" or os == "OSX") then
    node_modules = home .. fixed_node_modules_location
else
    node_modules = "C:\\Users\\work\\AppData\\npm\\node_modules"
end

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

            require("mason").setup({})

            vim.lsp.config('*', { capabilities = capabilities })
            local lsp_configs = {
                lua_ls = {
                    capabilities = capabilities,
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { "vim" },
                                disable = { "missing-fields" }
                            }
                        }
                    },
                    filetypes = { "lua" }
                },
                ts_ls = {
                    init_options = {
                        plugins = {
                            {
                                name = "@vue/typescript-plugin",
                                location = node_modules .. "/@vue/typescript-plugin",
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
                    },
                    settings = {
                        implicitProjectConfiguration = {
                            checkJs = true
                        }
                    }
                },
                vue_ls = {
                    filetypes = { "vue" },
                    init_options = {
                        typescript = {
                            tsdk = node_modules .. "/typescript/lib"
                        }
                    }
                },
                eslint = {
                    settings = {
                        experimental = {
                            useFlatConfig = false
                        }
                    },
                    filetypes = {
                        "javascript",
                        "typescript",
                        "vue",
                        "javascriptreact",
                        "typescriptreact"
                    }
                },
                tailwindcss = {
                    filetypes = {
                        "vue",
                        "html",
                        "javascriptreact",
                        "typescriptreact",
                        "css",
                        "markdown",
                        "mdx"
                    }
                },
                jsonls = {
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
                    },
                    filetypes = {"json", "jsonc"}
                }
            }

            for server_name, config in pairs(lsp_configs) do
                vim.lsp.config(server_name, config)
                vim.lsp.enable(server_name)
            end

            require("mason-lspconfig").setup({
                -- automatic_enable = {
                --     "lua_ls",
                --     "ts_ls",
                --     "volar",
                --     "eslint",
                --     "bashls",
                --     "dockerls",
                --     "docker_compose_language_service",
                --     "cssls",
                --     "tailwindcss"
                -- },
                ensure_installed = {
                    "lua_ls",
                    "ts_ls",
                    "vue_ls",
                    "eslint",
                    "bashls",
                    "dockerls",
                    "docker_compose_language_service",
                    "cssls",
                    "tailwindcss"
                }
            })
        end
    },
    { "folke/lazydev.nvim", ft = "lua", opts = {} }
}
