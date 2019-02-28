# $PATHを重複させない
typeset -U PATH

# 補完を有効にする
# zplug 使用時は必要ない
# autoload -Uz compinit && compinit -C

########################################
# zplug
########################################
source ~/.zplug/init.zsh
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

zplug 'zsh-users/zsh-completions', depth:1, use:'src/_*', lazy:true
zplug 'zsh-users/zsh-syntax-highlighting', defer:2

zplug 'mafredri/zsh-async'
zplug 'sindresorhus/pure', use:pure.zsh, as:theme

zplug 'b4b4r07/enhancd', use:init.sh

zplug 'marzocchi/zsh-notify'
zstyle ':notify:*' command-complete-timeout 10
zstyle ':notify:*' success-sound "Hero"
zstyle ':notify:*' error-sound "Basso"

# if ! zplug check --verbose; then
#     printf "Install? [y/N]: "
#     if read -q; then
#         echo; zplug install
#     fi
# fi

zplug load

########################################
# plugin setting
########################################

########################################
# 未整理 #
########################################
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin

# $colors[red]とか書けるようになる
autoload -Uz colors && colors

# C-dでログアウトしない
setopt ignore_eof

# 履歴関係
setopt share_history
setopt hist_reduce_blanks
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt append_history
setopt inc_append_history
setopt hist_no_store
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt correct
setopt list_packed
setopt noautoremoveslash
setopt complete_aliases

setopt auto_cd

setopt extended_glob
setopt nullglob

# =のあともパス名保管する
setopt magic_equal_subst

# 単語の区切り文字を指定する (C-wでディレクトリ一つだけ削除できるように)
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

# alias
alias wget='wget --no-hsts'
alias vi=vim

alias -g L="| less -R"
alias -g T="| tail -f"

alias ls='exa -a'
alias ll='exa -al'
alias lls='exa -al -s modified'

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

# MacVim KaoriYa - http://codesource.google.com/p/macvim-kaoriya/
case ${OSTYPE} in
  darwin*)
    alias vim="/Applications/MacVim.app/Contents/bin/mvim --remote-tab-silent"
esac

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
  local tac
  { which gtac &> /dev/null && tac="gtac" } || \
    { which tac &> /dev/null && tac="tac" } || \
    tac="tail -r"
  BUFFER=$(fc -l -n 1 | eval $tac | \
              peco --layout=bottom-up --query "$LBUFFER")
  CURSOR=$#BUFFER # move cursor
  zle -R -c       # refresh
}
zle -N peco_select_history
bindkey '^R' peco_select_history

function peco-kill-process () {
    ps -ef | peco | awk '{ print $2 }' | xargs kill
    zle clear-screen
}
zle -N peco-kill-process
bindkey '^k' peco-kill-process

# Google Cloud SDK.
function loadGCSDK() {
  if [ -f '/Users/ebith/external/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/ebith/external/google-cloud-sdk/path.zsh.inc'; fi
  if [ -f '/Users/ebith/external/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/ebith/external/google-cloud-sdk/completion.zsh.inc'; fi
}

# ファイルの展開, 圧縮
function xfile () {
  for file in $*; do
    rfile=${file:r}
    if [[ ${rfile:e} == 'tar' ]]; then
      7z x -so $file | 7z x -si -ttar
    else
      7z x $file
    fi
  done
}
alias tarxz='tar --use-compress-program=/usr/local/bin/pixz -v'

# yarn
alias asar='nocorrect asar'

function random () {
 echo $((`od -vAn -tu2 -N2 /dev/urandom` % ${*:-10000}))
}

function fixCompletion () {
  rm ~/.zplug/zcompdump
  exec $SHELL -l
}

# 外出しした設定ファイル
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

if [ ~/.zshrc -nt ~/.zshrc.zwc ]; then
   zcompile ~/.zshrc
fi
