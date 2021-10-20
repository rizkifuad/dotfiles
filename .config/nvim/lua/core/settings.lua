local set = vim.opt

set.mouse = "a"
set.expandtab = true
-- set.smarttab = true
set.smartindent = true
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4
set.shiftround = true
set.showtabline = 2
set.clipboard = "unnamedplus"
set.list = true
-- set.listchars="eol:↲,tab:↦\ ,nbsp:␣,extends:…,trail:⋅"
set.swapfile = false
set.number = true
set.relativenumber = true
set.backup = false
set.writebackup = false
set.wrap = false
set.undodir = vim.fn.stdpath "cache" .. "/undo"
set.undofile = true
set.updatetime = 300
set.timeoutlen = 300
set.termguicolors = true
set.scrolloff = 8
set.sidescrolloff = 8
set.signcolumn = "yes"
set.ignorecase = true
set.smartcase = true
-- set.fillchars = "ver:\|"
set.hidden = true
set.history = 100
set.lazyredraw = true
set.synmaxcol = 240
set.hlsearch = false
set.completeopt = { "menuone", "noselect" }

local disabled_built_ins = {
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logipat",
    "rrhelper",
    "spellfile_plugin",
    "matchit"
}

for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end
