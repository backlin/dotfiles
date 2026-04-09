local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.hide_tab_bar_if_only_one_tab = true
config.color_scheme = 'One Dark (Gogh)'

-- Enable Kitty keyboard protocol so Zellij can receive Super modifier
config.enable_kitty_keyboard = true

-- Cmd++ to increase font size (Swedish keyboard friendly)
config.keys = {
  { key = '+', mods = 'SUPER', action = wezterm.action.IncreaseFontSize },
}

-- Open hyperlinks on Cmd+click
-- In Zellij, use Cmd+Shift+click since Shift tells Zellij to not capture mouse event but pass to WezTerm
config.mouse_bindings = {
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'SUPER',
    action = wezterm.action.OpenLinkAtMouseCursor,
  },
}

config.font = wezterm.font('JetBrains Mono', { weight = 'Medium' })

return config
