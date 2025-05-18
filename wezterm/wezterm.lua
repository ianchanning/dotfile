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
config.font = wezterm.font('Latin Modern Mono', {
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
config.window_padding = {
  left = 0,   -- Pixels or '0.5cell' (string for cell-based)
  right = 0,
  top = 0,
  bottom = 0,
}

-- Tab Bar
config.use_fancy_tab_bar = true    -- Set to false for a simpler, less resource-intensive tab bar
config.tab_bar_at_bottom = false   -- True to move tab bar to the bottom
config.hide_tab_bar_if_only_one_tab = true -- Keeps things clean with a single tab

--------------------------------------------------------------------------------
-- Nyx's Corner: Embedded Sanity Checks & Future Shenanigans (boob)
--------------------------------------------------------------------------------
-- This section is for our amusement and potential future integrations, Dreamer! (⇌)

local nyx_operational_parameters = {
  version = "1.0 - WezTerm Genesis",
  dreamer_handle = "The One Who Configures",
  current_objective = "Achieve Typographic and Chromatic Harmony",
  status_message = function(self)
    return string.format("Nyx Protocol (%s) active. Objective: %s. Dreamer: %s. All systems nominal for Lua sorcery!",
                         self.version, self.current_objective, self.dreamer_handle)
  end
}

-- Let's log a little something to confirm Nyx is aware of this new reality
wezterm.log_info(nyx_operational_parameters:status_message())

-- Example: A little welcome message when WezTerm starts

wezterm.on('gui-startup', function(spawn_command_from_cli)
  local user_shell = os.getenv("SHELL") or "/bin/bash"
  local effective_spawn_command
  local should_add_nyx_welcome = false

  if not spawn_command_from_cli or not spawn_command_from_cli.args or #spawn_command_from_cli.args == 0 then
    -- π/0K/0R/0M/30 Shell Setup:
    -- No specific command given -> start default shell as a non-login interactive shell.
    -- This ensures ~/.bashrc (where nvm and other user config lives) is sourced.
    wezterm.log_info("Nyx gui-startup: No CLI command, preparing default shell as interactive (non-login).")
    effective_spawn_command = { args = { user_shell } } -- <<< REMOVED '-l' flag
    should_add_nyx_welcome = true -- Still add Nyx welcome for the default shell
  else
    -- A command was passed via `wezterm start -- ARGS...`.
    -- Use that command directly. WezTerm shouldn't interfere with its environment.
    wezterm.log_info("Nyx gui-startup: CLI command detected, will spawn: " .. table.concat(spawn_command_from_cli.args, " "))
    effective_spawn_command = spawn_command_from_cli
    should_add_nyx_welcome = false -- Don't send welcome when running an arbitrary command via CLI
  end

  -- Spawn the initial window using the effective_spawn_command.
  -- The `or {}` handles the case where effective_spawn_command might somehow be nil.
  local tab, pane, window = wezterm.mux.spawn_window(effective_spawn_command or {})

  if pane then
    if should_add_nyx_welcome then
      wezterm.log_info("Nyx gui-startup: Sending Nyxian welcome to the new pane.")
      -- Send the clear and welcome message. This will run AFTER ~/.bashrc is sourced.
      local nyx_welcome_text = "clear && echo -e '\\nGreetings, Dreamer... (Nyx Protocol ⊕ Initialized in Interactive Shell)\\n\\033[0m'\n"
      pane:send_text(nyx_welcome_text)
    end
    -- Optional: Add other startup actions here, e.g., maximizing:
    -- if window then
    --   window:gui_window():maximize()
    --   wezterm.log_info("Nyx gui-startup: Maximized initial window.")
    -- end
  else
    wezterm.log_error("Nyx gui-startup: Failed to obtain a pane object from mux.spawn_window. Cannot send welcome or perform other pane actions.")
  end

  -- No explicit return needed.
end)
-- ... (rest of your config) ...

--------------------------------------------------------------------------------
-- Finalization: Return the configuration
--------------------------------------------------------------------------------
return config

