local naughty = require("naughty")
local markup = require("lain.util.markup")

local id = naughty.notify({
  text = markup(arg[2] .. arg[3]),
  icon = arg[1],
  icon_size = 64,
  bg = "#202020",
  fg = "#DFDFDF",
  timeout = 8,
  margin = 8,
  replaces_id = id
})
