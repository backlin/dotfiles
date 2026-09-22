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

-- config.color_scheme above is only evaluated when the config is loaded, so it
-- goes stale when the system switches between light and dark. Re-apply it as a
-- per-window override on every config reload (WezTerm reloads the config when
-- the system appearance changes).
wezterm.on('window-config-reloaded', function(window)
    local overrides = window:get_config_overrides() or {}
    local scheme = scheme_for_appearance(window:get_appearance())
    if overrides.color_scheme ~= scheme then
        overrides.color_scheme = scheme
        window:set_config_overrides(overrides)
    end
end)

config.font = wezterm.font('JetBrains Mono', { weight = 'Medium' })

-- Mac-specific below

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

return config
