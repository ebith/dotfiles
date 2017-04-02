# $PATHを重複させない
typeset -U PATH

# 補完を有効にする
autoload -Uz compinit && compinit -C

########################################
# zplug
########################################
source ~/.zplug/init.zsh

zplug 'zsh-users/zsh-completions', depth:1
zplug 'zsh-users/zsh-history-substring-search'
zplug 'zsh-users/zsh-syntax-highlighting', defer:2

# zplug 'mollifier/anyframe'

zplug 'supercrabtree/k'

zplug 'mafredri/zsh-async'
zplug 'sindresorhus/pure', use:pure.zsh, as:theme

zplug 'b4b4r07/enhancd', use:init.sh

zplug 'm4i/cdd', use:cdd

zplug 'seebi/dircolors-solarized'

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# zplug load --verbose
zplug load
########################################
# plugin setting
########################################
# # seebi/dircolors-solarized
eval `dircolors $ZPLUG_HOME/repos/seebi/dircolors-solarized/dircolors.256dark`
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# m4i/cdd - https://github.com/m4i/cdd
chpwd() {
  _cdd_chpwd
}

# zsh-users/zsh-history-substring-search: ZSH port of Fish shell's history search feature. - https://github.com/zsh-users/zsh-history-substring-search
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down

#################### 未整理 ####################
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

# C-dでログアウトしない
setopt ignore_eof

# 履歴関係
setopt share_history
setopt hist_reduce_blanks
setopt hist_ignore_all_dups
setopt hist_ignore_space
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

# 賢く履歴を辿る
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

setopt correct
setopt list_packed
setopt noautoremoveslash
setopt complete_aliases

setopt auto_cd

setopt extended_glob
setopt nullglob

# =のあともパス名保管する
setopt magic_equal_subst

# historyを上書きではなく追記する
setopt append_history

# 単語の区切り文字を指定する (C-wでディレクトリ一つだけ削除できるように)
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

# alias
alias vi=vim

alias -g L="| less -R"
alias -g T="| tail -f"

alias ls='ls --color=auto -aF'
alias ll="ls -lh"

alias pgrep="pgrep -fl"

export LANG=ja_JP.UTF-8
export TERM=xterm-256color

SPROMPT="もしかして: %R -> %r ? "

# tmux
if [ -n "$TMUX" ]; then
  export TERM=screen-256color
  function ssh_tmux() {
    tmux new-window -n $@ "exec ssh $@"
  }
  alias ssh=ssh_tmux
fi

# npmの補完
type npm > /dev/null 2>&1 && source <(npm completion)

# MacVim KaoriYa - http://codesource.google.com/p/macvim-kaoriya/
case ${OSTYPE} in
  darwin*)
    alias vim="~/Applications/MacVim.app/Contents/bin/mvim --remote-tab-silent"
esac

# ssh port fowarding
function sshpf() {
  \ssh -fL $1\:localhost\:$1 sakura -N
}

function fileScan() {
  du -h | sort -hr | head -$1
}

# Eject All
case ${OSTYPE} in
  darwin*)
    function ejectAll() {
      osascript -e 'tell application "Finder" to eject (every disk whose ejectable is true and local volume is true and free space is not equal to 0)'
    }
    alias unmountAll=ejectAll
esac

# riywo/anyenv - https://github.com/riywo/anyenv
if [ -d ~/.anyenv/ ]; then
  eval "$(anyenv init - --no-rehash)"
fi

# direnv - unclutter your .profile - http://direnv.net/
if type direnv > /dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

# ESlint
function esw() {
  chokidar $1 -c "eslint {path} && echo '\u001b[32m✓ success\u001b[0m'"
}

# Docker
function setDockerEnv {
  eval $(docker-machine env $1)
}
function _setDockerEnv {
  if (( CURRENT == 2 )); then
    compadd $(docker-machine ls | awk '/Running/ {print $1}')
  fi
  return 1;
}
compdef _setDockerEnv setDockerEnv

# Node.js
function nodeAppInstall {
  npm i -g chokidar-cli eslint
}

# Peco
peco-ghq() {
    local selected
    selected="$(ghq list --full-path | peco --query="$LBUFFER")"
    if [ -n "$selected" ]; then
        BUFFER="builtin cd $selected"
        zle accept-line
    fi
    zle reset-prompt
}
zle -N peco-ghq
bindkey '^]' peco-ghq

function peco_select_history() {
  BUFFER=$(history -nr 1 | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle -R -c
}
zle -N peco_select_history
bindkey '^R' peco_select_history

function peco-kill-process () {
    ps -ef | peco | awk '{ print $2 }' | xargs kill
    zle clear-screen
}
zle -N peco-kill-process
bindkey '^k' peco-kill-process

# 外出しした設定ファイル
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
