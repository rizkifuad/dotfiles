local pick = require('mini.pick')

pick.setup({
  mappings = {
    send_to_qf = {
      char = '<C-q>',
      func = function()
        pick.default_choose_marked(pick.get_picker_matches().all)
      end,
    },
  },
  window = {
    prompt_prefix = '  ',
    config = function()
      local screen_w = vim.o.columns
      local screen_h = vim.o.lines
      local width = math.floor(screen_w * 0.6)
      local height = math.floor(screen_h * 0.4)

      return {
        relative = 'editor',
        anchor = 'NW',
        height = height,
        width = width,
        row = math.floor((screen_h - height) / 2),
        col = math.floor((screen_w - width) / 2),

        border = { " ", " ", " ", " ", " ", " ", " ", " " }
      }
    end
  },
})

local C = require("catppuccin.palettes").get_palette()

vim.api.nvim_set_hl(0, "MiniPickNormal", { bg = C.crust })
vim.api.nvim_set_hl(0, "MiniPickBorder", { fg = C.crust, bg = C.crust }) -- Match fg to bg
vim.api.nvim_set_hl(0, "MiniPickBorderText", { fg = C.crust, bg = C.lavender, bold = true })
vim.api.nvim_set_hl(0, "MiniPickMatchCurrent", { bg = C.surface0, bold = true })
vim.api.nvim_set_hl(0, 'MiniPickPrompt', { bg = C.crust, fg = C.overlay1 })
vim.api.nvim_set_hl(0, 'MiniPickPromptPrefix', { bg = C.crust, fg = C.surface2, bold = true })
vim.api.nvim_set_hl(0, 'MiniPickBorder', { bg = C.crust, fg = C.crust })

pick.registry.files_with_hidden = function()
  -- Add the --hidden flag to the fd command
  local command = { 'fd', '--type=f', '--no-follow', '--color=never', '--hidden', '--exclude=.git' }
  local show_with_icons = function(buf_id, items, query)
    return pick.default_show(buf_id, items, query, { show_icons = true })
  end
  local source = { name = 'Files with hidden', show = show_with_icons }

  return pick.builtin.cli({ command = command }, { source = source })
end


vim.keymap.set("n", "<leader>gb", function()
  require('mini.pick').start({
    source = {
      name = 'Git Branch Switcher',

      items = function()
        local result = vim.fn.systemlist("git branch --all --no-color")
        local items = {}

        for _, line in ipairs(result) do
          -- Clean branch name
          local branch = line:gsub("^%*%s*", ""):gsub("^%s*", "")

          -- Skip HEAD detached refs
          if not branch:match("HEAD") then
            table.insert(items, {
              desc = branch,
              cmd = function()
                -- Remove "remotes/origin/" prefix if exists
                local clean = branch:gsub("^remotes/origin/", "")
                vim.cmd("Git checkout " .. clean)
              end,
            })
          end
        end

        return items
      end,

      show = function(buf_id, items, _)
        local lines = vim.tbl_map(function(v)
          return v.desc
        end, items)
        vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, lines)
      end,

      choose = function(item)
        if not item then return end

        if type(item.cmd) == "function" then
          item.cmd()
        else
          vim.cmd(item.cmd)
        end
      end,
    }
  })
end, { desc = "Git Branch Switcher" })
