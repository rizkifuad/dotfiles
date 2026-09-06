require('vim._core.ui2').enable({})

require('configs.options')
require('configs.tabline')

-- Plugins for treesitter and lsp server management (Mason)
local gh = function(x) return 'https://github.com/' .. x end


vim.pack.add({
  { src = gh('catppuccin/nvim') },
})

require("catppuccin").setup({ styles = { diagnostics = { "undercurl" } } })
vim.cmd('colorscheme catppuccin-mocha')

vim.pack.add({
  { src = gh('mason-org/mason.nvim') },
  { src = gh('mason-org/mason-lspconfig.nvim') },
  { src = gh('nvim-treesitter/nvim-treesitter'),             version = 'main' },
  { src = gh('nvim-treesitter/nvim-treesitter-textobjects'), version = 'main' },
})
require('configs/lsp')
require('configs/treesitter')

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
require('mini.sessions').setup()
require('mini.notify').setup()
require('mini.git').setup()
require('mini.surround').setup()

local misc = require('mini.misc')
local later = function(f) misc.safely('later', f) end
later(function()
  require('mini.cmdline').setup()
  require('mini.extra').setup()
  require('mini.indentscope').setup()
  require('mini.diff').setup({
    mappings = { apply = '' },
    view = {
      style = "sign",
      signs = {
        add = '▎', change = '▎', delete = ' '
      }
    }
  })
  require('configs.mini-pick')
  require('configs.mini-clue')
  require('configs.snippets')
  vim.opt.clipboard = "unnamedplus"
  MiniIcons.tweak_lsp_kind()
end)


vim.pack.add({ gh('stevearc/conform.nvim') })
require('conform').setup({
  formatters_by_ft = {
    blade = { "blade-formatter" },
    vue = { "prettierd" },
  }
})

require('configs.mini-files')
require('configs.mini-statusline')

require('configs.autocmds')
require('configs.cmds')
require('configs.keymaps')

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
  vim.pack.add({
    { src = gh("MeanderingProgrammer/render-markdown.nvim") }
  })
  require("render-markdown").setup({
    latex = {enabled=false},
    yaml = {enabled=false}
  })
  vim.pack.add({ gh('rafamadriz/friendly-snippets') })

  vim.pack.add({ gh('nvzone/volt') })
  vim.pack.add({ gh('rizkifuad/floaterm') })
  require('floaterm').setup({
    size = { h = 90, w = 90 },
    zmx = { enabled = true }
  })
  vim.pack.add({ gh('phanen/vbi.nvim') })
  -- vim.pack.add({ gh('jake-stewart/multicursor.nvim') })
  -- require("configs.multicursor")
end)
