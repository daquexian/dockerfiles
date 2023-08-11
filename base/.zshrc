export TERM=xterm-256color
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
    # vi-mode
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
alias top=htop
alias fk=fuck

source $ZSH/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(hub alias -s zsh)"

function upload {
    url=`curl https://oshi.at -F f=@$1 | tail -1 | sed 's/DL: //'`
    echo "url: $url"
    # copy to attached terminal using the yank(1) script:
    # https://github.com/sunaku/home/blob/master/bin/yank
    echo $url | yank
}

function dl {
    DEST=${2:-Downloads}
    source ~/.dlrc
    scp -P $DL_PORT $1 daquexian@localhost:$DEST
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias py='python3'

