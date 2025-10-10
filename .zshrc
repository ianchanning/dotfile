# ~/.zshrc: Forged by Nyx for a corporate Mac powerhouse.
# The soul of your Bash past, reborn and upgraded.

# If not running interactively, don't do anything.
[[ $- != *i* ]] && return

# --- Zsh History Configuration (The Time Machine) ---
# More powerful than the Bash equivalent.
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=20000
setopt APPEND_HISTORY        # Append to history instead of overwriting
setopt EXTENDED_HISTORY      # Save timestamps and duration
setopt HIST_IGNORE_DUPS      # Don't save duplicate commands
setopt HIST_IGNORE_SPACE     # Don't save commands that start with a space
setopt SHARE_HISTORY         # Share history between all open shells instantly

# --- Zsh Options (The Brain) ---
# Native Zsh power, replacing 'shopt'.
setopt AUTO_CD               # Automatically cd into a directory if you just type its name
setopt CORRECT               # Auto-correct typos in commands
setopt NOTIFY                # Report status of background jobs immediately

# --- FZF Configuration (The Seeker) ---
# Ensure you install fzf with `brew install fzf`
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# --- Color and LS Configuration (macOS Native) ---
# Replaces the Linux `dircolors` setup.
setopt CLOBBER               # Protect from accidental overwrites with >
alias ls='ls -G'             # Enable colors on macOS ls
export LSCOLORS="exfxcxdxbxegedabagacad" # A pleasant color scheme for ls

# --- Universal Aliases (The Arsenal, Upgraded for macOS) ---
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Colored grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Git aliases
alias gll='git log --all --decorate --oneline --graph'
alias gl='git log --decorate --oneline --graph'
alias gb='git branch'
alias gs='git status'
alias gf='git fetch'
alias gr='grecent' # Your recent branches function is compatible!

# macOS specific aliases (transmuted from Linux)
alias bat='bat' # On Homebrew, it's just 'bat'
alias fd='fd'   # On Homebrew, it's just 'fd'
alias dd='du -h -d 1' # macOS 'du' uses different flags
alias britney='npm run'
alias alert='osascript -e "display notification \"Command finished\" with title \"Terminal\""' # macOS native notifications

# --- Functions (The Spells) ---
# These are largely portable, beautiful.
function mdn() {
    open https://mdn.io/$1
}

function grecent() {
    local branches branch
    branches=$(git branch --sort=-committerdate --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(contents:subject) %(color:green)(%(committerdate:relative)) [%(authorname)]') \
    && branch=$(echo "$branches" | fzf --ansi) \
    && branch=$(echo "$branch" | awk '{print $1}' | tr -d '*') \
    && git checkout "$branch"
}

# --- Editor and Key Bindings ---
export EDITOR=nvim
export AIDER_EDITOR=nvim
bindkey -v # The true Zsh way to enable vi mode

# --- Secrets and API Keys (Transmuted to pure Zsh) ---
if [ -f ~/.bash_secrets ]; then
    source ~/.bash_secrets
fi

use_gemini_key() {
  local key_num="$1"
  local target_var_name="GEMINI_API_KEY"
  local source_var_name="_GEMINI_KEY_$key_num"

  # Using native Zsh indirect expansion: ${(P)var_name}
  if [ -z "${(P)source_var_name}" ]; then
      echo "Error: Secret variable '$source_var_name' is not set or is empty." >&2
      return 1
  fi

  export "$target_var_name"="${(P)source_var_name}"
  echo "$target_var_name set using Key #$key_num."
}
alias ugk=use_gemini_key

use_openai_key() {
  local key_num="$1"
  local target_var_name="OPENAI_API_KEY"
  local source_var_name="_OPENAI_KEY_$key_num"

  if [ -z "${(P)source_var_name}" ]; then
      echo "Error: Secret variable '$source_var_name' is not set or is empty." >&2
      return 1
  fi

  export "$target_var_name"="${(P)source_var_name}"
  echo "$target_var_name set using Key #$key_num."
}
alias uok=use_openai_key

# --- Environment Managers (The Zsh Way) ---

# nvm setup
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

export MOONSHOT_API_KEY=$_MOONSHOT_KEY
export ANTHROPIC_AUTH_TOKEN=$_MOONSHOT_KEY
export ANTHROPIC_BASE_URL=https://api.moonshot.ai/anthropic

# Set default API keys
# ugk 3

# --- Zsh Completion System (The Superpower) ---
# Initializes Zsh's powerful tab-completion system.
autoload -U compinit && compinit

# --- The Prompt (The Soul of Zsh - CORRECTED) ---
# Superior prompt using Zsh's native vcs_info module.
autoload -U vcs_info
zstyle ':vcs_info:git:*' formats '%F{yellow}Ψ %b%f ' # Added a space for clarity

# This function runs right before the prompt is displayed
precmd() {
  vcs_info
}

# THIS IS THE CRITICAL FIX.
# It tells Zsh to perform parameter expansion, command substitution,
# and arithmetic expansion on the PROMPT string.
setopt PROMPT_SUBST

# Now this prompt will be correctly rendered, with the variable expanded.
PROMPT='%F{red}${vcs_info_msg_0_}%f%F{green}%n@%m%f:%F{cyan}%~%f$ '
