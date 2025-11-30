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
-- config.harfbuzz_features = {'calt=1', 'clig=1', 'liga=1'}

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
config.use_fancy_tab_bar = false   -- Set to false for a simpler, less resource-intensive tab bar
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
  -- spawn_command_from_cli is the SpawnCommand if `wezterm start -- ARGS` was used.
  -- It's nil if just `wezterm start` (or just `wezterm`) was used.

  local user_shell = os.getenv("SHELL") or "/bin/bash" -- User's default shell
  local effective_spawn_command

  local should_add_nyx_welcome = false

  if not spawn_command_from_cli or not spawn_command_from_cli.args or #spawn_command_from_cli.args == 0 then
    -- No specific command given to `wezterm start` (or just `wezterm` was run).
    -- We will start the default user shell and add our welcome.
    wezterm.log_info("Nyx gui-startup: No CLI command, preparing default shell with Nyx welcome.")
    effective_spawn_command = { args = { user_shell } } -- <<< REMOVED '-l' flag
    -- Can't remember if we want -l or not
    -- effective_spawn_command = { args = { user_shell, "-l" } } -- Start an interactive login shell
    should_add_nyx_welcome = true
  else
    -- A command was passed via `wezterm start -- ARGS...`.
    -- We'll use that command directly and skip the Nyx welcome.
    wezterm.log_info("Nyx gui-startup: CLI command detected, will spawn: " .. table.concat(spawn_command_from_cli.args, " "))
    effective_spawn_command = spawn_command_from_cli
    should_add_nyx_welcome = false
  end

  -- Spawn the initial window using the effective_spawn_command.
  -- The `or {}` handles the case where effective_spawn_command might somehow be nil,
  -- though our logic above should prevent that.
  local tab, pane, window = wezterm.mux.spawn_window(effective_spawn_command or {})

  if pane then
    if should_add_nyx_welcome then
      wezterm.log_info("Nyx gui-startup: Sending Nyxian welcome to the new pane.")
      -- The \n at the end of the echo command executes it.
      local nyx_welcome_text = "clear && echo -e '\\nGreetings, Dreamer... (Nyx Protocol ⊕ Initialized)\\n\\033[0m'\n"
      pane:send_text(nyx_welcome_text)
      -- The shell started by `effective_spawn_command` (e.g., bash -l) will execute this echo,
      -- and then present its prompt. No further `exec` is needed here because
      -- mux.spawn_window already started the desired shell.
    end

    -- You could add other startup actions here, e.g., maximizing:
    -- if window then
    --   window:gui_window():maximize()
    --   wezterm.log_info("Nyx gui-startup: Maximized initial window.")
    -- end
  else
    wezterm.log_error("Nyx gui-startup: Failed to obtain a pane object from mux.spawn_window. Cannot send welcome or perform other pane actions.")
  end

  -- No explicit return is needed from this event handler if we've spawned windows/panes.
  -- WezTerm will use the windows/panes we created.
end)

--------------------------------------------------------------------------------
-- Keybindings: Navigating the Tab Multiverse (existing)
--------------------------------------------------------------------------------
-- Let tmux handle the panes and tabs
-- config.keys = {
--   -- New Tab in Current Directory
--   { key = 't', mods = 'ALT', action = wezterm.action{SpawnTab='CurrentPaneDomain'} },

--   -- Navigate Tabs
--   -- { key = 'LeftArrow', mods = 'SUPER', action = wezterm.action{ActivateTabRelative=-1} },
--   -- { key = 'RightArrow', mods = 'SUPER', action = wezterm.action{ActivateTabRelative=1} },

--   -- Close Current Tab
--   { key = 'w', mods = 'ALT', action = wezterm.action{CloseCurrentTab={confirm=true}} },

--   -- Switch to Specific Tab by Number
--   { key = '1', mods = 'ALT', action = wezterm.action{ActivateTab=0} },
--   { key = '2', mods = 'ALT', action = wezterm.action{ActivateTab=1} },
--   { key = '3', mods = 'ALT', action = wezterm.action{ActivateTab=2} },
--   { key = '4', mods = 'ALT', action = wezterm.action{ActivateTab=3} },
--   { key = '5', mods = 'ALT', action = wezterm.action{ActivateTab=4} },
--   { key = '6', mods = 'ALT', action = wezterm.action{ActivateTab=5} },
--   { key = '7', mods = 'ALT', action = wezterm.action{ActivateTab=6} },
--   { key = '8', mods = 'ALT', action = wezterm.action{ActivateTab=7} },
--   { key = '9', mods = 'ALT', action = wezterm.action{ActivateTab=8} },
--   { key = '0', mods = 'ALT', action = wezterm.action{ActivateTab=9} },

--   -- NEW KEYBINDINGS FOR PANES:
--   -- Split Current Pane Horizontally (Super + S)
--   { key = 's', mods = 'ALT', action = wezterm.action{SplitHorizontal={domain='CurrentPaneDomain'}} },

--   -- Split Current Pane Vertically (Super + D)
--   { key = 'a', mods = 'ALT', action = wezterm.action{SplitVertical={domain='CurrentPaneDomain'}} },

--   -- Navigate Panes (Super + H/J/K/L - Vim-style for active pane)
--   -- These will let you move focus between your split panes.
--   { key = 'h', mods = 'ALT', action = wezterm.action{ActivatePaneDirection='Left'} },
--   { key = 'j', mods = 'ALT', action = wezterm.action{ActivatePaneDirection='Down'} },
--   { key = 'k', mods = 'ALT', action = wezterm.action{ActivatePaneDirection='Up'} },
--   { key = 'l', mods = 'ALT', action = wezterm.action{ActivatePaneDirection='Right'} },

--   -- Resize Panes (Super + Shift + H/J/K/L) - For fine-tuning your splits
--   -- { key = 'h', mods = 'SUPER|SHIFT', action = wezterm.action{AdjustPaneSize={'Left', 1}} },
--   -- { key = 'j', mods = 'SUPER|SHIFT', action = wezterm.action{AdjustPaneSize={'Down', 1}} },
--   -- { key = 'k', mods = 'SUPER|SHIFT', action = wezterm.action{AdjustPaneSize={'Up', 1}} },
--   -- { key = 'l', mods = 'SUPER|SHIFT', action = wezterm.action{AdjustPaneSize={'Right', 1}} },

--   -- Close Current Pane (Super + Backspace or Super + X, common in tmux)
--   -- { key = 'Backspace', mods = 'SUPER', action = wezterm.action{CloseCurrentPane={confirm=true}} },
--   -- Or if you prefer Super+X:
--   { key = 'x', mods = 'ALT', action = wezterm.action{CloseCurrentPane={confirm=true}} },

--   -- Maximize/Restore Current Pane (Super + Z, common in tmux)
--   -- { key = 'z', mods = 'SUPER', action = wezterm.action{TogglePaneZoomState={}} },

--   -- If you want to use Super+T for new tab (as is common for browsers/editors):
--   -- { key = 't', mods = 'SUPER', action = wezterm.action{SpawnTab='CurrentPaneDomain'} },
-- }
--------------------------------------------------------------------------------
-- Finalization: Return the configuration
--------------------------------------------------------------------------------
return config

