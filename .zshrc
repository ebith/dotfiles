# Created by newuser for 4.3.2
autoload -U compinit
compinit
PROMPT="%n$ "
RPROMPT="[%~]"
SPROMPT="correct: %R -> %r ? "
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data
setopt auto_cd
setopt auto_pushd
setopt correct
setopt list_packed
setopt noautoremoveslash
setopt complete_aliases
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# color
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

#alias
alias ls="ls -F --color=tty"
alias ll="ls -lF --color=tty"
alias la="ls -aF --color=tty"
alias lx="ls -alF --color=tty"

alias du="du -h"
alias df="df -h"

alias untar="tar xvfz"
alias untars="find ./ -name "*tar.gz" | xargs -n1 tar xzvf"

alias gitc="git commit -am"
alias gitp="git push origin master"

function psx {
ps aux| head -1 && ps aux | grep $1 | sed -e '/grep/d'
};

#for server
#export LANG=C
