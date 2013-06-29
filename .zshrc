# 補完関係
fpath=($HOME/.zsh/functions $fpath)
[[ -d /usr/local/share/zsh/site-functions ]] && fpath=(/usr/local/share/zsh/site-functions $fpath)
autoload -Uz compinit
compinit

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'


# $colors[red]とか書けるようになる
autoload -Uz colors
colors

# 履歴関係
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt hist_ignore_dups     # 履歴を重複させない
setopt share_history        # share command history data
setopt auto_cd              # cd無くてもcdする
setopt correct
setopt list_packed
setopt noautoremoveslash
setopt complete_aliases

# =のあともパス名保管する
setopt magic_equal_subst

# historyを上書きではなく追記する
setopt append_history

# 単語の区切り文字を指定する (C-wでディレクトリ一つだけ削除できるように)
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

# 賢く履歴を辿る
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# color
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:pi=01;33:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors 'di=01;34' 'ln=01;35' 'so=01;32' 'ex=01;31' 'bd=46;34' 'cd=43;34'

# alias
alias vi=vim
alias screen="screen -xRU"

alias -g C="| pbcopy"
alias -g L="| less -R"
alias -g T="| tail -f"

case "${OSTYPE}" in
  cygwin*)
    alias open="cygstart"
;;
esac

# ls
case "${OSTYPE}" in
  freebsd*|darwin*)
    alias ls="ls -G -aF"
  ;;
  cygwin|linux*)
    alias ls="ls --color -aF"
  ;;
esac
alias ll="ls -lh"

function psx { ps aux| head -1 && ps aux | grep -i $1 | sed -e '/grep/d' };

# Homebrew
if [ -x /usr/local/bin/brew ]; then
  export PATH=/usr/local/bin:$PATH
fi

export LANG=ja_JP.UTF-8
export SCREENDIR=~/.screen
export TERM=xterm-256color

# ターミナルのタイトルを設定する
case "${TERM}" in
  kterm*|xterm*)
    precmd() {
      echo -ne "\033]0;${HOST%%.*}:${PWD}\007"
    }
  ;;
esac

# バージョン管理システムの情報を表示する
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats '[%b]'
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () {
  psvar=()
  LANG=en_US.UTF-8 vcs_info
  [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

PROMPT="
%{${fg[blue]}%}[%~]%{${reset_color}%}
%n$ "
RPROMPT="%1(v|%F{green}%1v%f|)"

SPROMPT="correct: %R -> %r ? "

# C-rをpercolの使った奴にする
function exists { which $1 &> /dev/null }
if exists percol; then
    function percol_select_history() {
        local tac
        exists gtac && tac="gtac" || { exists tac && tac="tac" || { tac="tail -r" } }
        BUFFER=$(history -n 1 | eval $tac | percol --query "$LBUFFER")
        CURSOR=$#BUFFER         # move cursor
        zle -R -c               # refresh
    }

    zle -N percol_select_history
    bindkey '^R' percol_select_history
fi

# knu-z
[[ -s ~/external/z/z.sh ]] && source ~/external/z/z.sh

# tmux
if [ -n "$TMUX" ]; then
  export TERM=screen-256color
  function ssh_tmux() {
    tmux new-window -n $@ "exec ssh $@"
  }
  alias ssh=ssh_tmux
fi

# rbenv
if [ -d ~/.rbenv/ ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
  function gem(){
    $HOME/.rbenv/shims/gem $*
    if [ "$1" = "install" ] || [ "$1" = "i" ] || [ "$1" = "uninstall" ] || [ "$1" = "uni" ]
    then
      rbenv rehash
      rehash
    fi
  }
fi

# Nodebrew
[[ -d ~/.nodebrew/ ]] && export PATH=$HOME/.nodebrew/current/bin:$PATH

export PATH=~/bin:$PATH

[ -f ~/.zshrc.local ] && source ~/.zshrc.local
