-- ~/.config/wezterm/wezterm.lua

-- Pull in the WezTerm API
local wezterm = require 'wezterm'

-- Initialize the configuration object
local config = {}
if type(wezterm.config_builder) == 'function' then
  config = wezterm.config_builder()
else
  -- For older WezTerm versions, you might directly assign to wezterm.target_config
  -- but the above is the modern approach. If this script is the entry point,
  -- config will be implicitly returned.
end

--------------------------------------------------------------------------------
-- Core Aesthetics: Font & Color Scheme
--------------------------------------------------------------------------------

-- Font Configuration: Latin Modern Mono at 11pt
-- We'll try a common name first. If it doesn't work, we might need to
-- use `wezterm ls-fonts --text "Latin Modern Mono"` to find the exact name
-- WezTerm sees.
config.font = wezterm.font('LMMono10', {
  weight = 'Regular', -- Common weights: 'Regular', 'Bold', 'Light', 'Medium'
  -- stretch = 'Normal', -- Common stretches: 'Normal', 'Condensed', 'Expanded'
  -- style = 'Normal'    -- Common styles: 'Normal', 'Italic', 'Oblique'
})
config.font_size = 16.0

-- Enable ligatures if Latin Modern Mono has them and you desire them
-- (Many mono fonts don't have extensive ligatures beyond basics like fi, fl)
-- You can comment this out if you don't want/need them or if the font doesn't support them well.
config.harfbuzz_features = {'calt=1', 'clig=1', 'liga=1'}

-- Color Scheme: Catppuccin Latte
config.color_scheme = 'Catppuccin Latte'
-- For a list of built-in schemes: https://wezfurlong.org/wezterm/colorschemes/index.html
-- Other Catppuccin variants available: 'Catppuccin Mocha', 'Catppuccin Macchiato', 'Catppuccin Frappe'

--------------------------------------------------------------------------------
-- Cursor & Window Preferences (Sensible Defaults & Customizations)
--------------------------------------------------------------------------------

-- Cursor Style
config.default_cursor_style = 'SteadyBlock'
config.cursor_blink_rate = 500      -- Milliseconds for one blink cycle (on + off). 0 to disable.

-- Scrollback Buffer
config.scrollback_lines = 30000 -- A generous amount of history

-- Window Decorations & Padding
config.window_decorations = "RESIZE" -- "FULL" (OS native), "NONE", "RESIZE" (minimal)
-- config.window_padding = {
--   left = 0,   -- Pixels or '0.5cell' (string for cell-based)
--   right = 0,
--   top = 0,
--   bottom = 0,
-- }

-- Tab Bar
config.use_fancy_tab_bar = true    -- Set to false for a simpler, less resource-intensive tab bar
config.tab_bar_at_bottom = false   -- True to move tab bar to the bottom
config.hide_tab_bar_if_only_one_tab = true -- Keeps things clean with a single tab

--------------------------------------------------------------------------------
-- Finalization: Return the configuration
--------------------------------------------------------------------------------
return config

