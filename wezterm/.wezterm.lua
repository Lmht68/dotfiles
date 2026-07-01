local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- Platform detection
local is_windows = wezterm.target_triple:lower():find("windows") ~= nil
local is_macos = wezterm.target_triple:lower():find("darwin") ~= nil
local is_linux = wezterm.target_triple:lower():find("linux") ~= nil

-- GENERAL SETTINGS (All Platforms)
config.color_scheme = "Catppuccin Macchiato"
config.max_fps = 120
config.font = wezterm.font("CaskaydiaCove NF", { weight = "Medium" })
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_frame = {
	font = wezterm.font("CaskaydiaCove NF", { weight = "DemiBold" })
}
config.inactive_pane_hsb = {
  saturation = 0.0,
  brightness = 0.5,
}
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

-- DEFAULT SHELL
if is_windows then
  config.default_prog = { "pwsh.exe", "-NoLogo" }
  config.default_cwd = "D:/"
elseif is_macos then
  config.default_prog = { "/bin/zsh", "-l" }
  config.default_cwd = os.getenv("HOME") or "/Users"
elseif is_linux then
  config.default_prog = { "/usr/bin/zsh", "-l" }
  config.default_cwd = os.getenv("HOME") or "/home"
end

-- LAUNCH MENU
if is_windows then
  config.launch_menu = {
    {
      label = "PowerShell",
      args = { "pwsh.exe", "-NoLogo" },
    },
    {
      label = "WSL",
      args = { "wsl.exe", "-d", "Ubuntu", "--cd", "~" },
    },
    {
      label = "CMD",
      args = { "cmd.exe" },
    },
  }
elseif is_linux then
  config.launch_menu = {
    {
      label = "Zsh",
      args = { "/usr/bin/zsh", "-l" },
    },
    {
      label = "Bash",
      args = { "/bin/bash", "-l" },
    }
  }
end

-- TRANSPARENCY & APPEARANCE
if is_windows then
  config.win32_system_backdrop = "Acrylic"
  config.window_background_opacity = 0.75
  config.window_frame.font_size = 10.0
elseif is_macos then
  config.window_background_opacity = 0.9
  config.macos_window_background_blur = 50
  config.font_size = 14.0
  config.window_frame.font_size = 12.0
elseif is_linux then
  config.window_background_opacity = 0.9
  config.font_size = 14.0
  config.window_frame.font_size = 12.0
end

return config
