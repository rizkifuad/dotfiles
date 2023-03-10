local tohex, bor, lshift, rshift, band = bit.tohex, bit.bor, bit.lshift, bit.rshift, bit.band

local M = {}

function M.document_color()
  local params = {
    textDocument = vim.lsp.util.make_text_document_params(),
  }

  local clients = vim.lsp.get_active_clients()
  if not clients then
    return
  end
  for _, client in ipairs(clients) do
    if client.server_capabilities.colorProvider and client.name == "dartls" then
      client.request("textDocument/documentColor", params, nil, 0)
    end
  end
end

local CLIENT_NS = vim.api.nvim_create_namespace("flutter_tools_lsp_document_color")

function M.decode_24bit_rgb(rgb_24bit)
  vim.validate({ rgb_24bit = { rgb_24bit, "n", true } })
  local r = band(rshift(rgb_24bit, 16), 255)
  local g = band(rshift(rgb_24bit, 8), 255)
  local b = band(rgb_24bit, 255)
  return { r = r, g = g, b = b }
end

function M.get_background_color()
  local normal_hl = vim.api.nvim_get_hl_by_name("Normal", true)
  if not normal_hl or not normal_hl.background then
    return nil
  end
  return M.decode_24bit_rgb(normal_hl.background)
end

function M.rgb_to_hex(rgb)
  vim.validate({
    r = { rgb.r, "n", false },
    g = { rgb.g, "n", false },
    b = { rgb.b, "n", false },
  })
  return tohex(bor(lshift(rgb.r, 16), lshift(rgb.g, 8), rgb.b), 6)
end

function M.rgba_to_rgb(rgba, bg_rgb)
  vim.validate({
    rgba = { rgba, "t", true },
    bg_rgb = { bg_rgb, "t", false },
    r = { rgba.r, "n", true },
    g = { rgba.g, "n", true },
    b = { rgba.b, "n", true },
    a = { rgba.a, "n", true },
  })

  vim.validate({
    bg_r = { bg_rgb.r, "n", true },
    bg_g = { bg_rgb.g, "n", true },
    bg_b = { bg_rgb.b, "n", true },
  })

  local r = rgba.r * rgba.a + bg_rgb.r * (1 - rgba.a)
  local g = rgba.g * rgba.a + bg_rgb.g * (1 - rgba.a)
  local b = rgba.b * rgba.a + bg_rgb.b * (1 - rgba.a)

  return { r = r, g = g, b = b }
end

function M.color_virtual_text(_, bufnr, range, rgb, virtual_text_str)
  local hex = M.rgb_to_hex(rgb)

  local hlname = string.format("LspDocumentColorVirtualText%s", hex)
  vim.cmd(string.format("highlight %s guifg=#%s", hlname, hex))

  local line = range["end"]["line"]
  vim.api.nvim_buf_set_virtual_text(bufnr, CLIENT_NS, line, { { virtual_text_str, hlname } }, {})
end

function M.buf_clear_color(client_id, bufnr)
  vim.validate({
    client_id = { client_id, "n", true },
    bufnr = { bufnr, "n", true },
  })
  if vim.api.nvim_buf_is_valid(bufnr) then
    vim.api.nvim_buf_clear_namespace(bufnr, CLIENT_NS, 0, -1)
  end
end


return M
