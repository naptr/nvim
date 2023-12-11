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
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-buffer",
        "saadparwaiz1/cmp_luasnip",
        "L3MON4D3/LuaSnip"
    },
    config = function ()
        local lsp_zero = require("lsp-zero")
        lsp_zero.extend_cmp()

        local cmp = require("cmp")

        cmp.setup({
            performance = {
                max_view_entries = 50
            },
            matching = {
                disallow_fuzzy_matching = false,
                disallow_fullfuzzy_matching = false,
                disallow_partial_fuzzy_matching = false
            },
            sorting = {
                comparators = {
                    cmp.config.compare.offset,
                    cmp.config.compare.exact,
                    cmp.config.compare.score,
                    cmp.config.compare.recently_used,
                    cmp.config.compare.kind,
                    cmp.config.compare.sort_text
                }
            },
            -- sources = {
            --  { name = "nvim-lsp" },
            --  { name = "path" },
            --  { name = "buffer", keyword_length = 3 },
            --  { name = "luasnip" }
            -- },
            sources = {
                { name = "path" },
                { name = "buffer", keyword_length = 3 },
                { name = "luasnip" },
                {
                    name = "nvim_lsp",
                    entry_filter = function(entry, _)
                        return require('cmp.types').lsp.CompletionItemKind[entry:get_kind()] ~= 'Text'
                    end
                }
            },
            mapping = {
                ["<Tab>"] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-u>"] = cmp.mapping.scroll_docs(-2),
                ["<C-d>"] = cmp.mapping.scroll_docs(2)
            },
            formatting = {
                format = function (_, vim_item)
                    vim_item.kind = (cmp_kinds[vim_item.kind] or "") .. vim_item.kind
                    return vim_item
                end
            },
            experimental = {
                ghost_text = true
            },
            entry_filter = function ()
            end
        })
    end
}
