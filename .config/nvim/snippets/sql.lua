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
  s("goo", fmt(
[[
-- +goose Up
-- +goose StatementBegin
{}
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
{}
-- +goose StatementEnd
]], { i(1), i(2) })),
}
