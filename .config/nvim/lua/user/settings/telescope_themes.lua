local C = require("catppuccin.palettes").get_palette()

vim.api.nvim_set_hl(0, "TelescopeBorder", {  fg = C.surface0, bg = C.crust })
vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = C.crust })
vim.api.nvim_set_hl(0, "TelescopePreviewBorder", {  fg = C.crust, bg = C.crust })
vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = C.crust })
vim.api.nvim_set_hl(0, "TelescopePreviewTitle", {  fg = C.surface0, bg = C.lavender })
vim.api.nvim_set_hl(0, "TelescopePromptBorder", {  fg = C.mantle, bg = C.mantle })
vim.api.nvim_set_hl(0, "TelescopePromptNormal", {  fg = C.overlay1, bg = C.mantle })
vim.api.nvim_set_hl(0, "TelescopePromptPrefix", {  fg = C.surface2, bg = C.mantle })
vim.api.nvim_set_hl(0, "TelescopePromptTitle", {  fg = C.surface0, bg = C.lavender })
vim.api.nvim_set_hl(0, "TelescopeResultsBorder", {  fg = C.crust, bg = C.crust })
vim.api.nvim_set_hl(0, "TelescopeResultsNormal", {  bg = C.crust })
vim.api.nvim_set_hl(0, "TelescopeResultsTitle", {  fg = C.surface0, bg = C.lavender })
