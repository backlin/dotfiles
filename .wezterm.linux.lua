-- OS independent

local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.hide_tab_bar_if_only_one_tab = true

local function scheme_for_appearance(appearance)
  if appearance:find 'Dark' then
    return 'One Dark (Gogh)'
  else
    return 'One Light (Gogh)'
  end
end

config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())

config.font = wezterm.font('JetBrains Mono', { weight = 'Medium' })

return config
