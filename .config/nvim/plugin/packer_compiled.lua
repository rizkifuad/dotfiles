-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/rizki/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/rizki/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/rizki/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/rizki/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/rizki/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  LuaSnip = {
    loaded = true,
    path = "/Users/rizki/.local/share/nvim/site/pack/packer/start/LuaSnip"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/Users/rizki/.local/share/nvim/site/pack/packer/start/cmp-buffer"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/Users/rizki/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp"
  },
  ["cmp-nvim-lua"] = {
    loaded = true,
    path = "/Users/rizki/.local/share/nvim/site/pack/packer/start/cmp-nvim-lua"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/Users/rizki/.local/share/nvim/site/pack/packer/start/cmp-path"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/Users/rizki/.local/share/nvim/site/pack/packer/start/cmp_luasnip"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/Users/rizki/.local/share/nvim/site/pack/packer/start/friendly-snippets"
  },
  ["git-blame.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/rizki/.local/share/nvim/site/pack/packer/opt/git-blame.nvim"
  },
  ["gitlinker.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/rizki/.local/share/nvim/site/pack/packer/opt/gitlinker.nvim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rgitsigns\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/rizki/.local/share/nvim/site/pack/packer/opt/gitsigns.nvim"
  },
  ["lsp-colors.nvim"] = {
    config = { "\27LJ\2\n¬\1\0\0\5\0\r\0\0186\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\1\3\0015\3\5\0009\4\4\0=\4\6\0039\4\a\0=\4\b\0039\4\t\0=\4\n\0039\4\v\0=\4\f\3B\1\2\1K\0\1\0\tHint\tblue\16Information\ngreen\fWarning\vyellow\nError\1\0\0\bred\nsetup\15lsp-colors\16core.colors\frequire\0" },
    loaded = true,
    path = "/Users/rizki/.local/share/nvim/site/pack/packer/start/lsp-colors.nvim"
  },
  ["lualine.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/rizki/.local/share/nvim/site/pack/packer/opt/lualine.nvim"
  },
  ["nvim-autopairs"] = {
    loaded = true,
    path = "/Users/rizki/.local/share/nvim/site/pack/packer/start/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    loaded = true,
    needs_bufread = false,
    path = "/Users/rizki/.local/share/nvim/site/pack/packer/opt/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\nM\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\4\0\0\bcss\tscss\thtml\nsetup\14colorizer\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/rizki/.local/share/nvim/site/pack/packer/opt/nvim-colorizer.lua"
  },
  ["nvim-comment"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/rizki/.local/share/nvim/site/pack/packer/opt/nvim-comment"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/rizki/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-tabline"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/rizki/.local/share/nvim/site/pack/packer/opt/nvim-tabline"
  },
  ["nvim-tree.lua"] = {
    commands = { "NvimTreeToggle", "NvimTreeFindFile" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/rizki/.local/share/nvim/site/pack/packer/opt/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/rizki/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-ts-autotag"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/rizki/.local/share/nvim/site/pack/packer/opt/nvim-ts-autotag"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/rizki/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/rizki/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/rizki/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["project.nvim"] = {
    loaded = true,
    path = "/Users/rizki/.local/share/nvim/site/pack/packer/start/project.nvim"
  },
  ["telescope-fzy-native.nvim"] = {
    loaded = true,
    path = "/Users/rizki/.local/share/nvim/site/pack/packer/start/telescope-fzy-native.nvim"
  },
  ["telescope.nvim"] = {
    commands = { "Telescope" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/rizki/.local/share/nvim/site/pack/packer/opt/telescope.nvim"
  },
  ["trouble.nvim"] = {
    commands = { "Trouble" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/rizki/.local/share/nvim/site/pack/packer/opt/trouble.nvim"
  },
  ["twig.vim"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/rizki/.local/share/nvim/site/pack/packer/opt/twig.vim"
  },
  ["vim-dogrun"] = {
    loaded = true,
    path = "/Users/rizki/.local/share/nvim/site/pack/packer/start/vim-dogrun"
  },
  ["vim-fugitive"] = {
    commands = { "Git" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/rizki/.local/share/nvim/site/pack/packer/opt/vim-fugitive"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: lsp-colors.nvim
time([[Config for lsp-colors.nvim]], true)
try_loadstring("\27LJ\2\n¬\1\0\0\5\0\r\0\0186\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\1\3\0015\3\5\0009\4\4\0=\4\6\0039\4\a\0=\4\b\0039\4\t\0=\4\n\0039\4\v\0=\4\f\3B\1\2\1K\0\1\0\tHint\tblue\16Information\ngreen\fWarning\vyellow\nError\1\0\0\bred\nsetup\15lsp-colors\16core.colors\frequire\0", "config", "lsp-colors.nvim")
time([[Config for lsp-colors.nvim]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file NvimTreeFindFile lua require("packer.load")({'nvim-tree.lua'}, { cmd = "NvimTreeFindFile", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file NvimTreeToggle lua require("packer.load")({'nvim-tree.lua'}, { cmd = "NvimTreeToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Git lua require("packer.load")({'vim-fugitive'}, { cmd = "Git", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Trouble lua require("packer.load")({'trouble.nvim'}, { cmd = "Trouble", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Telescope lua require("packer.load")({'telescope.nvim'}, { cmd = "Telescope", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType twig ++once lua require("packer.load")({'twig.vim'}, { ft = "twig" }, _G.packer_plugins)]]
vim.cmd [[au FileType css ++once lua require("packer.load")({'nvim-colorizer.lua'}, { ft = "css" }, _G.packer_plugins)]]
vim.cmd [[au FileType scss ++once lua require("packer.load")({'nvim-colorizer.lua'}, { ft = "scss" }, _G.packer_plugins)]]
vim.cmd [[au FileType html ++once lua require("packer.load")({'nvim-colorizer.lua'}, { ft = "html" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au BufRead * ++once lua require("packer.load")({'git-blame.nvim', 'gitsigns.nvim', 'nvim-comment', 'gitlinker.nvim', 'nvim-tabline', 'lualine.nvim'}, { event = "BufRead *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /Users/rizki/.local/share/nvim/site/pack/packer/opt/twig.vim/ftdetect/twig.vim]], true)
vim.cmd [[source /Users/rizki/.local/share/nvim/site/pack/packer/opt/twig.vim/ftdetect/twig.vim]]
time([[Sourcing ftdetect script at: /Users/rizki/.local/share/nvim/site/pack/packer/opt/twig.vim/ftdetect/twig.vim]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
