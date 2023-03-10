local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local extras = require("luasnip.extras")
local rep = extras.rep
local fmt = require("luasnip.extras.fmt").fmt

return {
  s("ic", fmt(
    [[
import {{ {} }} from "./{}";

export default {};
]]
    , {
    i(1), rep(1), rep(1)
  })),

}
