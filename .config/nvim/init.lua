-- Main configuration
require("core/utils")
require("core/settings")
require("core/keymaps")
-- Plugins
vim.cmd [[packadd! packer.nvim]]
-- vim._update_package_paths()

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    -- UI Stuff
    use 'wadackel/vim-dogrun'
    use 'kyazdani42/nvim-web-devicons'
    use {
        -- 'hoob3rt/lualine.nvim',
        "nvim-lualine/lualine.nvim",
        event = 'BufRead',
        requires = 'kyazdani42/nvim-web-devicons',
        config = require"plugins.lualine".setup(),
        opt = true,
        -- cmd = 'ColorScheme'
    }
    use {
        'seblj/nvim-tabline',
        event = 'BufRead',
        requires = 'kyazdani42/nvim-web-devicons',
        config = require"plugins.tabline".setup(),
        opt = true,
    }
    use {
        'nvim-treesitter/nvim-treesitter',
        config = require"plugins.treesitter".setup(),
        run=':TSUpdate',
    }
    use { 'windwp/nvim-ts-autotag', opt = true }

    --     -- Navigation Stuff
    use {
        'nvim-telescope/telescope.nvim',
        -- event = 'BufWinOpen',
        cmd = 'Telescope',
        config = require"plugins.telescope".setup(),
        requires = {
            {'nvim-telescope/telescope-fzy-native.nvim'},
            {'ahmedkhalf/project.nvim'}
        }
    }
    use {
        'kyazdani42/nvim-tree.lua',
        -- event = 'BufWinOpen',
        cmd = { 'NvimTreeToggle', 'NvimTreeFindFile' },
        config = require"plugins.nvimtree".setup(),
        requires = 'kyazdani42/nvim-web-devicons',
        opt = true
    }
    use {
        'terrortylor/nvim-comment',
        event = 'BufRead',
        config = require"plugins.comment".setup(),
        -- opt = true
    }

    -- LSP Stuff

    use {
        'folke/lsp-colors.nvim',
        config = function()
            local colors = require "core.colors"
            require("lsp-colors").setup({
                Error = colors.red,
                Warning = colors.yellow,
                Information = colors.green,
                Hint = colors.blue
            })
        end
    }
    use {
        'neovim/nvim-lspconfig',
        config  = require"plugins.lspconfig".setup()
    }
    -- use 'nvim-lua/popup.nvim'
    use 'rafamadriz/friendly-snippets';
    use {
        'windwp/nvim-autopairs',
        config = require'plugins.autopairs'.setup()
    }
    use    {
        "hrsh7th/nvim-cmp",
        after = 'nvim-autopairs',
        config = require"plugins.cmp".setup(),
        requires = {
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lua",
        }
    }
    use 'nvim-lua/plenary.nvim'
    use {
        'folke/trouble.nvim',
        cmd = 'Trouble',
        config = require'plugins.trouble'.setup(),
    }

    -- Git Stuff
    local git = require("plugins.git")
    use {
        'lewis6991/gitsigns.nvim',
        event = 'BufRead',
        opt = true,
        requires = {
            'nvim-lua/plenary.nvim'
        },
        config = function()
            require('gitsigns').setup()
        end
    }
    use { 'tpope/vim-fugitive', cmd = 'Git', opt = true }
    use { 'ruifm/gitlinker.nvim', event = 'BufRead', config = git.setup_gitlinker(), opt = true }
    use { 'f-person/git-blame.nvim', event = 'BufRead', requires = "nvim-lua/plenary.nvim", opt = true }
    git.setup_config()

    -- Special case
    use { 'nelsyeung/twig.vim', ft = 'twig'}

    use {
        'norcalli/nvim-colorizer.lua',
        ft = { 'css', 'scss', 'html' },
        config = function()
            require 'colorizer'.setup {'css', 'scss', 'html'}
        end
    }
end)
-- Set colorscheme
vim.cmd 'colorscheme dogrun'
vim.cmd "au ColorScheme * hi TabLineSel cterm=bold ctermfg=235 ctermbg=104 gui=bold guifg=#a0a2c2 guibg=#222432"
vim.cmd "au ColorScheme * hi TabLineFill cterm=bold ctermfg=235 ctermbg=104 gui=bold guifg=#ff0000 guibg=#222432"
vim.cmd "au ColorScheme * hi TabLinePaddingActive guifg=#929be5 guibg=#222432"
vim.cmd "au ColorScheme * hi TabLineCloseActive guifg=#eeeeee guibg=#222432"
vim.cmd "au ColorScheme * hi TabLineSeparatorActive guifg=#b872b9 guibg=#222432"
vim.cmd "au ColorScheme * hi TabLineModifiedActive guifg=#ad7c21 guibg=#222432"
vim.cmd "au ColorScheme * hi TabLineModifiedSeparatorActive guifg=#ad7c21 guibg=#222432"
vim.cmd "au ColorScheme * hi TabLineFill cterm=bold ctermfg=235 ctermbg=104 guifg=#a0a2c2 guibg=#2a2c3e gui=none"
vim.cmd "au ColorScheme * hi TabLineSeparatorInactive guifg=#7f8490 guibg=#2a2c3f"
vim.cmd "au ColorScheme * hi TabLineCloseInactive guifg=#7f8490 guibg=#2a2c3f"
vim.cmd "au ColorScheme * hi TabLineCloseInactive guifg=#7f8490 guibg=#2a2c3f"
vim.cmd "au ColorScheme * hi TabLinePaddingInactive guifg=#2a2c3f guibg=#2a2c3f"
-- vim.cmd "au ColorScheme * hi Normal ctermbg=NONE guibg=NONE"


-- fzy
