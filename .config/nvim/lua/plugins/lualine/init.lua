local components = require "plugins.lualine.components"
local M = {}
function M.setup()
    require('lualine').setup{
        style = "lvim",
        options = {
            theme = 'auto',
            icons_enabled = true,
            component_separators = "",
            section_separators = "",
            disabled_filetypes = { "dashboard", "NvimTree", "Outline" },
        },
        sections = {
            lualine_a = {
                components.mode,
            },
            lualine_b = {
                components.branch,
                components.filename,
            },
            lualine_c = {
                components.diff,
                components.python_env,
            },
            lualine_x = {
                components.diagnostics,
                components.treesitter,
                components.lsp,
                components.filetype,
            },
            lualine_y = {},
            lualine_z = {
                components.scrollbar,
            },
        },
        inactive_sections = {
            lualine_a = {
                "filename",
            },
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {},
        },
        tabline = {},
        extensions = { "nvim-tree" },
    }
end

return M
