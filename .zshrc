# Created by newuser for 4.3.2
fpath=($HOME/.zsh/functions $fpath)
[[ -d /usr/local/share/zsh/site-functions ]] && fpath=(/usr/local/share/zsh/site-functions $fpath)
autoload -Uz compinit; compinit

# $colors[red]とか書けるようになる
autoload -Uz colors; colors

# 履歴関係
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt hist_ignore_dups     # 履歴を重複させない
setopt share_history        # share command history data
setopt auto_cd              # cd無くてもcdする
setopt auto_pushd           # popdすれば前のディレクトリに戻れるようになる
setopt correct
setopt list_packed
setopt noautoremoveslash
setopt complete_aliases

# =のあともパス名保管する
setopt magic_equal_subst

# historyを上書きではなく追記する
setopt append_history

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
case "${OSTYPE}" in
  darwin*)
    export PATH=/usr/local/bin:$PATH
  ;;
esac

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

# autojump
[[ -s ~/.autojump/etc/profile.d/autojump.zsh ]] && source ~/.autojump/etc/profile.d/autojump.zsh # for OS X
[[ -s /usr/share/autojump/autojump.sh ]] && source /usr/share/autojump/autojump.sh  # for Ubuntu

# tmux
[ -n "$TMUX" ] && export TERM=screen-256color

# auto-fu.zsh
# if [ -f ~/dotfiles/.zsh/auto-fu.zsh/auto-fu.zsh ]; then
# source ~/dotfiles/.zsh/auto-fu.zsh/auto-fu.zsh
#     function zle-line-init () {
#         auto-fu-init
#     }
#     zle -N zle-line-init
#     zstyle ':completion:*' completer _oldlist _complete
# fi

export PATH=~/bin:$PATH

[ -f ~/.zshrc.local ] && source ~/.zshrc.local
