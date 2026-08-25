local snippets = require('mini.snippets')
local gen_loader = snippets.gen_loader
local match_strict = function(snips)
  -- Do not match with whitespace to cursor's left
  return snippets.default_match(snips, { pattern_fuzzy = '%S+' })
end
snippets.setup({
  -- ... Set up snippets ...
  snippets = {
    -- Load custom file with global snippets first (adjust for Windows)
    gen_loader.from_file('~/.config/nvim/snippets/global.json'),

    -- Load snippets based on current language by reading files from
    -- "snippets/" subdirectories from 'runtimepath' directories.
    gen_loader.from_lang(),
  },
  mappings = { expand = '', jump_next = '', jump_prev = '' },
  expand   = { match = match_strict },
})
local expand_or_jump = function()
  local can_expand = #MiniSnippets.expand({ insert = false }) > 0
  if can_expand then
    vim.schedule(MiniSnippets.expand); return ''
  end
  local is_active = MiniSnippets.session.get() ~= nil
  if is_active then
    MiniSnippets.session.jump('next'); return ''
  end
  return '\t'
end
local jump_prev = function() MiniSnippets.session.jump('prev') end
vim.keymap.set('i', '<Tab>', expand_or_jump, { expr = true })
vim.keymap.set('i', '<S-Tab>', jump_prev)
