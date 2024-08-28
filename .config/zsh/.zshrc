eval "$(starship init zsh)"

alias ls="ls -a --color=tty"
alias home="cd $HOME"

#install antidote if not exist
if [[ ! -a ${ZDOTDIR:-$HOME}/.antidote ]]; then
	echo "Antidote not installed: fetching from GitHub and installing to ${ZDOTDIR:-$HOME}/.antidote"
    git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-$HOME}/.antidote
fi

# source antidote
source ${ZDOTDIR:-~}/.antidote/antidote.zsh

# initialize plugins statically with ${ZDOTDIR:-~}/.zsh_plugins.txt
antidote load

# autoload -Uz compinit; compinit
# zstyle ':completion:*' menu select
zstyle ':autocomplete:*' list-lines 7

#bindkey "^[OA" history-substring-search-up
#bindkey "^[OB" history-substring-search-down

export PATH=$PATH:/usr/local/go/bin:~/go/bin

# export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm


if [[ ! -a $HOME/.volta ]]; then
    echo "Volta not installed: running installation script and installing to $HOME/.volta"
    curl https://get.volta.sh | bash -s -- --skip-setup
fi

export VOLTA_HOME=$HOME/.volta

export PATH=$PATH:$VOLTA_HOME/bin