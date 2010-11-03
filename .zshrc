# Created by newuser for 4.3.2
autoload -U compinit; compinit

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

#historyを上書きではなく追記する
setopt append_history

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# color
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:pi=01;33:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors 'di=01;34' 'ln=01;35' 'so=01;32' 'ex=01;31' 'bd=46;34' 'cd=43;34'

#alias
case "${OSTYPE}" in
freebsd*|darwin*)
alias ls="ls -G -w"
;;
cygwin|linux*)
alias ls="ls --color -Fa"
;;
esac
alias ll="ls -lF"

alias L="| less -R"

alias h="history -20"

function psx {
ps aux| head -1 && ps aux | grep $1 | sed -e '/grep/d'
};

#MacPorts
case "${OSTYPE}" in
darwin*)
    export PATH=/opt/local/bin:/opt/local/sbin/:$PATH
    export MANPATH=/opt/local/man:$MANPATH
;;
esac

export LANG=ja_JP.UTF-8
export SCREENDIR=~/.screen
export TERM=xterm-256color

#ターミナルのタイトルを設定する
case "${TERM}" in
kterm*|xterm*)
    precmd() {
        echo -ne "\033]0;${HOST%%.*}:${PWD}\007"
    }
    ;;
esac 
