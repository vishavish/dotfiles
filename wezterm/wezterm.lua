local wezterm = require("wezterm")
local act = wezterm.action

local config = {}
if wezterm.config_builder then config = wezterm.config_builder() end

config.color_scheme = "carbonfox"
config.font = wezterm.font_with_fallback({

  { family = "JetBrains Mono",  scale = 0.9 },
})

config.window_background_opacity = 1.0
config.window_decorations = "RESIZE"
config.window_close_confirmation = "AlwaysPrompt"
config.scrollback_lines = 3000
config.default_workspace = "home"

-- Dim inactive panes
config.inactive_pane_hsb = {
  saturation = 0.24,
  brightness = 0.5
}

-- Keys
config.leader = { key = "w", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
  { key = "w", mods = "LEADER", action = act.SendKey { key = "w", mods = "CTRL" } },
  { key = "c", mods = "LEADER", action = act.ActivateCopyMode },

  -- Pane keybindings
  { key = "-", mods = "LEADER", action = act.SplitVertical { domain = "CurrentPaneDomain" } },
  { key = "=", mods = "LEADER", action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },
  { key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
  { key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
  { key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
  { key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
  { key = "q", mods = "LEADER", action = act.CloseCurrentPane { confirm = true } },
  { key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
  { key = "s", mods = "LEADER", action = act.RotatePanes "Clockwise" },

  -- Resize
  { key = "r", mods = "LEADER", action = act.ActivateKeyTable { name = "resize_pane", one_shot = false } },

  -- Tab keybindings
  { key = "n", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
  { key = "[", mods = "LEADER", action = act.ActivateTabRelative(-1) },
  { key = "]", mods = "LEADER", action = act.ActivateTabRelative(1) },
  { key = "t", mods = "LEADER", action = act.ShowTabNavigator },
  { key = "m", mods = "LEADER", action = act.ActivateKeyTable { name = "move_tab", one_shot = false } },

  -- workspace
  { key = "x", mods = "LEADER",       action = act.ShowLauncherArgs { flags = "FUZZY|WORKSPACES" } },
}

for i = 1, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = "LEADER",
    action = act.ActivateTab(i - 1)
  })
end

config.key_tables = {
  resize_pane = {
    { key = "h",      action = act.AdjustPaneSize { "Left", 1 } },
    { key = "j",      action = act.AdjustPaneSize { "Down", 1 } },
    { key = "k",      action = act.AdjustPaneSize { "Up", 1 } },
    { key = "l",      action = act.AdjustPaneSize { "Right", 1 } },
    { key = "Escape", action = "PopKeyTable" },
    { key = "Enter",  action = "PopKeyTable" },
  },
  move_tab = {
    { key = "h",      action = act.MoveTabRelative(-1) },
    { key = "j",      action = act.MoveTabRelative(-1) },
    { key = "k",      action = act.MoveTabRelative(1) },
    { key = "l",      action = act.MoveTabRelative(1) },
    { key = "Escape", action = "PopKeyTable" },
    { key = "Enter",  action = "PopKeyTable" },
  }
}

config.use_fancy_tab_bar = false
config.status_update_interval = 500

wezterm.on("update-right-status", function(window, pane)
  local stat = window:active_workspace() or "Default"
  local stat_color = "#ffffff"
  local home_dir = wezterm.home_dir .. '/'
  local cwd = ''
  local hostname = ''
  
  -- if window:active_key_table() then
  --   stat = window:active_key_table()
  --   stat_color = "#BE95FF"
  -- end

  if window:leader_is_active() then
    stat_color = "#BE95FF"
  end

  local cwd_uri = pane:get_current_working_dir()
  local username = os.getenv('USER') or os.getenv('LOGNAME') or os.getenv('USERNAME')

  if type(cwd_uri) == 'userdata' then
    cwd = cwd_uri.file_path
  else
      -- an older version of wezterm, 20230712-072601-f4abf8fd or earlier,
      -- which doesn't have the Url object
      cwd_uri = cwd_uri:sub(8)
      local slash = cwd_uri:find '/'
      if slash then
        hostname = cwd_uri:sub(1, slash - 1)
        -- and extract the cwd from the uri, decoding %-encoding
        cwd = cwd_uri:sub(slash):gsub('%%(%x%x)', function(hex)
          return string.char(tonumber(hex, 16))
        end)
      end
  end

  if cwd == home_dir then
    cwd = "home"
  else
    cwd = string.gsub(cwd, "^" .. home_dir, "")
  end

  window:set_right_status(wezterm.format {
    { Foreground = { Color = stat_color } },
    { Text = username },
    { Text = " | " },
    { Text = cwd },
  })
end)

wezterm.on('format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local background = '#282828'
    local foreground = '#808080'
    local pane = tab.active_pane
    local process_name = pane.foreground_process_name or "Shell"

    process_name = string.match(process_name, "([^/\\]+)$") or process_name

    if tab.is_active then
      background = '#161616'
      foreground = '#c0c0c0'
    end

    process_name = wezterm.truncate_right(process_name, max_width - 2)

    return {
      { Text = "   " .. process_name .. "   "},
      { Background = { Color = background } },
      { Foreground = { Color = foreground } },
    }
  end
)

return config
