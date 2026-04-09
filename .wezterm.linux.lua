local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.hide_tab_bar_if_only_one_tab = true
config.color_scheme = 'One Dark (Gogh)'

config.font = wezterm.font('JetBrains Mono', { weight = 'Medium' })

return config
