-- Global conversion functions (kept exactly as you had them)
function _G.env_to_json()
  vim.cmd("set paste")
  vim.cmd("silent g/^$/d")
  vim.cmd("silent %s/\"//ge")
  vim.cmd("silent %s/=/\":\"/")
  vim.cmd("silent %s/$/\",/")
  vim.cmd("silent %s/^/\"/")
  vim.cmd("silent norm ggO{")
  vim.cmd("silent norm Go}")
  vim.cmd("set nopaste")
end

function _G.json_to_env()
  vim.cmd("set paste")
  vim.cmd("silent g/^$/d")
  vim.cmd("silent %s/\": \"/=/ge")
  vim.cmd("silent %s/\"//ge")
  vim.cmd("silent %s/,$//")
  vim.cmd("set nopaste")
end

function _G.env_to_yaml()
  vim.cmd("set paste")
  vim.cmd("silent %s/\"//ge")
  vim.cmd("silent %s/^$\\n//ge")
  vim.cmd("silent g/^#/d")
  vim.cmd("silent %s/^/- name: ")
  vim.cmd("silent %s/=\\(.*\\)/\r value: \"\\1\"")
  vim.cmd("set nopaste")
end

function _G.open_notes()
  vim.cmd("tabnew")
  vim.cmd("lcd " .. vim.fn.expand("~/notes"))
  vim.cmd("Pick files_with_hidden")
end

-- Curated list of commands (Telescope references migrated over to mini.pick)
local my_commands = {
  { desc = "Find files",                cmd = function() require('mini.pick').builtin.files() end },
  { desc = "Find hidden files",         cmd = function() require('mini.pick').builtin.files({ tool = 'git' }) end }, -- Or fallback to your custom rg command if needed
  { desc = "Minify JSON",               cmd = "silent %!jq -r tostring" },
  { desc = "Format current buffer",     cmd = function() vim.lsp.buf.format() end },
  { desc = "Env To JSON",               cmd = function() env_to_json() end },
  { desc = "Env To YAML",               cmd = function() env_to_yaml() end },
  { desc = "JSON To Env",               cmd = function() json_to_env() end },
  { desc = "Restart LSP",               cmd = "lsp restart" },
  { desc = "Notes",                     cmd = open_notes },

  -- OPTION A: The modern, thorough way to check your LSP ecosystem health
  { desc = "LSP: Show Status & Health", cmd = "checkhealth vim.lsp" },

  -- OPTION B: A clean, pop-up text alert showing exactly what is attached right now
  {
    desc = "LSP: Show Active Clients",
    cmd = function()
      local clients = vim.lsp.get_clients({ bufnr = 0 })
      if #clients == 0 then
        vim.notify("No active LSP clients attached to this buffer.", vim.log.levels.WARN)
        return
      end
      local names = {}
      for _, client in ipairs(clients) do table.insert(names, "- " .. client.name) end
      vim.notify("Active LSP Clients:\n" .. table.concat(names, "\n"), vim.log.levels.INFO)
    end
  }
}

-- Sort commands by description to mimic your commander.nvim sorting config
table.sort(my_commands, function(a, b) return a.desc < b.desc end)

-- Main trigger keymap to spawn your custom Command Center
vim.keymap.set('n', '<space><space>', function()
  require('mini.pick').start({
    source = {
      name = 'Command Center',
      items = my_commands,
      -- Formats the picker items using only your descriptions (matching your components settings)
      show = function(buf_id, items, query)
        local lines = vim.tbl_map(function(v) return v.desc end, items)
        vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, lines)
      end,
      -- Smart picker action executor
      choose = function(item)
        if not item then return end

        vim.schedule(function()
          if type(item.cmd) == "function" then
            item.cmd()
          else
            vim.cmd(item.cmd)
          end
        end)
      end,
    }
  })
end, { noremap = true, desc = "Open Command Center" })
