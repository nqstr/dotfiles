local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.font = wezterm.font 'JetBrainsMono Nerd Font'
config.scrollback_lines = 10000
config.window_close_confirmation = 'NeverPrompt'
config.window_background_opacity = 0.8

config.keys = {
    -- Bind Ctrl+Shift+PageDown to split vertically (create a new pane to the right)
    {
        key = "DownArrow",
        mods = "CTRL|SHIFT",
        action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" },
    },
    -- Bind Ctrl+Shift+PageUp to split horizontally (create a new pane below)
    {
        key = "UpArrow",
        mods = "CTRL|SHIFT",
        action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" },
    },
}

config.mouse_bindings = {
    {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'NONE',
      action = wezterm.action_callback(function(window, pane)
        local url = window:get_selection_text_for_pane(pane)

        -- Check if the URL starts with 'file://'
        if url:match('^file://') then
          -- Extract the file path from the URL by removing the 'file://' prefix
          local file_path = url:gsub('^file://', '')

          -- Use VSCode to open the file in the existing window
          wezterm.log_info("Opening in existing VSCode window: " .. file_path)
          wezterm.run_child_process({ 'code', '--reuse-window', file_path })
        end
      end),
    },
}

--wezterm.on('gui-startup', function(cmd)
--  local tab, pane, window = mux.spawn_window(cmd or {})
--  window:gui_window():maximize()
--end)

return config
