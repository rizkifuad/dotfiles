local ls = require "luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local f = ls.function_node
local t = ls.text_node
local i = ls.insert_node
local d = ls.dynamic_node
local rep = require "luasnip.extras".rep
local fmt = require "luasnip.extras.fmt".fmt

return {
  s("ss", fmt(
[[
setState(() {{
  {}
}});
]], { i(1) })),
}
