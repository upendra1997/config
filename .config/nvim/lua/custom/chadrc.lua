-- First read our docs (completely) then check the example_config repo

---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
-- local highlights = require "custom.highlights"

M.ui = {
  theme = "onedark",
  theme_toggle = { "onedark", "one_light" },
}

M.plugins = require "custom.plugins"
M.mappings = require "custom.mappings"

return M
