local utils = require("heirline.utils")
local conditions = require("heirline.conditions")

local VimMode = {
    init = function(self)
        self.mode = vim.fn.mode(1)
    end,
    provider = function(self)
        return "%( " .. self.mode_names[self.mode] .."%) "
    end,
    hl = function(self)
        local fg = utils.get_highlight(self.mode_colors[self.mode]).fg
        local bg = utils.get_highlight("StatusLine").bg
        return { fg = bg, bg = fg, bold = true }
    end,
    update = {
        "ModeChanged",
        pattern = "*:*",
        callback = vim.schedule_wrap(function()
            vim.cmd("redrawstatus")
        end)
    }
}

local FileNameBlock = {
    init = function(self)
        self.filename = vim.api.nvim_buf_get_name(0)
    end
}

local FileFlags = {
    {
        condition = function()
            return vim.bo.modified
        end,
        provider = " [+]",
        hl = function()
            local fg = utils.get_highlight("GreenSign").fg
            return { fg = fg }
        end
    },
    {
        condition = function()
            return not vim.bo.modifiable or vim.bo.readonly
        end,
        provider = " ",
        hl = function()
            local fg = utils.get_highlight("YellowSign").fg
            return { fg = fg }
        end
    },

}

local FileName = {
    provider = function(self)
        local filename = vim.fn.fnamemodify(self.filename, ":.")
        if filename == "" then return " [No Name] " end
        if not conditions.width_percent_below(#filename, 0.25) then
            filename = vim.fn.pathshorten(filename)
        end
        return " " .. filename
    end
}

FileNameBlock = utils.insert(FileNameBlock,
    FileName,
    FileFlags,
    { provider = "%<" }
)

local Git = {
    condition = conditions.is_git_repo,
    init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict
        self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
    end,
    { -- git branch name
        provider = function(self)
            local icon = ""
            return icon .. " " .. self.status_dict.head .. " "
        end,
        hl = { bold = true }
    },
    {
        condition = function(self)
            return self.status_dict.added ~= nil and self.status_dict.added > 0
        end,
        {
            provider = function(self)
                return "+" .. self.status_dict.added
            end,
            hl = function()
                local fg = utils.get_highlight("GitSignsAdd").fg
                return { fg = fg }
            end
        }
    },
    {
        condition = function(self)
            return self.status_dict.changed ~= nil and self.status_dict.changed > 0
        end,
        {
            condition = function(self)
                return self.status_dict.added > 0
            end,
            provider = " "
        },
        {
            provider = function(self)
                return "~" .. self.status_dict.changed
            end,
            hl = function()
                local fg = utils.get_highlight("GitSignsChange").fg
                return { fg = fg }
            end
        },
    },
    {
        condition = function(self)
            return self.status_dict.removed ~= nil and self.status_dict.removed > 0
        end,
        {
            condition = function(self)
                return self.status_dict.added > 0 or self.status_dict.changed > 0
            end,
            provider = " "
        },
        {
            provider = function(self)
                return "-" .. self.status_dict.removed
            end,
            hl = function()
                local fg = utils.get_highlight("GitSignsDelete").fg
                return { fg = fg }
            end
        },
    }
}

local Diagnostics = {
    condition = conditions.has_diagnostics,
    static = {
        icon = "●",
    },
    init = function(self)
        self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
        self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
    end,
    update = { "DiagnosticChanged", "BufEnter" },
    {
        condition = function(self)
            return self.errors > 0
        end,
        {
            provider = function(self)
                return self.icon
            end,
            hl = function()
                local fg = utils.get_highlight("RedSign").fg
                return { fg = fg }
            end
        },
        {
            provider = function(self)
                return " " .. self.errors
            end
        }
    },
    {
        condition = function(self)
            return self.warnings > 0
        end,
        {
            condition = function(self)
                return self.errors > 0
            end,
            provider = " "
        },
        {
            provider = function(self)
                return self.icon
            end,
            hl = function()
                local fg = utils.get_highlight("YellowSign").fg
                return { fg = fg }
            end
        },
        {
            provider = function(self)
                return " " .. self.warnings
            end
        }
    },
    {
        condition = function(self)
            return self.info > 0
        end,
        {
            condition = function(self)
                return self.errors > 0 or self.warnings > 0
            end,
            provider = " "
        },
        {
            provider = function(self)
                return self.icon
            end,
            hl = function()
                local fg = utils.get_highlight("BlueSign").fg
                return { fg = fg }
            end
        },
        {
            provider = function(self)
                return " " .. self.info
            end
        }
    },
    {
        condition = function(self)
            return self.hints > 0
        end,
        {
            condition = function(self)
                return self.errors > 0 or self.warnings > 0 or self.info > 0
            end,
            provider = " "
        },
        {
            provider = function(self)
                return self.icon
            end,
            hl = function()
                local fg = utils.get_highlight("GreenSign").fg
                return { fg = fg }
            end
        },
        {
            provider = function(self)
                return " " .. self.hints
            end
        }

    }
}

local Ruler = {
    provider = function()
        if vim.bo.filetype ~= "netrw" then
            return "%(%l%):%c"
        end
    end
}

local Left = {
    VimMode,
    FileNameBlock
}

local Right = {
    { provider = "%=" },
    Diagnostics,
    { provider = "  "},
    Ruler,
    { provider = "  "},
    Git,
    { provider = "  "},
    {
        init = function(self)
            self.mode = vim.fn.mode(1)
        end,
        provider = "█",
        hl = function(self)
            local fg = utils.get_highlight(self.mode_colors[self.mode]).fg
            return { fg = fg }
        end,
        update = {
            "ModeChanged",
            pattern = "*:*",
            callback = vim.schedule_wrap(function()
                vim.cmd("redrawstatus")
            end)
        }
    }
}

require("heirline").setup({
    statusline = {
        static = {
            mode_names = {
                n = "N",
                no = "N?",
                nov = "N?",
                noV = "N?",
                ["no\22"] = "N?",
                niI = "Ni",
                niR = "Nr",
                niV = "Nv",
                nt = "Nt",
                v = "V",
                vs = "Vs",
                V = "V_",
                Vs = "Vs",
                ["\22"] = "^V",
                ["\22s"] = "^V",
                s = "S",
                S = "S_",
                ["\19"] = "^S",
                i = "I",
                ic = "Ic",
                ix = "Ix",
                R = "R",
                Rc = "Rc",
                Rx = "Rx",
                Rv = "Rv",
                Rvc = "Rv",
                Rvx = "Rv",
                c = "C",
                cv = "Ex",
                r = "...",
                rm = "M",
                ["r?"] = "?",
                ["!"] = "!",
                t = "T",
            },
            -- left_sep = "",
            mode_colors = {
                n = "Normal",
                i = "Green",
                v = "Blue",
                V =  "Blue",
                ["\22"] =  "Blue",
                c =  "Orange",
                s =  "Purple",
                S =  "Purple",
                ["\19"] =  "Purple",
                R =  "Orange",
                r =  "Orange",
                ["!"] =  "Red",
                t =  "Red",
            },
        },
        Left,
        Right,
        hl = function()
            local bg = utils.get_highlight("StatusLine").bg
            return { bg = bg }
        end
    },
})
