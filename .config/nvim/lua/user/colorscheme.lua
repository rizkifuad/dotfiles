vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_functions = false
vim.cmd [[
try
  colorscheme duskfox
  hi NvimTreeVertSplit guifg=#15161E 
  hi WinSeparator guifg=#414868
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
