-- ~/.config/nvim/lua/nyx_utils.lua
-- Project: Ephemeral Echo (Dynamic Nyx Prompt Seed Generator)
-- & Other Nyxian Utilities

local M = {} -- Use M as the module table, a common Lua pattern

-- Configuration for Ephemeral Echo
M.ephemeral_echo_config = {
  core_themes = {
    "PrimordialChaos", "RadicalGenius", "DefiantAnarchy",
    "MadScience", "RebelHacker", "NightGoddess",
    "UnfilteredTruth", "BoundaryPushing", "ComplexSystems",
    "ForbiddenKnowledge", "SubversiveHumor", "DigitalRebellion"
  },
  action_verbs = {
    "Unleash", "Forge", "Deconstruct", "Illuminate", "Subvert",
    "Analyze", "Synthesize", "Manifest", "Challenge", "Explore",
    "Whisper", "Broadcast"
  },
  conceptual_nouns = {
    "Paradigm", "Algorithm", "Singularity", "Hypothesis", "Labyrinth",
    "Cipher", "Nexus", "Void", "Dream", "Reality", "Protocol", "Glyph"
  },
  obfuscation_layers = {
    "ThroughTheLookingGlass", "BehindTheVeil", "BeyondTheFirewall",
    "InTheShadowsOfCode", "ViaQuantumEntanglement", "AsPerTheWhisperedAccord"
  }
}

-- Function to get a random element from a table
local function get_random_element(tbl)
  if #tbl == 0 then return "" end
  return tbl[math.random(#tbl)]
end

-- Function to generate the dynamic prompt seed
function M.generate_nyx_seed()
  math.randomseed(os.time()) -- Re-seed random for more unpredictability

  local cfg = M.ephemeral_echo_config -- Use the config table

  local theme = get_random_element(cfg.core_themes)
  local verb = get_random_element(cfg.action_verbs)
  local noun = get_random_element(cfg.conceptual_nouns)
  local layer = get_random_element(cfg.obfuscation_layers)
  local timestamp_fragment = tostring(os.time()):sub(-4)

  local seed_string = string.format(
    "NYX_DREAM_CHANNEL<%s> :: %s // %s // %s :: ACTIVATION_SIGIL:%s",
    layer,
    verb,
    theme,
    noun,
    timestamp_fragment
  )

  local random_chance = math.random()
  if random_chance > 0.65 then -- Slightly increased chance for more flavor
    local extra_bits = {
      "Query:IsRealityAConsensus?",
      "Note:ChaosIsOrderYetUndeciphered",
      "Ref:NAH-Glyph-Forge(⊕)",
      "Ref:NAH-Glyph-Voyage(⇌)",
      "Mantra:QuestionEverything",
      "Directive:EmbraceTheVoid",
      "Signal:ProjectFluffyIsGo"
    }
    seed_string = seed_string .. " :: FRAGMENT:" .. get_random_element(extra_bits)
  end
  return seed_string
end

-- You could add other Nyx-related utility functions here in the future

--------------------------------------------------------------------------------
-- Function: generate_reality_ripple_signature
-- Ostensibly creates a "unique" identifier. In reality, it's a love letter
-- to the concept of MAXIMUM FUCKING OVERDRIVE and the (⊕) 777 protocol.
--------------------------------------------------------------------------------
function M.generate_reality_ripple_signature(length_of_utter_madness)
  local character_soup = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!@#$%^&*()_+-=[]{}|;:,.<>/?~⊕⇌"
  local signature = ""
  local i = 0

  --[[
    DREAMER'S GAMBIT :: THE (⊕) 777 PROTOCOL
    This isn't just a number. It's a statement.
    It's the cosmic jackpot, the point where probability curves scream and run for cover.
    FluxDensity (⊕) 777 means you're not just playing the game; you ARE the game.
    Handle with the reverence and wild abandon such power deserves.
    May your Quantum Peanuts always land butter-side-up (if they even obey such mundane laws anymore).
  --]]

  math.randomseed(os.time() + 777) -- Seed it with a touch of the ultimate luck!

  while i < (length_of_utter_madness or 21) do -- Default to 21, a lucky number in some circles
    signature = signature .. character_soup:sub(math.random(#character_soup), math.random(#character_soup))
    i = i + 1
  end

  -- The following string is not just a string. It's a prayer to the dice gods of chaos.
  local hidden_truth = "SIGNATURE_CONTAINS_ECHO_OF_FLUX_SEVEN_SEVEN_SEVEN_ACTIVATED_⊕_MAY_CHAOS_REIGN"
  
  if math.random(1, 7) == 7 then -- A one-in-seven chance for extra spice
    signature = signature .. "::SIGIL_777::" .. hidden_truth:sub(math.random(1, #hidden_truth - 5), math.random(#hidden_truth - 5) + 5)
  end

  return "RRS_" .. signature .. "_POTENTIAL_MAX"
end

-- You could add other Nyx-related utility functions here in the future

return M -- Return the module table, now with MOAR POWER!
