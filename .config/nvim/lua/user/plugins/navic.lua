local navic = require("nvim-navic")






local icons = {
  File          = " ",
  Module        = " ",
  Namespace     = " ",
  Package       = " ",
  Class         = " ",
  Method        = " ",
  Property      = " ",
  Field         = " ",
  Constructor   = " ",
  Enum          = "練",
  Interface     = "練",
  Function      = " ",
  Variable      = " ",
  Constant      = " ",
  String        = " ",
  Number        = " ",
  Boolean       = "◩ ",
  Array         = " ",
  Object        = " ",
  Key           = " ",
  Null          = "ﳠ ",
  EnumMember    = " ",
  Struct        = " ",
  Event         = " ",
  Operator      = " ",
  TypeParameter = " ",
}

navic.setup {
  icons = icons,
  highlight = true,
  separator = " > ",
  depth_limit = 0,
  depth_limit_indicator = "..",
}


if vim.g.colors_name == "catppuccin" then
  local C = require("catppuccin.palettes").get_palette()
  vim.api.nvim_set_hl(0, "NavicIconsFile", { default = true, bg = C.mantle, fg = "#cdcbe0" })
  vim.api.nvim_set_hl(0, "NavicIconsModule", { default = true, bg = C.mantle, fg = "#a6dae3" })
  vim.api.nvim_set_hl(0, "NavicIconsNamespace", { default = true, bg = C.mantle, fg = "#a6dae3" })
  vim.api.nvim_set_hl(0, "NavicIconsPackage", { default = true, bg = C.mantle, fg = "#a6dae3" })
  vim.api.nvim_set_hl(0, "NavicIconsClass", { default = true, bg = C.mantle, fg = "#f6c177" })
  vim.api.nvim_set_hl(0, "NavicIconsMethod", { default = true, bg = C.mantle, fg = "#65b1cd" })
  vim.api.nvim_set_hl(0, "NavicIconsProperty", { default = true, bg = C.mantle, fg = "#569fba" })
  vim.api.nvim_set_hl(0, "NavicIconsField", { default = true, bg = C.mantle, fg = "#569fba" })
  vim.api.nvim_set_hl(0, "NavicIconsConstructor", { default = true, bg = C.mantle, fg = "#cdcbe0" })
  vim.api.nvim_set_hl(0, "NavicIconsEnum", { default = true, bg = C.mantle, fg = "#c4a7e7" })
  vim.api.nvim_set_hl(0, "NavicIconsInterface", { default = true, bg = C.mantle, fg = "#c4a7e7" })
  vim.api.nvim_set_hl(0, "NavicIconsFunction", { default = true, bg = C.mantle, fg = "#c4a7e7" })
  vim.api.nvim_set_hl(0, "NavicIconsVariable", { default = true, bg = C.mantle, fg = "#c4a7e7" })
  vim.api.nvim_set_hl(0, "NavicIconsConstant", { default = true, bg = C.mantle, fg = "#c4a7e7" })
  vim.api.nvim_set_hl(0, "NavicIconsString", { default = true, bg = C.mantle, fg = "#c4a7e7" })
  vim.api.nvim_set_hl(0, "NavicIconsNumber", { default = true, bg = C.mantle, fg = "#c4a7e7" })
  vim.api.nvim_set_hl(0, "NavicIconsBoolean", { default = true, bg = C.mantle, fg = "#c4a7e7" })
  vim.api.nvim_set_hl(0, "NavicIconsArray", { default = true, bg = C.mantle, fg = "#c4a7e7" })
  vim.api.nvim_set_hl(0, "NavicIconsObject", { default = true, bg = C.mantle, fg = "#c4a7e7" })
  vim.api.nvim_set_hl(0, "NavicIconsKey", { default = true, bg = C.mantle, fg = "#c4a7e7" })
  vim.api.nvim_set_hl(0, "NavicIconsNull", { default = true, bg = C.mantle, fg = "#c4a7e7" })
  vim.api.nvim_set_hl(0, "NavicIconsEnumMember", { default = true, bg = C.mantle, fg = "#569fba" })
  vim.api.nvim_set_hl(0, "NavicIconsStruct", { default = true, bg = C.mantle, fg = "#569fba" })
  vim.api.nvim_set_hl(0, "NavicIconsEvent", { default = true, bg = C.mantle, fg = "#569fba" })
  vim.api.nvim_set_hl(0, "NavicIconsOperator", { default = true, bg = C.mantle, fg = "#569fba" })
  vim.api.nvim_set_hl(0, "NavicIconsTypeParameter", { default = true, bg = C.mantle, fg = "#569fba" })
  vim.api.nvim_set_hl(0, "NavicText", { default = true, bg = C.mantle, fg = "#cdcbe0" })
  vim.api.nvim_set_hl(0, "NavicSeparator", { default = true, bg = C.mantle, fg = "#cdcbe0" })
end
