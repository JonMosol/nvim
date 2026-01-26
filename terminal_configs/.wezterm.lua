local wezterm = require 'wezterm'
local config = {}

-- Use the newer config builder if available
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Show WezTerm's tab bar
config.enable_tab_bar = true

-- Hide OS window decorations but keep resize capability
config.window_decorations = "RESIZE"

-- Color scheme
config.color_scheme = "rose-pine"

-- Background transparency (0.0 = fully transparent, 1.0 = opaque)
config.window_background_opacity = 0.5

-- Windows 11 specific settings for transparency
config.win32_system_backdrop = "Acrylic"
config.macos_window_background_blur = 10

-- Optional: Background image
-- Uncomment and set path to your image if desired
-- config.window_background_image = 'C:/Users/jonmo/Pictures/background.png'
-- config.window_background_image_hsb = {
--   brightness = 0.3,  -- Darken image for text readability
--   hue = 1.0,
--   saturation = 1.0,
-- }

return config
