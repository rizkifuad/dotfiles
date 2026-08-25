-- Selalu tampilkan native tabline dan aktifkan dukungan mouse
vim.o.showtabline = 2
vim.o.mouse = 'a'

-- Callback global untuk klik mouse
_G.TablineClickCallback = function(minwid, clicks, button, modifiers)
  if button == 'l' then
    vim.cmd(minwid .. 'tabnext')
  elseif button == 'm' then
    vim.cmd(minwid .. 'tabclose')
  end
end

-- Helper untuk mengambil warna background dari highlight group yang ada
local function get_hl_bg(hl_name)
  local hl = vim.api.nvim_get_hl(0, { name = hl_name, link = false })
  if hl and hl.bg then
    return string.format("#%06x", hl.bg)
  end
  return "NONE"
end

-- PERBAIKAN: Fungsi ikon sekarang menerima status `is_modified` agar warnanya tidak belang
local function get_icon_with_color(filename, ext, is_active, is_modified)
  -- Pilih nama highlight group yang tepat sesuai status tab saat ini
  local base_hl_name = "TabLine"
  if is_active and is_modified then
    base_hl_name = "TabLineSelMod"
  elseif is_active then
    base_hl_name = "TabLineSel"
  elseif is_modified then
    base_hl_name = "TabLineMod"
  end

  local current_bg = get_hl_bg(base_hl_name)

  -- 1. Integrasi dengan mini.icons
  local has_mini, mini_icons = pcall(require, "mini.icons")
  if has_mini then
    local icon, hl_group = mini_icons.get("file", filename)
    if icon then
      local hl_data = vim.api.nvim_get_hl(0, { name = hl_group, link = false })
      local fg_color = hl_data.fg and string.format("#%06x", hl_data.fg) or "#ffffff"
      local custom_hl = "TablineIcon_" .. hl_group .. (is_active and "Sel" or "Inact") .. (is_modified and "Mod" or "")

      vim.api.nvim_set_hl(0, custom_hl, { fg = fg_color, bg = current_bg })
      return "%#" .. custom_hl .. "#" .. icon .. " "
    end
  end

  -- 2. Fallback ke nvim-web-devicons
  local has_devicons, devicons = pcall(require, "nvim-web-devicons")
  if has_devicons then
    local icon, hl_group = devicons.get_icon(filename, ext, { default = true })
    if icon and hl_group then
      local hl_data = vim.api.nvim_get_hl(0, { name = hl_group, link = false })
      local fg_color = hl_data.fg and string.format("#%06x", hl_data.fg) or "#ffffff"
      local custom_hl = "TablineIcon_" .. hl_group .. (is_active and "Sel" or "Inact") .. (is_modified and "Mod" or "")

      vim.api.nvim_set_hl(0, custom_hl, { fg = fg_color, bg = current_bg })
      return "%#" .. custom_hl .. "#" .. icon .. " "
    end
  end

  return ""
end

-- Fungsi generator tabline kustom
function MyCustomTabline()
  local s = ""
  local current_tab = vim.fn.tabpagenr()

  for i = 1, vim.fn.tabpagenr("$") do
    local winnr = vim.fn.tabpagewinnr(i)
    local buflist = vim.fn.tabpagebuflist(i)
    local bufnr = buflist[winnr]
    local bufname = vim.fn.bufname(bufnr)

    local filename = bufname ~= "" and vim.fn.fnamemodify(bufname, ":t") or "[No Name]"
    local ext = vim.fn.fnamemodify(filename, ":e")
    local is_active = (i == current_tab)
    local is_modified = vim.bo[bufnr].modified

    -- Mulai tracking klik mouse
    s = s .. "%" .. i .. "@v:lua.TablineClickCallback@"

    -- Set highlight group text utama
    if is_active then
      if is_modified then s = s .. "%#TabLineSelMod#" else s = s .. "%#TabLineSel#" end
    else
      if is_modified then s = s .. "%#TabLineMod#" else s = s .. "%#TabLine#" end
    end

    -- Padding tab dan nomor tab
    s = s .. "  "

    -- Ambil ikon dengan background yang sudah disinkronkan ke status modified
    local icon_string = get_icon_with_color(filename, ext, is_active, is_modified)
    s = s .. icon_string

    -- Kembalikan warna teks setelah blok ikon ditutup
    if is_active then
      if is_modified then s = s .. "%#TabLineSelMod#" else s = s .. "%#TabLineSel#" end
    else
      if is_modified then s = s .. "%#TabLineMod#" else s = s .. "%#TabLine#" end
    end

    -- Cetak nama file dan simbol modified
    s = s .. filename
    if is_modified then
      s = s .. " ●"
    end
    s = s .. "  "

    -- Akhiri tracking klik mouse
    s = s .. "%X"
  end

  s = s .. "%#TabLineFill#%T"
  return s
end

-- Hubungkan fungsi lua ke native tabline
vim.o.tabline     = '%!v:lua.MyCustomTabline()'

-- KUSTOMISASI WARNA (Ubah kode hex di sini jika ingin mengganti warna latar/teks)
local bg_inactive = '#222222'
local bg_active   = '#444444'

-- 1. Tab Normal (Sudah Disimpan)
vim.api.nvim_set_hl(0, 'TabLine', { fg = '#888888', bg = bg_inactive })
vim.api.nvim_set_hl(0, 'TabLineSel', { fg = '#ffffff', bg = bg_active, bold = true })

-- 2. Tab Modified (Belum Disimpan)
-- Di sini Anda bisa membedakan warna latar belakang (bg) jika ingin berbeda saat dimodifikasi
vim.api.nvim_set_hl(0, 'TabLineMod', { fg = '#e5c07b', bg = bg_inactive, italic = true })
vim.api.nvim_set_hl(0, 'TabLineSelMod', { fg = '#e5c07b', bg = bg_active, bold = true })

-- 3. Sisa area kosong di tabline
vim.api.nvim_set_hl(0, 'TabLineFill', { bg = '#111111' })
