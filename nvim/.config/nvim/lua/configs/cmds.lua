-- User Commands

-- Remove inactive packages
vim.api.nvim_create_user_command('VimPackDelInactive', function()
  local unused = vim.iter(vim.pack.get())
      :filter(function(x) return not x.active end)
      :map(function(x) return x.spec.name end)
      :totable()

  vim.pack.del(unused)
end, { desc = 'Remove inactive packages' })

-- lsp related

vim.api.nvim_create_user_command('LSPFormat', function()
  vim.lsp.buf.format()
end, { desc = 'Format the file using the LSP support' })


local function pick_sessions()
  local mini_pick = require('mini.pick')
  local items = {}

  for _, path in ipairs(vim.fn.glob('/tmp/nvim.*', false, true)) do
    -- keep only NON-directories
    if vim.fn.isdirectory(path) == 0 then
      local name = vim.fn.fnamemodify(path, ':t'):gsub('^nvim%.', '')

      if ! name:find("%.log") then
        table.insert(items, {
          status = 'active',
          text = name,
          socket = path,
        })
      end
    end
  end

  -- 4. Start the mini.pick instance
  mini_pick.start({
    source = {
      items = items,
      name = 'Sessions',
      -- Tell mini.pick how to display the items
      show = function(buf_id, items_to_show, query)
        local lines = {}
        for _, item in ipairs(items_to_show) do
          table.insert(lines, item.text .. ' (' .. item.status .. ')')
        end
        vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, lines)
      end,
      -- Define what happens when you press Enter
      choose = function(chosen_item)
        if chosen_item then
          local socket_path = "/tmp/nvim." .. chosen_item.text
          if chosen_item.status == 'active' then
            vim.cmd("connect " .. socket_path)
          end
        end
      end,
    },
  })
end

-- Create a user command to easily trigger it
vim.api.nvim_create_user_command('PickSession', pick_sessions, {})
