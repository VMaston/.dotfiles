# Homebrew, appended after system paths so brew does not override system binaries.
if [[ -d /home/linuxbrew/.linuxbrew && $- == *i* ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv | grep -Ev '\bPATH=')"
  HOMEBREW_PREFIX="${HOMEBREW_PREFIX:-/home/linuxbrew/.linuxbrew}"
  export PATH="${PATH}:${HOMEBREW_PREFIX}/bin:${HOMEBREW_PREFIX}/sbin"
fi

# Install a Homebrew formula if missing.
ensure_brew_pkg() {
  local formula="$1"

  if ! command -v brew >/dev/null 2>&1; then
    echo "Homebrew is not available; cannot install ${formula}."
    return 1
  fi

  if ! brew list --formula "$formula" >/dev/null 2>&1; then
    echo "${formula} not installed: installing with Homebrew..."
    brew install "$formula"
  fi
}

# Required shell tools
ensure_brew_pkg zsh
ensure_brew_pkg starship
ensure_brew_pkg antidote

# Starship prompt
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

# Aliases
alias ls="ls --color=tty"
alias home="cd $HOME"

# Antidote
ANTIDOTE_PATH="${HOMEBREW_PREFIX:-$(brew --prefix 2>/dev/null)}/opt/antidote/share/antidote/antidote.zsh"

if [[ -r "$ANTIDOTE_PATH" ]]; then
  source "$ANTIDOTE_PATH"
  antidote load
else
  echo "Antidote not found at: $ANTIDOTE_PATH"
fi

# ---- completions ----

# Extra completion files
fpath=(
  /usr/share/zsh/site-functions
  "$ZDOTDIR/completions"
  $fpath
)

autoload -Uz compinit
compinit

# Completion menu
zstyle ':completion:*' menu select

# Case-insensitive matching
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Nice descriptions, but not too much noise
zstyle ':completion:*:descriptions' format '%F{yellow}%d%f'
zstyle ':completion:*:warnings' format '%F{red}no matches%f'

# At command position, don't show aliases/parameters
zstyle ':completion:*:-command-:*' tag-order \
  'external-commands' \
  'builtins' \
  'functions'

# ---- history ----

setopt append_history        # Append new history to the history file instead of overwriting it
setopt inc_append_history    # Write each command to the history file immediately after it runs
setopt share_history         # Share history between all running Zsh sessions
setopt extended_history      # Save timestamps and command durations in the history file

setopt hist_ignore_dups      # Don’t record a command if it is the same as the previous command
setopt hist_find_no_dups     # Don’t show duplicate commands while searching or navigating history
setopt hist_reduce_blanks    # Remove extra whitespace from commands before saving them
setopt hist_ignore_space     # Don’t save commands that start with a space
setopt hist_verify           # Show expanded history commands before running them

# ---- quality of life ----

setopt interactive_comments  # Allow comments in interactive shell commands

# ---- keybindings ----

# Normal arrows
bindkey '^[[A' up-line-or-history
bindkey '^[[B' down-line-or-history
bindkey '^[OA' up-line-or-history
bindkey '^[OB' down-line-or-history

# Alt-Up / Alt-Down variants
bindkey '^[^[[A' history-substring-search-up
bindkey '^[^[[B' history-substring-search-down
bindkey '^[[1;3A' history-substring-search-up
bindkey '^[[1;3B' history-substring-search-down

# Tab completion
bindkey '^I' expand-or-complete
