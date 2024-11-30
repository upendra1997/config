-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

local function schemes()
  local schemes = wezterm.get_builtin_color_schemes()
  local dark = {}
  local light = {}
  local gogh = {}
  for name, scheme in pairs(schemes) do
    -- parse into a color object
    local bg = wezterm.color.parse(scheme.background)
    -- and extract HSLA information
    local h, s, l, a = bg:hsla()

    -- `l` is the "lightness" of the color where 0 is darkest
    -- and 1 is lightest.
    if string.find(name, "Gogh") then
      table.insert(gogh, name)
    end
    if l < 0.4 then
      table.insert(dark, name)
    else
      table.insert(light, name)
    end
  end

  table.sort(dark)
  table.sort(light)
  table.sort(gogh)
  return { light = light, dark = dark, gogh = gogh }
end


-- This is where you actually apply your config choices

config.font = wezterm.font 'Iosevka Nerd Font'
config.window_background_opacity = 0.80
config.window_decorations = "RESIZE"
-- config.hide_tab_bar_if_only_one_tab = true
config.enable_tab_bar = false
config.enable_scroll_bar = false
config.font_size = 20.0

-- local schemes = schemes()

-- local theme = schemes["gogh"]
-- local random_theme = theme[math.random(#theme)]
-- wezterm.log_error(random_theme)
-- config.color_scheme = "GruvboxDark" -- random_theme
config.color_scheme = 'Everforest Dark Hard (Gogh)'
config.front_end = "WebGpu"


-- and finally, return the configuration to wezterm
return config
