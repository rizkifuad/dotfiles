require('vim._core.ui2').enable({})

require('configs.autocmds')
require('configs.cmds')
require('configs.options')
require('configs.keymaps')
require('configs.tabline')

-- Plugins for treesitter and lsp server management (Mason)
local gh = function(x) return 'https://github.com/' .. x end


vim.pack.add({
  { src = gh('catppuccin/nvim') },
})

require("catppuccin").setup({ styles = { diagnostics = { "undercurl" } } })
vim.cmd('colorscheme catppuccin-macchiato')

vim.pack.add({
  { src = gh('mason-org/mason.nvim') },
  { src = gh('mason-org/mason-lspconfig.nvim') },
  { src = gh('nvim-treesitter/nvim-treesitter'), version = 'main' },
  { src = gh('nvim-treesitter/nvim-treesitter-textobjects'), version = 'main' },
})
require('configs/lsp')

-- Treesitter
require('nvim-treesitter.config').setup({
  install_dir = vim.fn.stdpath('data') .. '/site',
})

vim.pack.add({
  { src = gh('windwp/nvim-autopairs') }
})
require("configs/autopairs")



-- Fugitive
vim.pack.add({
  {
    src = gh('tpope/vim-fugitive'),
  } })

vim.pack.add({
  {
    src = gh('folke/flash.nvim'),
  } })
require('configs/flash')
require('configs/commander')

-- Small selection of mini plugins
vim.pack.add({
  {
    src = gh('nvim-mini/mini.nvim'),
    version = 'main',
  } })


require('mini.icons').setup()
require('mini.completion').setup()

local misc = require('mini.misc')
local later = function(f) misc.safely('later', f) end
later(function() require('mini.cmdline').setup() end)
later(function() require('mini.extra').setup() end)
require('mini.git').setup()
later(function() require('mini.indentscope').setup() end)
later(function()
  require('mini.diff').setup({
    mappings = { apply = '' },
    view = {
      style = "sign",
      signs = {
        add = '▎', change = '▎', delete = ' '
      }
    }
  })
end)
later(function() require('configs.mini-pick') end)
later(function() require('configs.mini-clue') end)

later(function() vim.opt.clipboard = "unnamedplus" end)
later(MiniIcons.tweak_lsp_kind)

require('configs.mini-files')
require('configs.mini-statusline')


vim.pack.add({
  { src = gh('NvChad/nvim-colorizer.lua') },
})

later(function()
  require 'colorizer'.setup {
    'css',
    'javascript',
    html = {
      mode = 'foreground',
    }
  }
end)
