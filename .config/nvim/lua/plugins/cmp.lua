-----------------------------------------------------------
-- Autocomplete configuration file
-----------------------------------------------------------

-- Plugin: nvim-cmp
-- https://github.com/hrsh7th/nvim-cmp
--
local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

local function T(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end
local M = {}

function M.setup()
    local status_cmp_ok, cmp = pcall(require, "cmp")
    if not status_cmp_ok then
        return
    end
    local status_luasnip_ok, luasnip = pcall(require, "luasnip")
    if not status_luasnip_ok then
        return
    end

    require("luasnip/loaders/from_vscode").lazy_load()

    cmp.setup {
        -- load snippet support
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },

        -- completion settings
        completion = {
            completeopt = 'menuone,noselect'
        },

        -- key mapping
        mapping = {
            ['<C-p>'] = cmp.mapping.select_prev_item {
                behavior = cmp.SelectBehavior.Insert,
            },
            ['<C-n>'] = cmp.mapping.select_next_item {
                behavior = cmp.SelectBehavior.Insert,
            },
            ['<CR>'] = cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
            },
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.close(),

            -- Tab mapping
            -- ['<Tab>'] = function(fallback)
            --     if cmp.visible() then
            --         cmp.select_next_item()
            --     else
            --         fallback()
            --     end
            -- end,
            -- ['<S-Tab>'] = function(fallback)
            --     if cmp.visible() then
            --         cmp.select_prev_item()
            --     else
            --         fallback()
            --     end
            -- end
            --
            ["<Tab>"] = cmp.mapping(function()
                if vim.fn.pumvisible() == 1 then
                    vim.fn.feedkeys(T "<down>", "n")
                elseif luasnip.expand_or_jumpable() then
                    vim.fn.feedkeys(T "<Plug>luasnip-expand-or-jump", "")
                elseif check_backspace() then
                    vim.fn.feedkeys(T "<Tab>", "n")
                -- elseif is_emmet_active() then
                --     return vim.fn["cmp#complete"]()
                else
                    vim.fn.feedkeys(T "<Tab>", "n")
                end
            end, {
                    "i",
                    "s",
                }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if vim.fn.pumvisible() == 1 then
                    vim.fn.feedkeys(T "<up>", "n")
                elseif luasnip.jumpable(-1) then
                    vim.fn.feedkeys(T "<Plug>luasnip-jump-prev", "")
                else
                    fallback()
                end
            end, {
                    "i",
                    "s",
                }),
        },

        -- load sources, see: https://github.com/topics/nvim-cmp
        sources = {
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
            { name = 'path' },
            { name = 'buffer' },
            { name = "nvim_lua" },
            { name = "calc" },
            { name = "emoji" },
            { name = "treesitter" },
            { name = "crates" },
        },
    }

    -- you need setup cmp first put this after cmp.setup()
    require("nvim-autopairs.completion.cmp").setup({
        map_cr = true, --  map <CR> on insert mode
        map_complete = true, -- it will auto insert `(` (map_char) after select function or method item
        auto_select = true, -- automatically select the first item
        insert = false, -- use insert confirm behavior instead of replace
        map_char = { -- modifies the function or method delimiter by filetypes
            all = '(',
            tex = '{'
        }
    })
end

return M
