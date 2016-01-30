########################################
# zplug
########################################
source ~/.zplug/zplug
zplug "b4b4r07/zplug"

zplug "zsh-users/zsh-completions"
# backward-kill-wordが死ぬ。Zsh 5.3で直るらしい
# zplug "zsh-users/zsh-syntax-highlighting"
# zsh-syntax-highlighting が無いとエラー吐く
# zplug "zsh-users/zsh-history-substring-search"

zplug "rimraf/k"

zplug "mafredri/zsh-async" | zplug "sindresorhus/pure"

zplug "b4b4r07/enhancd", of:enhancd.sh
# zplug "knu/z", of:z.sh

zplug "mollifier/anyframe"

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load --verbose

########################################
# plugin setting
########################################

# mollifier/anyframe: peco/percol/fzf wrapper plugin for zsh - https://github.com/mollifier/anyframe
bindkey '^r' anyframe-widget-execute-history
bindkey '^xi' anyframe-widget-put-history
bindkey '^x^i' anyframe-widget-put-history
# alias gcd=anyframe-widget-cd-ghq-repository
# bindkey '^xg' anyframe-widget-cd-ghq-repository
# bindkey '^x^g' anyframe-widget-cd-ghq-repository
alias pkill=anyframe-widget-kill
bindkey '^xk' anyframe-widget-kill
bindkey '^x^k' anyframe-widget-kill

# zsh-users/zsh-history-substring-search: ZSH port of Fish shell's history search feature. - https://github.com/zsh-users/zsh-history-substring-search
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down

#################### 未整理 ####################
# $PATHを重複させない
typeset -U PATH

# 補完関係
[[ -d /usr/local/share/zsh/site-functions ]] && fpath=(/usr/local/share/zsh/site-functions $fpath)
fpath=($HOME/.zsh/.zfunctions $HOME/.zsh/zsh-completions/src $fpath)
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

# もしかして:
SPROMPT="correct: %R -> %r ? "

# dircolors
eval `dircolors ~/.zsh/dircolors-solarized/dircolors.256dark`
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

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
    alias vim="~/Applications/MacVim.app/Contents/MacOS/mvim --remote-tab-silent"
esac

# ssh port fowarding
function sshpf() {
  \ssh -fL $1\:localhost\:$1 sakura -N
}

# knu/z - https://github.com/knu/z
# source ~/.zsh/z/z.sh

# cdd を tmux, bash, multi session +α に対応した - @m4i's blog - http://blog.m4i.jp/entry/2012/01/26/064329
source ~/.zsh/cdd/cdd
chpwd() {
  _cdd_chpwd
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
  eval "$(anyenv init -)"
fi

# direnv - unclutter your .profile - http://direnv.net/
if type direnv > /dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

# tmuxのウィンドウ名をカレントディレクトリにする - ミントフレーバー緑茶 - http://mint.hateblo.jp/entry/2012/12/17/175553
show-current-dir-as-window-name() {
  if [ -n "$TMUX" ]; then
    tmux set-window-option window-status-format "#I:${PWD:t}" > /dev/null
  fi
}
show-current-dir-as-window-name
add-zsh-hook chpwd show-current-dir-as-window-name

# ESlint
function esw() {
  chokidar $1 -c "eslint {path} && echo '\u001b[32m✓ success\u001b[0m'"
}

# Docker
case ${OSTYPE} in
  darwin*)
    eval $(docker-machine env local)
esac

# 外出しした設定ファイル
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
source ~/.zsh/peco
