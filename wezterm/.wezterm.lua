local wezterm = require("wezterm")

local config = wezterm.config_builder()

local is_windows = os.getenv("OS") and os.getenv("OS"):lower():find("windows")
local is_macos = wezterm.target_triple:lower():find("darwin") ~= nil

config.color_scheme = "rose-pine-moon"
config.max_fps = 120
config.font = wezterm.font("CaskaydiaCove NF", { weight = "Medium" })
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_frame = {
  font = wezterm.font("CaskaydiaCove NF", { weight = "DemiBold" }),
}
config.inactive_pane_hsb = {
  saturation = 0.0,
  brightness = 0.5,
}

config.default_cwd = "D:/"

-- Set default shell
if is_windows then
  config.default_prog = { "pwsh.exe", "-NoLogo" }
end

-- Add launch menu profiles
config.launch_menu = {
  {
    label = "PowerShell 7",
    args = { "pwsh.exe", "-NoLogo" },
  },
  {
    label = "WSL 2 (Ubuntu)",
    args = { "wsl.exe", "-d", "Ubuntu", "--cd", "~" },  -- Change to your distro name
  },
  {
    label = "CMD",
    args = { "cmd.exe" },
  },
}

if is_windows then
  config.win32_system_backdrop = "Acrylic"
  config.window_background_opacity = 0.7
  config.window_frame.font_size = 10.0
end

if is_macos then
  config.window_background_opacity = 0.8
  config.macos_window_background_blur = 50
  config.font_size = 15.0
  config.window_frame.font_size = 13.0
end

return config