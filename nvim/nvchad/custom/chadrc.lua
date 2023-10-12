---@type ChadrcConfig 
local M = {}

M.ui = {
  theme = 'pastelDark',
  -- transparency = true,

  nvdash = {
    load_on_startup = true,
  },
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
