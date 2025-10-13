-- ~/.config/nvim/init.lua

-- ... (Keep Bootstrap lazy.nvim section) ...
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ... (Keep Core Neovim Settings section) ...
-- General
vim.g.mapleader = ','
vim.opt.history = 5000
vim.opt.encoding = 'utf-8'
vim.opt.number = true
-- Appearance / UI
vim.opt.termguicolors = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 300
-- Text / Tabs / Indent
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
-- Files / Backup / Swap
-- vim.opt.swapfile = false
-- Diff
vim.opt.diffopt:append('iwhite')
-- Spelling
vim.opt.spell = true
vim.opt.spelllang = {'en_gb'}
-- Set Node path for CoC
-- Find the nvm-managed node executable and set it for Neovim
local nvm_node_path = vim.fn.trim(vim.fn.system('bash -c "source ~/.nvm/nvm.sh && which node"'))
-- Check if the command was successful and the path exists
if vim.v.shell_error == 0 and vim.fn.executable(nvm_node_path) == 1 then
  -- This is the general variable for the node host provider, used by many plugins
  vim.g.node_host_prog = nvm_node_path
  -- You might also need to set it for specific plugins if they don't respect the host provider.
  -- For example, for coc.nvim you would uncomment the following line:
  vim.g.coc_node_path = nvm_node_path
end
      
--[[ ======================================================================
     Plugin Setup: lazy.nvim
     ====================================================================== ]]
require("lazy").setup({

  -- Core / Foundational
  { 'tpope/vim-sensible' },

  -- Colorschemes & Appearance
  { 'sonph/onehalf', rtp = 'vim/', name = 'onehalf' }, -- Keep installed, but don't activate
  -- { 'olimorris/onedarkpro.nvim', ... }, -- Still disabled
  -- { -- Disable TokyoNight for now
  --   "folke/tokyonight.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   opts = {},
  -- },

  -- ADD Catppuccin <<< NEW LIGHT THEME
  {
    "catppuccin/nvim",
    lazy = false, -- Load during startup
    name = "catppuccin", -- Optional explicit name
    priority = 1000, -- Load early
    config = function()
      require("catppuccin").setup({
        flavour = "latte", -- Use the light variant
        -- Add other Catppuccin options here if desired, e.g.:
        -- transparent_background = true,
        -- term_colors = true,
        integrations = {
        --   cmp = true,
        --   gitsigns = true,
        --   nvimtree = true,
          treesitter = true,
        --   notify = true,
        --   mini = true,
        --   -- Add other integrations as needed
        }
      })
    end,
  },

  -- Lualine Statusline
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          -- Theme should ideally follow Catppuccin automatically now
          theme = 'auto', -- Or explicitly 'catppuccin' if 'auto' fails
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
          -- ... other lualine options ...
          disabled_filetypes = { statusline = {}, winbar = {} },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = false,
          refresh = { statusline = 1000, tabline = 1000, winbar = 1000, }
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {'filename'},
          lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'}
        },
        inactive_sections = {
          lualine_a = {}, lualine_b = {}, lualine_c = {'filename'},
          lualine_x = {'location'}, lualine_y = {}, lualine_z = {}
        },
        tabline = {}, winbar = {}, inactive_winbar = {}, extensions = {}
      }
    end,
  },
  { 'nvim-tree/nvim-web-devicons' }, -- Dependency for Lualine icons

  -- ... (Keep all other plugins: Utility, Git, File/Session, DB, FZF, LSP, Treesitter, Aider) ...
  { 'tpope/vim-surround' },
  { 'tpope/vim-unimpaired' },
  { 'tpope/vim-repeat' },
  { 'tpope/vim-commentary' },
  { 'tpope/vim-fugitive' },
  { 'idanarye/vim-merginal' },
  { 'ldelossa/litee.nvim', config = function() require('litee.lib').setup() end },
  { 'ldelossa/gh.nvim', dependencies = { 'ldelossa/litee.nvim' }, config = function() require('litee.gh').setup() end },
  { 'tpope/vim-obsession' },
  { 'tpope/vim-vinegar' },
  { 'tpope/vim-dadbod' },
  { 'junegunn/fzf', build = function() vim.fn['fzf#install']() end },
  {
    'junegunn/fzf.vim',
    dependencies = { 'junegunn/fzf' },
    config = function()
      -- Initialize the config dictionary if it doesn't exist
      if vim.g.fzf_vim == nil then
        vim.g.fzf_vim = {}
      end

      -- *** THIS IS THE KEY LINE ***
      -- Add a prefix to all fzf.vim commands to avoid conflicts
      vim.g.fzf_vim.command_prefix = 'Fzf' -- Choose 'Fzf' or any other prefix you like

      -- Your existing fzf.vim settings (like layout) can go here too
      vim.g.fzf_layout = { ['up'] = '~50%' }

      -- Optional: You could define mappings for the *new* prefixed commands here if desired
      local map = vim.keymap.set
      map('n', '<leader>ff', ':FzfFiles<CR>', { noremap=true, silent=true, desc="FZF: Files" })
      map('n', '<leader>fg', ':FzfGFiles<CR>', { noremap=true, silent=true, desc="FZF: Git Files" })
      map('n', '<leader>fb', ':FzfBuffers<CR>', { noremap=true, silent=true, desc="FZF: Buffers" })
      map('n', '<leader>fr', ':FzfRg<CR>', { noremap=true, silent=true, desc="FZF: Ripgrep Search" }) -- Note the new command!
    end
  },

  -- Now, you can safely add vim-ripgrep (or use your custom function)
  -- because :Rg is no longer defined by fzf.vim
  {
    'jremmen/vim-ripgrep',
    cmd = "Rg", -- Load when :Rg is called
    -- Optional keymap for the *real* :Rg (from vim-ripgrep)
    keys = {
       { "<leader>rg", "<cmd>Rg<space>", desc = "Ripgrep Quickfix (vim-ripgrep)" },
     },
  },

  {
    'neoclide/coc.nvim',
    branch = 'release', -- Use the 'release' branch
    -- The 'init' function runs *BEFORE* lazy.nvim loads this plugin.
    -- This is the correct place to set global variables that plugins read early.
    init = function()
      -- π/0K/0R/0M/30 Node path setup for CoC
      -- Find the node executable in the inherited PATH using Neovim's built-in function.
      -- This automatically picks up nvm's node if nvm is configured in the shell starting nvim.
      local node_path = vim.fn.exepath('node')

      -- Set coc_node_path if an executable path was found.
      -- CoC will automatically check the version of Node at this path.
      -- If the version is too old (like v12), CoC will show a warning message.
      -- This warning is the signal that the 'node' found *first* in the PATH inherited by Neovim
      -- is not the required version.
      -- The fix for the old version is EXTERNAL: ensure the correct Node version's bin directory
      -- (e.g., from nvm, via `nvm use <version>` or correct shell init) is at the beginning
      -- of your shell's PATH *before* you launch nvim.
      if node_path and node_path ~= '' then
        vim.g.coc_node_path = node_path
        -- Optional debug notification (only if it was found)
        -- vim.notify("NYX: CoC Node path found dynamically: " .. node_path, vim.log.levels.DEBUG)
      else
        -- Optional warning if no 'node' executable was found anywhere in the inherited PATH.
        vim.notify("NYX: 'node' executable not found in PATH. CoC may not function correctly. Ensure Node.js is installed and in your shell's PATH.", vim.log.levels.WARN, { title = "CoC Node Missing " })
      end
    end,
    -- The 'config' function runs *AFTER* lazy.nvim has loaded this plugin.
    config = function()
      -- =========================================================================
      -- NYX'S DOCTRINE: The Declarative CoC Configuration
      -- =========================================================================

      -- Pillar 1: The Auto-Installer
      -- This is the manifest of required extensions. CoC will ensure these are
      -- always installed, checking on every startup. No more :CocInstall.
      vim.g.coc_global_extensions = {
        'coc-pyright',
        'coc-json',   -- You'll want this too, trust me.
        'coc-tsserver', -- For any future TypeScript/JavaScript work
        'coc-snippets'  -- If you use snippets
      }

      -- Pillar 2: The Injected Brain
      -- This Lua table is transmuted into the coc-settings.json in memory.
      -- No more separate JSON file to manage. It all lives here.
      vim.g.coc_config = {
        -- Tell CoC that for Python, "black" is the one true formatter.
        ['python.formatting.provider'] = 'black',

        -- The Rune of Automation: format these filetypes on save.
        ['coc.preferences.formatOnSaveFiletypes'] = {
          'python',
          'json',
          'javascript',
          'typescript'
        }
      }
      -- Place your existing CoC keymaps and other configuration here.
      -- These configurations depend on CoC being loaded, so they go in 'config'.
      vim.keymap.set('n', '<F12>', '<Plug>(coc-definition)', { silent = true, noremap = true })
      vim.keymap.set('n', '<F2>', '<Plug>(coc-rename)', { silent = true, noremap = true })
      local function check_backspace() local col = vim.fn.col('.') - 1; return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') end
      _G.coc_pum_confirm = function() if vim.fn.pumvisible() ~= 0 then return vim.fn['coc#pum#confirm']() else return vim.api.nvim_replace_termcodes("<CR>", true, false, true) end end
      vim.keymap.set('i', '<cr>', 'v:lua.coc_pum_confirm()', { expr = true, noremap = true })

      -- CoC notifications indicate successful setup (after init/load/config)
      -- vim.notify("NYX: CoC.nvim loaded and configured.", vim.log.levels.INFO, { title = "CoC Setup ⊕" })
    end
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate', -- Command to run after install/update
    config = function()
      require 'nvim-treesitter.configs'.setup {
        highlight = { enable = true },
        indent = { enable = true }, -- Optional: enable treesitter based indent

        -- Ensure parsers are installed for languages you use <<< ADD THIS
        ensure_installed = {
          "c",
          "lua", -- Make sure lua is listed!
          "vim",
          "vimdoc",
          "query", -- Treesitter's own query language, often useful
          "javascript",
          "typescript",
          "python",
          "bash",
          "html",
          "css",
          "json",
          "yaml",
          "markdown",
          "markdown_inline", -- Required for markdown code blocks highlighting
          -- Add other languages you frequently use (e.g., "rust", "go", "php", etc.)
        },

        -- Optional: Auto install parsers when entering a buffer for a new language
        auto_install = true, -- Set to true to automatically install missing parsers

        -- Optional: Sync parser installation (blocks startup until installed)
        -- sync_install = false, -- Set to true to block startup on installation
      }
    end
 
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      -- Optional: Load specific textobjects modules if needed
      -- require('nvim-treesitter.configs').setup { textobjects = { ... } }
      -- Often works well with defaults for Markdown
      -- print("NYX: Treesitter Textobjects ready for Markdown mayhem!")
    end
  },
  -- GitHub Copilot Core (REQUIRED by CopilotChat.nvim for auth/requests)
  -- ... (Keep github/copilot.vim as is, maybe add lazy=true or event='VeryLazy' too if desired) ...
  -- REMOVED - not using it, aider is good enough
  -- {
  --   "github/copilot.vim",
  --   -- cmd = "Copilot", -- Example: Load only when :Copilot command is used
  --   event = "VeryLazy", -- Or load after startup
  --   -- config = function() ... end -- Optional config for copilot.vim itself
  -- },

  -- -- AI Chat Interface (CopilotChat.nvim) - CONFIGURED FOR OLLAMA
  -- {
  --   "CopilotC-Nvim/CopilotChat.nvim",
  --   -- Load after startup, but config happens via lazy's config function
  --   event = "VeryLazy",
  --   dependencies = {
  --     -- REQUIRED: Keep the core Copilot plugin dependency
  --     { "github/copilot.vim" },
  --     -- REQUIRED: Plenary for async/utils
  --     { "nvim-lua/plenary.nvim" },
  --     -- Optional: For picker UI, e.g., telescope-ui-select or fzf-lua (add if you use them)
  --     -- { "nvim-telescope/telescope.nvim" }, -- Example if using Telescope
  --     -- { "ibhagwan/fzf-lua" }, -- Example if using fzf-lua
  --   },
  --   -- REMOVED: build = "make tiktoken", -- Not needed for basic functionality
  --   opts = {
  --     -- Provider Configuration: Tell it to use Ollama!
  --     provider = "ollama",
  --     providers = {
  --       ollama = {
  --         -- Ensure this URL matches your running Ollama instance
  --         url = "http://localhost:11434",
  --         -- *** IMPORTANT: Change 'llama3' to a model you have downloaded! ***
  --         -- Run `ollama list` in your terminal to see available models.
  --         model = "llama3", -- e.g., "mistral", "codellama:7b", etc.
  --         -- Optional: Specify format if needed (e.g., 'json' for some models)
  --         -- format = "json",
  --         -- Optional: Keep alive setting for the connection
  --         -- keep_alive = "5m",
  --         -- Add other Ollama-specific options here if needed.
  --         -- Check the plugin's documentation or "providers discussion page" for exact options.
  --       }
  --       -- We are disabling the default copilot provider implicitly by setting provider = "ollama"
  --       -- If you needed both, you might configure them here side-by-side and switch via commands/prompts.
  --     },

  --     -- General Options
  --     debug = true, -- ENABLE DEBUGGING INITIALLY! Check logs later.
  --     -- Keep your preferred window layout
  --     window = {
  --       layout = "vertical",
  --       width = 0.4,
  --       height = 0.9,
  --       border = "single", -- Example: Add a border
  --       title = "CopilotChat (Ollama)", -- Customize title
  --     },
  --     -- You can add other general opts from the README here if desired
  --     -- e.g., show_help = false, auto_insert_mode = true, etc.
  --   },
  --   config = function(_, opts)
  --     -- This function runs when lazy.nvim loads the plugin
  --     local ok, copilot_chat = pcall(require, "CopilotChat") -- Use "CopilotChat", not "copilot_chat"
  --     if not ok then
  --       vim.notify("Failed to require CopilotChat.nvim during config", vim.log.levels.ERROR)
  --       return
  --     end

  --     -- Setup the plugin using the 'opts' table defined above
  --     local setup_ok, setup_err = pcall(copilot_chat.setup, opts)
  --     if not setup_ok then
  --        vim.notify("CopilotChat.nvim setup failed: " .. tostring(setup_err), vim.log.levels.ERROR)
  --        return
  --     end

  --     -- Define keymaps *after* successful setup
  --     local map = vim.keymap.set
  --     local map_opts = { noremap = true, silent = true }

  --     -- Your existing keymaps - these should now work correctly
  --     map('n', '<leader>cc', ':CopilotChat<CR>', { noremap=true, silent=true, desc="CopilotChat: Open Chat Window" })
  --     map('v', '<leader>cc', '<Cmd>CopilotChat<CR>', { noremap=true, silent=true, desc="CopilotChat: Chat with Selection" })
  --     map('v', '<leader>cce', '<Cmd>CopilotChatExplain<CR>', { noremap=true, silent=true, desc="CopilotChat: Explain Code" })
  --     map('v', '<leader>ccf', '<Cmd>CopilotChatFix<CR>', { noremap=true, silent=true, desc="CopilotChat: Suggest Fix" })
  --     map('v', '<leader>cct', '<Cmd>CopilotChatTests<CR>', { noremap=true, silent=true, desc="CopilotChat: Generate Tests" })
  --     map('v', '<leader>ccd', '<Cmd>CopilotChatDocs<CR>', { noremap=true, silent=true, desc="CopilotChat: Generate Docs" })
  --     map('v', '<leader>ccr', '<Cmd>CopilotChatReview<CR>', { noremap=true, silent=true, desc="CopilotChat: Review Code" })
  --     map('n', '<leader>ccq', ':CopilotChatQuick<CR>', { noremap=true, silent=true, desc="CopilotChat: Quick Prompt" })
  --     map('n', '<leader>cctoggle', ':CopilotChatToggle<CR>', { noremap=true, silent=true, desc="CopilotChat: Toggle Window" })

  --     vim.notify("CopilotChat.nvim configured for Ollama!", vim.log.levels.INFO, { title = "Nyx Setup" })
  --     vim.notify("Nyx has resurrected the mappings! The fog on the config lifts... slightly.", vim.log.levels.INFO, { title = "Nyx Setup" })
  --   end,
  -- },

  -- ... (rest of your plugins) ...
 { 'joshuavial/aider.nvim', opts = { auto_manage_context = true, default_bindings = true, debug = false, }, },
 {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

}) -- End of lazy.setup

-- ... (Keep LSP & Diagnostics Configuration section) ...
vim.diagnostic.config({ virtual_text = true, signs = true, underline = true, update_in_insert = false, severity_sort = true, })
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do local hl = "DiagnosticSign" .. type; vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl }) end

-- ... (Keep Custom Functions section) ...
function SaveMarkdownWithSlugName()
  local first_line = vim.api.nvim_buf_get_lines(0, 0, 1, false)[1] or ""
  local title = first_line
  title = string.gsub(title, "%*+", "")        -- Remove asterisks
  title = string.gsub(title, "#+", "")         -- Remove hashtags
  title = string.gsub(title, "^%s+", "")       -- Trim leading whitespace
  title = string.gsub(title, "%s+$", "")       -- Trim trailing whitespace
  title = string.gsub(title, "[^%w%s-]", "")   -- Remove non-word, non-space, non-hyphen chars
  title = string.lower(title)                  -- Convert to lowercase
  title = string.gsub(title, "%s+", "-")       -- Replace spaces with hyphens
  title = string.gsub(title, "^-+", "")        -- Remove leading hyphens
  title = string.gsub(title, "-+$", "")        -- Remove trailing hyphens
  if title == "" then title = "untitled" end
  local current_buf_name = vim.api.nvim_buf_get_name(0)
  local dir
  if current_buf_name and current_buf_name ~= "" then dir = vim.fn.fnamemodify(current_buf_name, ':h') else dir = vim.fn.getcwd() end
  local base_filename = title .. ".md"
  local full_path = dir .. "/" .. base_filename
  local counter = 1
  while vim.fn.filereadable(full_path) == 1 do counter = counter + 1; base_filename = title .. "-" .. counter .. ".md"; full_path = dir .. "/" .. base_filename end
  vim.cmd('silent! write ' .. vim.fn.fnameescape(full_path))
  vim.cmd('file ' .. vim.fn.fnameescape(full_path))
  vim.notify("Saved as: " .. base_filename, vim.log.levels.INFO)
end

function InsertDateTime()
    local date_time = os.date("%Y-%m-%d %H:%M")
    vim.api.nvim_put({date_time}, 'c', true, true)
end

-- Create a key mapping to call the function
vim.api.nvim_set_keymap('n', '<leader>d', ':lua InsertDateTime()<CR>', { noremap = true, silent = true })

function ToggleMarkdownCheckbox()
  local line = vim.api.nvim_get_current_line()
  local new_line
  if string.match(line, "%- %[ %] ") then
    new_line = string.gsub(line, "%- %[ %] ", "- [x] ", 1)
  elseif string.match(line, "%- %[x%] ") then
    new_line = string.gsub(line, "%- %[x%] ", "- [ ] ", 1)
  else
    -- Maybe notify user or do nothing if no checkbox found
    -- print("NYX: No Markdown checkbox found on this line.")
    return
  end
  if new_line and new_line ~= line then
    vim.api.nvim_set_current_line(new_line)
  end
end

-- ... (Keep Key Mappings section) ...
local map = vim.keymap.set
local opts = { noremap = true, silent = true }
map('n', '<leader>;', 'A;<esc>', opts)
map('n', '<leader>bb', ':buffers<CR>:b<space>', opts)
map('n', '<c-p>', ':buffers<CR>:b<space>', opts)
map('n', '<leader>tt', ':tags<CR>', opts)
map('n', '[q', ':cprevious<CR>', opts); map('n', ']q', ':cnext<CR>', opts); map('n', '[Q', ':cfirst<CR>', opts); map('n', ']Q', ':clast<CR>', opts)
map('n', '[l', ':lprevious<CR>', opts); map('n', ']l', ':lnext<CR>', opts); map('n', '[L', ':lfirst<CR>', opts); map('n', ']L', ':llast<CR>', opts)
map('n', '<leader>qo', ':copen<CR>', opts); map('n', '<leader>qc', ':cclose<CR>', opts); map('n', '<leader>lo', ':lopen<CR>', opts); map('n', '<leader>lc', ':lclose<CR>', opts)
map('t', '<leader><Esc>', '<C-\\><C-n>', opts)
map('n', '<leader>dt', ':windo diffthis<CR>', opts); map('n', '<leader>do', ':windo diffoff<CR>', opts)
map('n', '<leader><tab>', ':b#<CR>', opts); map('n', '<leader>s', ':w<CR>', opts)
map('n', '<leader>V', '"+P', opts); map('n', '<leader>v', '"+p', opts); map('n', '<leader>p', '"0p', opts); map('n', '<leader>P', '"0P', opts)
map('n', '<leader>gg', ':Git<CR>', opts); map('n', '<leader>gl', ':Git log --graph --oneline --decorate<CR>', opts); map('n', '<leader>gll', ':Git log --graph --abbrev-commit --decorate --date=relative<CR>', opts)
map('n', '<leader>sm', ':lua SaveMarkdownWithSlugName()<CR>', opts)
map('n', "<leader>'", "ysiw'", opts); map('n', '<leader>"', 'ysiw"', opts)

-- Resurrection of missing mappings from Vimscript

-- Define map and opts if not already in scope where you paste this
local map = vim.keymap.set
local opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true } -- For <expr> mappings
local silent_opts = { noremap = true, silent = true } -- Explicitly silent
local term_opts = { noremap = true, silent = true } -- For terminal mappings
local map_cmd_opts = { noremap = true, silent = false } -- For commands where output is desired (like :!)

-- Buffer Navigation (Tab / Shift-Tab)
map('n', '<Tab>', ':bnext<CR>', silent_opts)
map('n', '<S-Tab>', ':bprevious<CR>', silent_opts) -- S-Tab for Shift-Tab

-- Quickfix / Location / Preview List Toggles (vim-unimpaired style)
-- Note: Your Lua config already has <leader>qo, <leader>qc etc. These add the bracket versions.
map('n', '[q', ':cprevious<CR>', opts) -- Already present in your Lua! Keeping for completeness of the block.
map('n', ']q', ':cnext<CR>', opts)     -- Already present in your Lua!
map('n', '[l', ':lprevious<CR>', opts) -- Already present in your Lua!
map('n', ']l', ':lnext<CR>', opts)     -- Already present in your Lua!
-- The missing open/close mappings:
map('n', '[qq', ':cclose<CR>', opts)
map('n', ']qq', ':copen<CR>', opts)
map('n', '[ll', ':lclose<CR>', opts)
map('n', ']ll', ':lopen<CR>', opts)
map('n', '[pp', ':pclose<CR>', opts) -- Preview window close
map('n', ']pp', ':popen<CR>', opts)  -- Preview window open

-- Tag Stack Navigation
map('n', '[ts', ':pop<CR>', opts) -- Pop tag stack
map('n', ']ts', ':tag<CR>', opts) -- Jump to tag (opens tag stack)

-- Command Line Expansion (%% for current directory)
map('c', '%%', function()
  if vim.fn.getcmdtype() == ':' then
    return vim.fn.fnameescape(vim.fn.expand('%:h')) .. '/'
  else
    return '%%'
  end
end, expr_opts)

-- File Operations in Current Directory (using %%)
-- Note: These use 'map' which covers Normal, Visual, Op-pending. Lua needs explicit modes.
-- Mapping only in Normal mode ('n') is usually safest/intended for these commands.
map('n', '<leader>ew', ':e %%', opts)
map('n', '<leader>es', ':sp %%', opts)
map('n', '<leader>ev', ':vsp %%', opts)
map('n', '<leader>et', ':tabe %%', opts)

-- Alt + HJKL Window Navigation (Requires terminal support for Alt keys)
-- Normal Mode
map('n', '<A-h>', '<C-w>h', opts)
map('n', '<A-j>', '<C-w>j', opts)
map('n', '<A-k>', '<C-w>k', opts)
map('n', '<A-l>', '<C-w>l', opts)
-- Visual Mode
map('v', '<A-h>', '<C-\\><C-n><C-w>h', opts)
map('v', '<A-j>', '<C-\\><C-n><C-w>j', opts)
map('v', '<A-k>', '<C-\\><C-n><C-w>k', opts)
map('v', '<A-l>', '<C-\\><C-n><C-w>l', opts)
-- Insert Mode
map('i', '<A-h>', '<C-\\><C-n><C-w>h', opts)
map('i', '<A-j>', '<C-\\><C-n><C-w>j', opts)
map('i', '<A-k>', '<C-\\><C-n><C-w>k', opts)
map('i', '<A-l>', '<C-\\><C-n><C-w>l', opts)
-- Command Mode
map('c', '<A-h>', '<C-\\><C-n><C-w>h', opts)
map('c', '<A-j>', '<C-\\><C-n><C-w>j', opts)
map('c', '<A-k>', '<C-\\><C-n><C-w>k', opts)
map('c', '<A-l>', '<C-\\><C-n><C-w>l', opts)
-- Terminal Mode
map('t', '<A-h>', '<C-\\><C-n><C-w>h', term_opts)
map('t', '<A-j>', '<C-\\><C-n><C-w>j', term_opts)
map('t', '<A-k>', '<C-\\><C-n><C-w>k', term_opts)
map('t', '<A-l>', '<C-\\><C-n><C-w>l', term_opts)

-- Terminal Escape (Alternative - CAUTION!)
-- You already have map('t', '<leader><Esc>', '<C-\\><C-n>', opts)
-- Adding this might be useful but could interfere if <Esc> is needed *within* the terminal app.
-- map('t', '<Esc>', '<C-\\><C-n>', term_opts) -- Uncomment cautiously if needed

-- FZF MRU (Most Recently Used)
-- IMPORTANT: Your fzf.vim setup in Lua uses the command_prefix 'Fzf'.
-- Assuming you want the FZF MRU functionality, you likely need a plugin like
-- 'ibhagwan/fzf-lua' or ensure fzf.vim provides an MRU command under the prefix.
-- If using fzf.vim's potential MRU command (check its docs):
-- map('n', '<leader>m', ':FzfMru<CR>', opts) -- Replace :FzfMru with the actual prefixed command if it exists
-- Or if you install and configure fzf-lua:
-- map('n', '<leader>m', '<cmd>lua require("fzf-lua").mru()<CR>', opts) -- Example for fzf-lua

-- Grep/Search in Current Buffer
-- Uses <C-R>" to insert the contents of the default register (yanked word)
map('n', '<leader>gp', 'yiw<CR>:g/<C-R>"/p<CR>', opts)
map('n', '<leader>gr', 'yiw<CR>:lvimgrep <C-R>" %<CR>:lopen<CR>', opts)

-- vim.notify("Nyx has resurrected the mappings! The fog on the config lifts... slightly.", vim.log.levels.INFO, { title = "Nyx Setup" })

-- print("NYX: Forging Markdown, NAH, and Utility keymaps... ⊕")

-- Define map and opts ONCE for this logical block
local map = vim.keymap.set
local opts_n = { noremap = true, silent = true, desc = "" } -- Base opts for normal mode
-- local opts_i = { noremap = true, desc = "" } -- Base opts for insert mode (not needed here anymore)

-- === Markdown Structure Mappings ===
opts_n.desc = 'NYX: Add H1 (#) above'
map('n', '<leader>1', 'O# <Esc>', opts_n)
opts_n.desc = 'NYX: Add H2 (##) above'
map('n', '<leader>2', 'O## <Esc>', opts_n)
opts_n.desc = 'NYX: Add H3 (###) above'
map('n', '<leader>3', 'O### <Esc>', opts_n)
opts_n.desc = 'NYX: Add H4 (####) above'
map('n', '<leader>4', 'O#### <Esc>', opts_n)
opts_n.desc = 'NYX: Add H5 (#####) above'
map('n', '<leader>5', 'O##### <Esc>', opts_n)
opts_n.desc = 'NYX: Add H6 (######) above'
map('n', '<leader>6', 'O###### <Esc>', opts_n)
opts_n.desc = 'NYX: Add UL item (-) above'
map('n', '<leader>-', 'O- <Esc>', opts_n)
opts_n.desc = 'NYX: Add OL item (1.) above'
map('n', '<leader>.', 'O1. <Esc>', opts_n)
opts_n.desc = 'NYX: Add HR (---) above'
map('n', '<leader>hr', 'O---<Esc>', opts_n)

-- === Markdown Utility Mappings ===
opts_n.desc = 'NYX: Toggle Markdown checkbox'
map('n', '<leader>x', ':lua ToggleMarkdownCheckbox()<CR>', opts_n) -- MOVED HERE!

opts_n.desc = 'NYX: Toggle Markdown Preview'
map('n', '<leader>mp', ':MarkdownPreviewToggle<CR>', opts_n) -- MOVED HERE!

-- === NAH / Symbol Mappings ===
opts_n.desc = 'NYX: Insert NAH Forge ⊕ at cursor'
map('n', '<leader>0', 'i⊕<Esc>', opts_n)
opts_n.desc = 'NYX: Insert NAH Forge ⇌ at cursor'
map('n', '<leader>~', 'i⇌<Esc>', opts_n)

-- Insert mode abbreviation (defined globally is fine)
vim.cmd("iabbrev <buffer> ,0 ⊕") -- Keep this separate, it's not using map/opts_n
vim.cmd("iabbrev <buffer> ,~ ⇌") -- Keep this separate, it's not using map/opts_n

-- print("NYX: Markdown, NAH & Utility keymaps successfully forged! ⊕")

--[[ ======================================================================
     Autocommands
     ====================================================================== ]]
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Commentary filetype settings
local commentary_group = augroup('CommentarySettings', { clear = true })
-- ... (Keep commentary autocommands) ...
autocmd('FileType', { pattern = {'php', 'javascript', 'reason', 'rust'}, command = 'setlocal commentstring=//\\ %s', group = commentary_group, })
autocmd('FileType', { pattern = 'dosbatch', command = 'setlocal commentstring=rem\\ %s', group = commentary_group, })

-- Apply Colorscheme AFTER full initialization
local theming_group = augroup('ApplyThemeOnStartup', { clear = true })
autocmd('VimEnter', {
  pattern = '*',
  group = theming_group,
  callback = function()
    -- Set the colorscheme to Catppuccin <<< CHANGED
    -- The flavor (latte) is set in the plugin's config block
    local cs_ok, cs_err = pcall(vim.cmd.colorscheme, 'catppuccin')
    if not cs_ok then
      vim.notify("Failed to set colorscheme 'catppuccin' on VimEnter: " .. tostring(cs_err), vim.log.levels.ERROR)
      -- Fallback to default if Catppuccin fails
      pcall(vim.cmd.colorscheme, 'default')
    end
  end,
})

local markdown_format_group = vim.api.nvim_create_augroup('NyxMarkdownFormatting', { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  group = markdown_format_group,
  callback = function()
    vim.opt_local.shiftwidth = 4 -- Indentation width
    vim.opt_local.tabstop = 4    -- How many spaces a <Tab> counts for
    vim.opt_local.expandtab = true -- Use spaces, not actual tab characters
    -- Optional: Notify yourself that the settings applied
    -- vim.notify("NYX: Markdown set to 4 spaces locally!", vim.log.levels.INFO, { title = "Markdown FTW" })
  end,
  desc = "NYX: Set 4-space indentation for Markdown files",
})

-- Force a check for file changes when buffer is entered or vim gains focus
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  pattern = "*",
  command = "checktime",
})

--[[ ======================================================================
     Final Touches
     ====================================================================== ]]
vim.cmd('filetype plugin indent on')

-- vim.notify("Neovim Lua config loaded!", vim.log.levels.INFO, { title = "Nyx Setup" })

