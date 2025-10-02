local cmp_kinds = {
    Text = '  ',
    Method = '  ',
    Function = '  ',
    Constructor = '  ',
    Field = '  ',
    Variable = '  ',
    Class = '  ',
    Interface = '  ',
    Module = '  ',
    Property = '  ',
    Unit = '  ',
    Value = '  ',
    Enum = '  ',
    Keyword = '  ',
    Snippet = '  ',
    Color = '  ',
    File = '  ',
    Reference = '  ',
    Folder = '  ',
    EnumMember = '  ',
    Constant = '  ',
    Struct = '  ',
    Event = '  ',
    Operator = '  ',
    TypeParameter = '  ',
}

return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline"
        },
        config = function ()
            local cmp = require("cmp")
            local cmp_select = { behavior = cmp.SelectBehavior.Select }

            cmp.setup({
                preselect = cmp.PreselectMode.None,
                completion = {
                    completeopt = "menu,menuone,noselect"
                },
                experimental = { ghost_text = true },
                snippet = {
                    expand = function (args)
                        local luasnip = require("luasnip")
                        luasnip.lsp_expand(args.body) -- For `luasnip` user
                    end
                },
                performance = {
                    max_view_entries = 50
                },
                matching = {
                    disallow_fuzzy_matching = false,
                    disallow_fullyfuzzy_matching = false,
                    disallow_partial_fuzzy_matching = false
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
                    {
                        name = "nvim_lsp",
                        entry_filter = function (entry, _)
                            return require("cmp.types").lsp.CompletionItemKind[entry:get_kind()] ~= 'Text'
                        end
                    },
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
                },
                formatting = {
                    format = function (entry, vim_item)
                        vim_item.kind = string.format(
                            "%s %s",
                            (cmp_kinds[vim_item.kind] or ""),
                            vim_item.kind
                        )
                        vim_item.menu = ({
                            buffer = "[Buffer]",
                            nvim_lsp = "[LSP]",
                            luasnip = "[LuaSnip]",
                            nvim_lua = "[Lua]",
                            latex_symbols = "[LaTeX]",
                        })[entry.source.name]
                        return vim_item
                    end
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
        end,
        opts = function (_, opts)
            opts.sources = opts.sources or {}
            table.insert(opts.sources, {
                name = "lazydev",
                group_index = 0
            })
        end
    },
    {
        "davidosomething/format-ts-errors.nvim",
        config = function()
            require("format-ts-errors").setup({
                add_markdown = true, -- wrap output with markdown ```ts ``` markers
                start_indent_level = 0, -- initial indent
            })
        end,
    }
}
