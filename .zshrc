# 重複させない
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

# npm
type npm > /dev/null 2>&1 && source <(npm completion)

# sindresorhus/pure (Pretty, minimal and fast ZSH prompt) - https://github.com/sindresorhus/pure
autoload -U promptinit && promptinit
prompt pure

# MacVim KaoriYa - http://codesource.google.com/p/macvim-kaoriya/
case ${OSTYPE} in
  darwin*)
    alias vim="~/Applications/MacVim.app/Contents/MacOS/mvim --remote-tab-silent"
esac

# marzocchi/zsh-notify - https://github.com/marzocchi/zsh-notify
case ${OSTYPE} in
  darwin*)
    source ~/.zsh/zsh-notify/notify.plugin.zsh
esac

# ssh port fowarding
function sshpf() {
  \ssh -fL $1\:localhost\:$1 sakura -N
}

# knu/z - https://github.com/knu/z
autoload -Uz is-at-least
source ~/.zsh/z/z.sh

# cdd を tmux, bash, multi session +α に対応した - @m4i's blog - http://blog.m4i.jp/entry/2012/01/26/064329
source ~/.zsh/cdd/cdd
chpwd() {
  _cdd_chpwd
}

# Eject All
case ${OSTYPE} in
  darwin*)
    function ejectAll() {
      osascript -e "tell application \"Finder\" to eject (every disk whose ejectable is true and local volume is true and free space is not equal to 0)"
    }
    alias unmountAll=ejectAll
esac

# riywo/anyenv - https://github.com/riywo/anyenv
if [ -d ~/.anyenv/ ]; then
  eval "$(anyenv init -)"
fi

# direnv - unclutter your .profile - http://direnv.net/
eval "$(direnv hook zsh)"

# 外出しした設定ファイル
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
source ~/.zsh/peco
