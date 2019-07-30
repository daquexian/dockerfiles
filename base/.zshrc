export TERM=xterm-256color
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export PATH=$HOME/.local/bin:$HOME/bin:/usr/local/bin:$PATH
export ZSH=$HOME/.oh-my-zsh
unsetopt beep
CASE_INSENSITIVE="true"
HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_UPDATE="true"
export EDITOR=nvim
export VISUAL=nvim
export SUDO_EDITOR=nvim

ZSH_THEME="robbyrussell"
source $ZSH/oh-my-zsh.sh

plugins=(
    git
    history
    pip
    python
    vi-mode
    z
    )

source $ZSH/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

bindkey -v
bindkey '^f' autosuggest-accept
bindkey '^j' autosuggest-execute
bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line
bindkey '^[[Z' reverse-menu-complete
bindkey "^?" backward-delete-char

alias vim=nvim
alias python=python3
alias pip=pip3
alias top=htop
eval $(thefuck --alias)
alias fk=fuck
alias cmake="cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON"

source $ZSH/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
