# 重複させない
typeset -U PATH

# 補完関係
[[ -d /usr/local/share/zsh/site-functions ]] && fpath=(/usr/local/share/zsh/site-functions $fpath)
fpath=($HOME/.zsh/zsh-completions/src $fpath)
autoload -Uz compinit && compinit

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

# $colors[red]とか書けるようになる
autoload -Uz colors && colors

# 履歴関係
setopt hist_ignore_all_dups
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt share_history
setopt correct
setopt list_packed
setopt noautoremoveslash
setopt complete_aliases

setopt auto_cd
alias ..='cd ../'
alias ...='cd ../../'

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

# alias
alias vi=vim

alias -g C="| pbcopy"
alias -g L="| less -R"
alias -g T="| tail -f"

## ls
alias ls='ls --color=auto -aF'
alias ll="ls -lh"

alias pgrep="pgrep -fl"

export LANG=ja_JP.UTF-8
export TERM=xterm-256color

# もしかして:
SPROMPT="correct: %R -> %r ? "

export PATH=~/bin:$PATH
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# Homebrew
if [ -x /usr/local/bin/brew ]; then
  export PATH=/usr/local/bin:$PATH
  if [ -d /usr/local/sbin ]; then
    export PATH=/usr/local/sbin:$PATH
  fi
fi

# Macでもgnu coreutils使う
case ${OSTYPE} in
  darwin*)
    if [ -d $(brew --prefix coreutils)/libexec/gnubin ]; then
      export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
      export MANPATH="$(brew --prefix coreutils)/libexec/gnuman:$MANPATH"
    fi
esac

# dircolors
eval `dircolors ~/.zsh/dircolors-solarized/dircolors.256dark`
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

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

# knu/z - https://github.com/knu/z
autoload -Uz is-at-least
[[ -s ~/.zsh/z/z.sh ]] && source ~/.zsh/z/z.sh

# tmux
if [ -n "$TMUX" ]; then
  export TERM=screen-256color
  function ssh_tmux() {
    tmux new-window -n $@ "exec ssh $@"
  }
  alias ssh=ssh_tmux
fi

# npm
type npm > /dev/null 2>&1 && source <(npm completion)

# なんとかenv系
## rbenv
if [ -d ~/.rbenv/ ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
  source ~/.rbenv/completions/rbenv.zsh
  function gem(){
    $HOME/.rbenv/shims/gem $*
    if [ "$1" = "install" ] || [ "$1" = "i" ] || [ "$1" = "uninstall" ] || [ "$1" = "uni" ]
    then
      rbenv rehash
      rehash
    fi
  }
fi

## ndenv
if [ -d ~/.ndenv/ ]; then
  export PATH="$HOME/.ndenv/bin:$PATH"
  eval "$(ndenv init -)"
  source ~/.ndenv/completions/ndenv.zsh
  function npm() {
    $HOME/.ndenv/shims/npm $*
    if [ "$1" = "install" ] || [ "$1" = "i" ] || [ "$1" = "uninstall" ] || [ "$1" = "uni" ]
    then
      ndenv rehash
      rehash
    fi
  }
fi

## plenv
if [ -d ~/.plenv/ ]; then
  export PATH="$HOME/.plenv/bin:$PATH"
  eval "$(plenv init -)"
  source ~/.plenv/completions/plenv.zsh
  function cpanm() {
    $HOME/.plenv/shims/cpanm $*
    if [ true ]
    then
      plenv rehash
      rehash
    fi
  }
fi

# sindresorhus/pure (Pretty, minimal and fast ZSH prompt) - https://github.com/sindresorhus/pure
# ln -s ~/dotfiles/.zsh/pure/pure.zsh /usr/local/share/zsh/site-functions/prompt_pure_setup
autoload -U promptinit && promptinit
prompt pure

# MacVim KaoriYa - http://codesource.google.com/p/macvim-kaoriya/
case ${OSTYPE} in
  darwin*)
    alias vim="/Applications/MacVim.app/Contents/MacOS/mvim --remote-tab-silent"
esac

# marzocchi/zsh-notify - https://github.com/marzocchi/zsh-notify
source ~/.zsh/zsh-notify/notify.plugin.zsh
