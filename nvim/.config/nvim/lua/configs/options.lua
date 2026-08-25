local options = {
  autoindent = true,
  hidden = true,
  backup = false,                                    -- creates a backup file
  cmdheight = 1,                                     -- more space in the neovim command line for displaying messages
  complete = '.,w,b,kspell',                         -- Use less sources
  -- completeopt = 'menuone,noselect,fuzzy,nosort',    -- Use custom behavior
  completeopt = "menu,menuone,noinsert,fuzzy,popup", -- mostly just for cmp
  conceallevel = 0,                                  -- so that `` is visible in markdown files
  fileencoding = "utf-8",                            -- the encoding written to a file
  hlsearch = false,                                  -- highlight all matches on previous search pattern
  ignorecase = true,                                 -- ignore case in search patterns
  mouse = "a",                                       -- allow the mouse to be used in neovim
  pumheight = 10,                                    -- pop up menu height
  showmode = false,                                  -- we don't need to see things like -- INSERT -- anymore
  showtabline = 2,                                   -- always show tabs
  smartcase = true,                                  -- smart case
  smartindent = true,                                -- make indenting smarter again
  splitbelow = false,                                -- force all horizontal splits to go below current window
  splitright = false,                                -- force all vertical splits to go to the right of current window
  swapfile = false,                                  -- creates a swapfile
  termguicolors = true,                              -- set term gui colors (most terminals support this)
  timeoutlen = 300,                                  -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true,                                   -- enable persistent undo
  updatetime = 100,                                  -- faster completion (4000ms default)
  writebackup = false,                               -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true,                                  -- convert tabs to spaces
  shiftwidth = 2,                                    -- the number of spaces inserted for each indentation
  tabstop = 2,                                       -- insert 2 spaces for a tab
  softtabstop = 2,                                   -- Number of spaces that a <Tab> counts for during editing operations
  cursorline = false,                                -- highlight the current line
  number = true,                                     -- set numbered lines
  relativenumber = true,                             -- set relative numbered lines
  numberwidth = 4,                                   -- set number column width to 2 {default 4}
  -- signcolumn = "yes",                       -- always show the sign column, otherwise it would shift the text each time
  wrap = false,                                      -- display lines as one long line
  scrolloff = 8,                                     -- is one of my fav
  sidescrolloff = 8,
  foldmethod = "expr",
  foldexpr = "v:lua.vim.lsp.foldexpr()",
  foldlevel = 99,
  shada = "'100,<50,s10,:1000,/100,@100,h",
  mousescroll = 'ver:15,hor:6',
  sessionoptions = "buffers,curdir,tabpages,winsize,folds,globals,terminal",
  list = false,
  listchars = {
    tab = '│ ',
    trail = '•',
    nbsp = '␣',
    extends = '⟩',
    precedes = '❮',
  }
}

vim.opt.shortmess:append("c")
vim.opt.rtp:remove("/usr/share/vim/vimfiles")
vim.opt.rtp:remove("/usr/share/vim/vimfiles/after")

for k, v in pairs(options) do
  vim.opt[k] = v
end

--Remap colon as leader key
vim.g.mapleader = ","
vim.g.maplocalleader = ","

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
vim.cmd [[set formatoptions-=cro]] -- TODO: this doesn't seem to work
vim.cmd [[set diffopt+=vertical]]  -- TODO: this doesn't seem to work


-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])
vim.cmd [[
hi DiagnosticUnderlineError guisp='Red' gui=undercurl
hi DiagnosticUnderlineWarn guisp='Cyan' gui=undercurl
set termguicolors
let g:loaded_fzf = 0
]]

local disabled_built_ins = {
  --[[ "netrw", ]]
  --[[ "netrwPlugin", ]]
  --[[ "netrwSettings", ]]
  --[[ "netrwFileHandlers", ]]
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
  "matchit",
  "treesitter",
  -- "fzf"
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g["loaded_" .. plugin] = 1
end

vim.cmd([[
  " Source local configuration if exist
  if filereadable('.local.nvim')
    so .local.nvim
  endif

function! CopyMatches(reg)
  let hits = []
  %s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/gne
  let reg = empty(a:reg) ? '+' : a:reg
  execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction
command! -register CopyMatches call CopyMatches(<q-reg>)
]])

vim.g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
    ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
  },
  paste = {
    ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
    ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
  },
}
