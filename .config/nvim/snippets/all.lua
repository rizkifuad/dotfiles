local ls = require"luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node

local all = {
    s("lorem", {
      t(
        { "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
          "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s." }
      )
    }),

    s("lorem2", {
      t(
        { "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
          "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
          "It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
          "It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum." })
    }),
}

return all
