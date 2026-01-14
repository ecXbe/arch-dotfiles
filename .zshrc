clear && nitchrevived
eval "$(starship init zsh)"
[[ -o interactive ]] || return

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY SHARE_HISTORY INC_APPEND_HISTORY HIST_IGNORE_DUPS

autoload -Uz compinit
compinit -u

alias lsd='eza --icons'
alias pacup='sudo pacman -Rns $(pacman -Qdtq)'
alias fonts='fc-list -f "%{family}\n"'
alias Docs="cd ~/Documents && nvim"
alias Settings="cd ~/.config/hypr && nvim"
alias untar="tar -xf"
alias n="nvim"

setopt autocd
setopt correct

source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

#PROMPT='[%n@%m %1~]$ '
