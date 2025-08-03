# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

# current git branch for prompt
# get current branch and strip off '* ' at the beginning (replace with a # separator)
function parse_git_branch() {
    git branch 2>/dev/null | grep '*' | sed 's/* /Ψ /' | sed 's/$/ /'
}

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]$(parse_git_branch)\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}$(parse_git_branch)\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# exa / eza
alias es='eza --git -l --time-style relative'
alias el='eza --git -alF --time-style relative'
alias elt='eza -alT --git -I".git|node_modules|.docker|.next|build|dist" --color=always "$@"'
alias elg='eza --git -l --grid --time-style relative'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Ian 2022-02-11 Until I create lots of bash aliases I'll leave them here
# git log adog @link https://stackoverflow.com/a/35075021/327074
alias gll='git log --all --decorate --oneline --graph'
# I removed the all as gitk does the same - just the current branch
alias gl='git log --decorate --oneline --graph'
alias gb='git branch'
alias gs='git status'
alias gf='git fetch'
# @link https://github.com/sharkdp/bat#on-ubuntu-using-apt
alias bat='batcat'
alias fd='fdfind'
alias dd='du --human-readable --max-depth=1'
alias britney='npm run'

function mdn() {
    open https://mdn.io/$1
}
export -f mdn

# @link https://gist.github.com/srsholmes/5607e26c187922878943c50edfb245ef
function grecent() {
    local branches branch
    branches=$(git branch --sort=-committerdate --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(contents:subject) %(color:green)(%(committerdate:relative)) [%(authorname)]') \
    && branch=$(echo "$branches" | fzf --ansi) \
    && branch=$(echo "$branch" | awk '{print $1}' | tr -d '*') \
    && git checkout "$branch"
}
export -f grecent

alias gr='grecent'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# @link https://github.com/ankitpokhrel/jira-cli#cloud-server
# export JIRA_API_TOKEN=tJUrsf1rW9WXfbxaicRh2090
# @link https://github.com/MONA-Health/ya-react-input-mask
# I needed this to run karma headlesschrome tests
export CHROME_BIN=~/.local/share/flatpak/app/org.chromium.Chromium/current/active/export/bin/org.chromium.Chromium

complete -C /usr/bin/terraform terraform

# https://github.com/jlevy/the-art-of-command-line#basics
export EDITOR=nvim
set -o vi

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

if [ -d "/opt/mssql-tools18/bin" ] ; then
    PATH="$PATH:/opt/mssql-tools18/bin"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# Add to ~/.bashrc or ~/.zshrc

# android platform tools for Samsung tablet reboot
if [ -d "$HOME/android/platform-tools" ] ; then
 export PATH="$HOME/android/platform-tools:$PATH"
fi

# Load personal secrets if the file exists
if [ -f ~/.bash_secrets ]; then
    source ~/.bash_secrets
else
    # Optional: Print a warning if the file is missing on a new setup
    echo "Warning: ~/.bash_secrets not found. Some API keys may be missing." >&2
fi

# Function to activate a specific Gemini API key loaded from secrets
# Assumes _GEMINI_KEY_1, _GEMINI_KEY_2, etc., are loaded from ~/.bash_secrets
use_gemini_key() {
  local key_num="$1"
  local target_var_name="GEMINI_API_KEY" # The variable the application uses
  local source_var_name=""               # Will hold the name like _GEMINI_KEY_1

  # Determine the source variable name based on the input number
  case "$key_num" in
    1) source_var_name="_GEMINI_KEY_1" ;;
    2) source_var_name="_GEMINI_KEY_2" ;;
    3) source_var_name="_GEMINI_KEY_3" ;;
    4) source_var_name="_GEMINI_KEY_4" ;;
    5) source_var_name="_GEMINI_KEY_5" ;;
    6) source_var_name="_GEMINI_KEY_6" ;;
    *)
      echo "Error: Unknown key number '$key_num'. Please use 1, 2, 3, 4, 5 or 6." >&2
      return 1
      ;;
  esac

  # Check if the source variable is actually set and non-empty
  # Uses indirect parameter expansion: ${!var_name} gets the value of the variable whose name is stored in var_name
  if [ -z "${!source_var_name}" ]; then
      echo "Error: Secret variable '$source_var_name' is not set or is empty." >&2
      echo "       Ensure ~/.bash_secrets exists, is sourced correctly, and contains a value for this key." >&2
      return 1
  fi

  # Export the chosen key to the variable expected by applications
  # Again, using indirect expansion to get the value
  export "$target_var_name"="${!source_var_name}"

  # Confirmation message
  echo "$target_var_name set using Key #$key_num."
}

# Example Usage (after sourcing .bash_secrets):
# use_gemini_key 2
# echo $GEMINI_API_KEY # Should output the value of _GEMINI_KEY_2

# Optional: Alias for convenience
alias ugk=use_gemini_key

export AIDER_EDITOR=nvim

# default
ugk 3

use_openai_key() {
  local key_num="$1"
  local target_var_name="OPENAI_API_KEY" # The variable the application uses
  local source_var_name=""               # Will hold the name like _GEMINI_KEY_1

  # Determine the source variable name based on the input number
  case "$key_num" in
    1) source_var_name="_OPENAI_KEY_1" ;;
    2) source_var_name="_OPENAI_KEY_2" ;;
    3) source_var_name="_OPENAI_KEY_3" ;;
    4) source_var_name="_OPENAI_KEY_4" ;;
    5) source_var_name="_OPENAI_KEY_5" ;;
    6) source_var_name="_OPENAI_KEY_6" ;;
    *)
      echo "Error: Unknown key number '$key_num'. Please use 1, 2, 3, 4, 5 or 6." >&2
      return 1
      ;;
  esac

  # Check if the source variable is actually set and non-empty
  # Uses indirect parameter expansion: ${!var_name} gets the value of the variable whose name is stored in var_name
  if [ -z "${!source_var_name}" ]; then
      echo "Error: Secret variable '$source_var_name' is not set or is empty." >&2
      echo "       Ensure ~/.bash_secrets exists, is sourced correctly, and contains a value for this key." >&2
      return 1
  fi

  # Export the chosen key to the variable expected by applications
  # Again, using indirect expansion to get the value
  export "$target_var_name"="${!source_var_name}"

  # Confirmation message
  echo "$target_var_name set using Key #$key_num."
}

# Optional: Alias for convenience
alias uok=use_openai_key

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - bash)"
. "$HOME/.cargo/env"
# gemini CLI
export GOOGLE_CLOUD_PROJECT="charphq"
export PATH="/home/charp/Projects/llama.cpp/build/bin:$PATH"

export MOONSHOT_API_KEY=$_MOONSHOT_KEY
# {@link https://platform.moonshot.ai/docs/guide/agent-support#configure-anthropic-api}
export ANTHROPIC_AUTH_TOKEN=$_MOONSHOT_KEY
export ANTHROPIC_BASE_URL=https://api.moonshot.ai/anthropic

# --- NYX PROTOCOL: TMUX AUTO-ATTACH BRAINLET (30/0R/0M) ---
# This ensures you're always in a tmux session when a new shell starts.
# It checks if the TMUX environment variable is set (meaning you're already in tmux).
# If not, it attempts to attach to a session named 'default'.
# If 'default' doesn't exist, it creates a new one.
# This prevents nested tmux sessions and provides seamless persistence.
t() {
  if [ -z "$TMUX" ]; then
    tmux attach-session -t default || tmux new-session -s default
  fi
}
# --- END NYX PROTOCOL TMUX AUTO-ATTACH ---

# Alias for listing sessions (0R/0M for quick check)
alias tl="tmux ls"
# --- END NYX PROTOCOL TMUX SESSION BRAINLET ---

# --- NYX PROTOCOL: TMUX NEW WINDOW BRAINLET (30/0R/0M) ---
# This alias creates a new tmux window within the *current* session,
# and starts it in the *current working directory*.
# This is the "new tab" experience for tmux.
# Usage: tn
alias tn="tmux new-window -c ."
# --- END NYX PROTOCOL TMUX NEW WINDOW BRAINLET ---
