local vi_mode_colors = {
    NORMAL = "green",
    OP = "green",
    INSERT = "yellow",
    VISUAL = "mauve",
    LINES = "peach",
    BLOCK = "flamingo",
    REPLACE = "red",
    COMMAND = "teal"
}

local comps = {
    vim = {
        mode = {
            provider = {
                name = "vi_mode",
                opts = {
                    show_mode_name = true,
                    -- padding = true -- Uncomment for extra padding
                }
            },
            hl = function ()
                return {
                    fg = require("feline.providers.vi_mode").get_mode_color(),
                    bg = "overlay0",
                    style = "bold",
                    name = "NeovimModeHLColor"
                }
            end,
            left_sep = "block",
            right_sep = "block"
        },
    },
    git = {
        branch = {
            provider = "git_branch",
            icon = " ",
            hl = {
                fg = "maroon",
                bg = "overlay0",
                style = "bold"
            },
            left_sep = "block",
            right_sep = "block"
        },
        add = {
            provider = "git_diff_added",
            hl = {
                fg = "green",
                bg = "overlay0"
            },
            left_sep = "block",
            right_sep = "block"
        },
        remove = {
            provider = "git_diff_removed",
            hl = {
                fg = "red",
                bg = "overlay0"
            },
            left_sep = "block",
            right_sep = "block"
        },
        change = {
            provider = "git_diff_changed",
            hl = {
                fg = "fg",
                bg = "overlay0"
            },
            left_sep = "block",
            right_sep = "right_rounded"
        }
    },
    separator = {
        provider = ""
    },
    fileinfo = {
        provider = {
            name = "file_info",
            opts = {
                type = "relative-short"
            }
        },
        hl = {
            style = "NONE"
        },
        left_sep = " ",
        right_sep = " "
    },
    diagnostics = {
        errors = {
            provider = "diagnostic_errors",
            hl = {
                fg = "red"
            }
        },
        warnings = {
            provider = "diagnostic_warnings",
            hl = {
                fg = "yellow"
            }
        },
        hints = {
            provider = "diagnostic_hints",
            hl = {
                fg = "teal"
            }
        },
        info = {
            provider = "diagnostic_info"
        }
    },
    lsp = {
        client_names = {
            provider = "lsp_client_names",
            hl = {
                fg = "mauve",
                bg = "overlay0",
                style = "bold"
            },
            left_sep = "block",
            right_sep = "block"
        }
    },
    file = {
        type = {
            provider = {
                name = "file_type",
                opts = {
                    filetype_icon = true,
                    case = "titlecase"
                }
            },
            hl = {
                fg = "fg",
                bg = "overlay0",
                style = "bold"
            },
            left_sep = "block",
            right_sep = "block"
        },
        encoding = {
            provider = "file_encoding",
            hl = {
                fg = "peach",
                bg = "overlay0",
                style = "italic"
            },
            left_sep = "block",
            right_sep = "block"
        }
    },
    position = {
        provider = "position",
        hl = {
            fg = "green",
            bg = "overlay0",
            style = "bold"
        },
        left_sep = "block",
        right_sep = "block"
    },
    line_percentage = {
        provider = "line_percentage",
        hl = {
            fg = "teal",
            bg = "overlay0",
            style = "bold"
        },
        left_sep = "block",
        right_sep = "block"
    },
    scroll_bar = {
        provider = "scroll_bar",
        hl = {
            fg = "flamingo",
            style = "NONE"
        }
    }
}

local left = {
    active = {
        comps.vim.mode,
        comps.git.branch,
        comps.git.add,
        comps.git.remove,
        comps.git.change,
        comps.separator
    },
    inactive = {
        comps.fileinfo
    }
}

local middle = {
    active = {
        comps.fileinfo,
        comps.diagnostics.errors,
        comps.diagnostics.warnings,
        comps.diagnostics.info,
        comps.diagnostics.hints
    },
    inactive = {
    }
}

local right = {
    active = {
        comps.lsp.client_names,
        comps.file.type,
        comps.file.encoding,
        comps.position,
        comps.line_percentage,
        comps.scroll_bar
    },
    inactive = {
        comps.file.type
    }
}

local components = {
    active = {
        left.active,
        middle.active,
        right.active
    },
    inactive = {
        left.inactive,
        middle.inactive,
        right.inactive
    }
}

local properties = {
    force_inactive = {
        filetypes = {
            "Telescope",
            "fugitive",
            "fugitiveblame"
        },
        buftype = {"terminal"}
    }
}

require("feline").setup({
    components = components,
    theme = require("naptr.statusline.colors").medium,
    properties = properties,
    vi_mode_colors = vi_mode_colors
})
