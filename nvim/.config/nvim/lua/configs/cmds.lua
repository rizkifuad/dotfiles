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
  local session_dir = vim.fn.expand('~/.local/share/nvim/session/')

  -- 1. Gather all session files
  local files = vim.fn.globpath(session_dir, '*', false, true)
  local items = {}

  -- 1. Collect active sockets from /tmp
  local tmp_sockets = {}
  for _, sock in ipairs(vim.fn.glob('/tmp/nvim.*', false, true)) do
    local name = vim.fn.fnamemodify(sock, ':t'):gsub('^nvim%.', '')

    if vim.fn.isdirectory(sock) ~= 0 then
      break
    end
    if not name:find("%.log") then
      tmp_sockets[name] = sock
    end
  end

  -- 2. Process your session files
  local seen = {}

  for _, file_path in ipairs(files) do
    local session_name = vim.fn.fnamemodify(file_path, ':t')

    local is_active = tmp_sockets[session_name] ~= nil
    local status = is_active and 'active' or 'exited'

    table.insert(items, {
      status = status,
      text = session_name,
      path = file_path,
      socket = "/tmp/nvim." .. session_name
    })

    seen[session_name] = true
  end

  -- 3. Add orphan sockets (active sessions without file)
  for name, sock_path in pairs(tmp_sockets) do
    if not seen[name] then
      table.insert(items, {
        status = 'active',
        text = name,
        path = nil, -- no session file
        socket = sock_path,
      })
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
          if chosen_item.status == 'active' then
            vim.cmd("connect " .. chosen_item.socket)
          else
            local cmd = { "nvim", "--headless", "--listen", chosen_item.socket }
            if chosen_item.path ~= nil then
              cmd = { "nvim", "-S", chosen_item.path, "--headless", "--listen", chosen_item.socket }
            end
            vim.fn.jobstart(cmd, {
              detach = true
            })
            vim.defer_fn(function()
              vim.cmd("connect " .. chosen_item.socket)
              vim.cmd("stopinsert")
            end, 5000)
          end
        end
      end,
    },
  })
end

-- Create a user command to easily trigger it
vim.api.nvim_create_user_command('PickSession', pick_sessions, {})
