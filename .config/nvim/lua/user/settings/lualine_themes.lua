local C = require("catppuccin.palettes").get_palette()
local O = require("catppuccin").options
local catppuccin = {}

local transparent_bg = O.transparent_background and "NONE" or C.mantle

local b = { bg = C.mantle, fg = C.text }

catppuccin.normal = {
	a = { bg = C.sky, fg = C.mantle, gui = "bold" },
	b = b,
	c = { bg = transparent_bg, fg = C.text },
}

catppuccin.insert = {
	a = { bg = C.green, fg = C.base, gui = "bold" },
	b = b,
}

catppuccin.terminal = {
	a = { bg = C.green, fg = C.base, gui = "bold" },
	b = b,
}

catppuccin.command = {
	a = { bg = C.peach, fg = C.base, gui = "bold" },
	b = b,
}

catppuccin.visual = {
	a = { bg = C.mauve, fg = C.base, gui = "bold" },
	b = b,
}

catppuccin.replace = {
	a = { bg = C.red, fg = C.base, gui = "bold" },
	b = b,
}

catppuccin.inactive = {
	a = { bg = transparent_bg, fg = C.blue },
	b = { bg = transparent_bg, fg = C.surface1, gui = "bold" },
	c = { bg = transparent_bg, fg = C.overlay0 },
}

return catppuccin
