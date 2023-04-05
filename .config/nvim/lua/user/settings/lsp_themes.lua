local C = require("catppuccin.palettes").get_palette()

vim.api.nvim_set_hl(0, "DiagnosticFloatingError", { bg = C.base, fg = C.red })
vim.api.nvim_set_hl(0, "DiagnosticFloatingInfo", { bg = C.base, fg = C.blue })
vim.api.nvim_set_hl(0, "DiagnosticFloatingWarn", { bg = C.base, fg = C.pitch })
vim.api.nvim_set_hl(0, "DiagnosticFloatingHint", { bg = C.base, fg = C.teal })
