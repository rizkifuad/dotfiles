vim.g.tokyonight_style = "moon"
vim.g.tokyonight_italic_functions = false
vim.cmd [[
try
  colorscheme tokyonight
  hi NvimTreeVertSplit guifg=#15161E 
  hi WinSeparator guifg=#414868
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
