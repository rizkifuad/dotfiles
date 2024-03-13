require "user.settings.options"
require "user.settings.augroup"
require "user.settings.keymaps"
require "user.settings.augroup"
require "user.settings.gui"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    config = function()
      require("catppuccin").setup {
        integrations = {
          native_lsp = {
            enabled = true,
            underlines = {
              errors = { "undercurl" },
              hints = { "undercurl" },
              warnings = { "undercurl" },
              information = { "undercurl" },
            },
          },
        }
      }
      vim.cmd.colorscheme "catppuccin-macchiato"
    end
  },

  {
    "folke/tokyonight.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      -- require("catppuccin").setup {
      -- integrations = {
      -- native_lsp = {
      -- enabled = true,
      -- underlines = {
      -- errors = { "undercurl" },
      -- hints = { "undercurl" },
      -- warnings = { "undercurl" },
      -- information = { "undercurl" },
      -- },
      -- },
      -- }
      -- }
      -- vim.cmd.colorscheme "tokyonight"
    end
  },

  {
    "akinsho/bufferline.nvim",
    config = function()
      require("user.plugins.bufferline")
    end
  },


  {
    "SmiteshP/nvim-navic",
    config = function()
      require("user.plugins.navic")
    end
  },

  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("user.plugins.lualine")
    end
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    lazy = true,
    cmd = "Neotree",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("user.plugins.neotree")
    end
  },

  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    lazy = true,
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-telescope/telescope-project.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-live-grep-args.nvim",
    },
    config = function()
      require "user.plugins.telescope"
    end
  },

  {
    "FeiyouG/commander.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require "user.plugins.commander"
    end

  },

  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "windwp/nvim-ts-autotag",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "windwp/nvim-ts-autotag",
      "andymass/vim-matchup",
      "nvim-treesitter/playground",
      {
        "numtostr/comment.nvim",
        config = function()
          require "user.plugins.comment"
        end
      }
    },
    lazy = true,
    event = "BufRead",
    config = function()
      require "user.plugins.treesitter"
    end
  },

  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    config = function()
      require('ts_context_commentstring').setup {
        enable_autocmd = false,
      }
    end
  },

  {
    "hrsh7th/nvim-cmp",
    lazy = true,
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
      "windwp/nvim-autopairs",
    },
    config = function()
      require "user.plugins.cmp"
    end
  },

  {
    "neovim/nvim-lspconfig",
    lazy = true,
    event = "BufRead",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      'jay-babu/mason-nvim-dap.nvim',
      { "j-hui/fidget.nvim", tag = "legacy" },
      "folke/neodev.nvim",
      "jose-elias-alvarez/null-ls.nvim",
    },
    config = function()
      require "user.lsp"
    end
  },

  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "leoluz/nvim-dap-go",
    },
    config = function()
      require "user.dap"
    end
  },

  --[[ {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    lazy = true,
    config = function()
      require "user.plugins.indentline"
    end
  }, ]]

  {
    "norcalli/nvim-colorizer.lua",
    event = "BufRead",
    lazy = true,
    ft = { "css", "scss", "sass", "html", "lua" },
    config = function()
      require "user.plugins.colorizer"
    end
  },

  {
    "lewis6991/gitsigns.nvim",
    lazy = true,
    event = "BufRead",
    config = function()
      require "user.plugins.gitsigns"
    end
  },

  {
    "tpope/vim-fugitive",
    lazy = true,
    cmd = { "Git", "Gvdiff", "Gdiff" }
  },

  {
    "ruifm/gitlinker.nvim",
    lazy = true,
    cmd = "GitLinker",
    config = function()
      require "user.plugins.gitlinker"
    end
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = require "user.plugins.flash".keys,
    config = function()
      require "user.plugins.flash".setup()
    end
  },

  {
    "Wansmer/treesj",
    cmd = "TSJToggle",
    opts = { use_default_keymaps = false, max_join_length = 150 },
  },

  {
    "Exafunction/codeium.vim",
    event = "BufRead",
    lazy = true
  },

  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
      require "user.plugins.toggleterm"
    end
  },

  {
    "elixir-tools/elixir-tools.nvim",
    version = "*",
    config = function()
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

  {
    "rest-nvim/rest.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require "user.plugins.rest"
    end
  },
  "folke/zen-mode.nvim",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
{
  'kristijanhusak/vim-dadbod-ui',
  dependencies = {
    { 'tpope/vim-dadbod', lazy = true },
    { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
  },
  cmd = {
    'DBUI',
    'DBUIToggle',
    'DBUIAddConnection',
    'DBUIFindBuffer',
  },
  init = function()
    -- Your DBUI configuration
    vim.g.db_ui_use_nerd_fonts = 1
  end,
}

})
