-- First read our docs (completely) then check the example_config repo

---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
-- local highlights = require "custom.highlights"

M.ui = {
  theme = "ayu_dark",
  theme_toggle = { "ayu_dark", "ayu_light" },
}

M.plugins = "custom.plugins"
M.mappings = require "custom.mappings"

return M
