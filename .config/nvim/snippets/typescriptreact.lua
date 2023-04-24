local ls = require "luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local f = ls.function_node
local t = ls.text_node
local i = ls.insert_node
local d = ls.dynamic_node
local rep = require "luasnip.extras".rep
local fmt = require "luasnip.extras.fmt".fmt

local contextName = function(index)
  return f(function(arg, snip)
    return snip.env.TM_FILENAME_BASE
  end, { index })
end

local contextProvider = function(index)
  return f(function(arg, snip)
    return snip.env.TM_FILENAME_BASE:gsub("Context", "")
  end, { index })
end

return {
  s("com", fmt("<{}>{}</{}>", { i(1), i(2), rep(1) })),
  s("sty", fmt("const {} = styled.{}`\n{}\n`", { i(1, "Box"), i(2, "div"), i(3) })),
  s("ric", fmt(
    [[

interface IProps {{
}}

export const {} = (props: IProps) => {{
  return (
      {}
  )
}}
  ]], { contextProvider(),  i(1, "") })),

  s("rhc", fmt(
    [[
import React, {{ createContext, useContext, useState, ReactNode }} from 'react';

interface {}Interface {{
  
}}

const {} = createContext<{}Interface>(
  {{}}
);

export const {}Provider = ({{ children }}: {{ children: ReactNode}}) => {{
  const [open, setOpen] = useState(false);

  return (
    <{}.Provider
      value={{{{
        open
      }}}}
    >
      {{children}}
    </{}.Provider>
  );
}};

export const use{} = () => useContext({})
]]
    , { contextName(), contextName(), contextName(), contextProvider(), contextName(), contextName(), contextProvider(), contextName() })),

  s("shc", fmt(
    [[
import {{ createSignal, createContext, useContext, JSX  }} from "solid-js";

interface {}Interface {{
  
}}

const {} = createContext<{}Interface>(
  {{}}
);

export const {}Provider = (props: {{ children: JSX.Element }}) => {{
  const [open, setOpen] = createSignal(false);

  return (
    <{}.Provider
      value={{{{
        open
      }}}}
    >
      {{children}}
    </{}.Provider>
  );
}};

export const use{} = () => useContext({})
]]
    , { contextName(), contextName(), contextName(), contextProvider(), contextName(), contextName(), contextProvider(), contextName() }))

}
