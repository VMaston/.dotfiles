eval "$(starship init zsh)"

alias ls="ls -a --color=tty"
alias home="cd $HOME"

# source antidote
source ${ZDOTDIR:-~}/.antidote/antidote.zsh

# initialize plugins statically with ${ZDOTDIR:-~}/.zsh_plugins.txt
antidote load

# autoload -Uz compinit; compinit
# zstyle ':completion:*' menu select
zstyle ':autocomplete:*' list-lines 7

#bindkey "^[OA" history-substring-search-up
#bindkey "^[OB" history-substring-search-down

export PATH=$PATH:/usr/local/go/bin
export GOPATH=/usr/local/go/

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm