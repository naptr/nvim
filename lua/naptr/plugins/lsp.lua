return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        lazy = true,
        config = false,
        init = function ()
            vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0
        end
    },
    {
        "williamboman/mason.nvim",
        lazy = true,
        config = true
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "folke/neodev.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function ()
            local lsp_config = require("lspconfig")
            local lsp_zero = require("lsp-zero")
            lsp_zero.extend_lspconfig()

            lsp_zero.on_attach(function (_, bufnr)
                lsp_zero.default_keymaps({ buffer = bufnr })
            end)

            local capabilities = require("cmp_nvim_lsp").default_capabilities(
                vim.lsp.protocol.make_client_capabilities()
            )
            capabilities.textDocument.completion.completionItem.snippetSupport = true

            require("mason-lspconfig").setup({
                handlers = {
                    lsp_zero.default_setup,
                    lua_ls = function ()
                        lsp_config.lua_ls.setup(lsp_zero.nvim_lua_ls())
                    end,
                    jsonls = function ()
                        lsp_config.jsonls.setup({
                            capabilities = capabilities,
                            settings = {
                                json = {
                                    schemas = {
                                        {
                                            fileMatch = { "package.json" },
                                            url = "https://json.schemastore.org/package.json"
                                        },
                                        {
                                            fileMatch = { "docker-compose.yml" },
                                            url = "https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"
                                        }
                                    }
                                }
                            }
                        })
                    end
                },
                ensure_installed = {
                    "bashls", "clangd", "cmake", "cssls", "html", "jsonls",
                    "dockerls", "docker_compose_language_service", "eslint",
                    "emmet_language_server", "gopls", "tsserver", "lua_ls",
                    "marksman", "rust_analyzer", "tailwindcss", "volar", "yamlls"
                }
            })
        end,
        ft = {
            "javascript", "typescript", "vue", "html", "typescriptreact", "lua","rust",
            "zig", "css", "scss", "vimdoc", "cpp", "yuck", "bash",
            "yaml", "dockerfile", "go", "json"
        }
    }
}
