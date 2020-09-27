# PATH
## Rust
set fish_user_paths $HOME/.cargo/bin $fish_user_paths
## Go
set -x GOPATH $HOME/.go
set fish_user_paths $GOPATH/bin $fish_user_paths

# Suppress welcome message
set fish_greeting

# Starship: Cross-Shell Prompt - https://starship.rs/
starship init fish | source

# Alias
alias ls='lsd -a --icon=never'
alias ll='ls -l'
alias lt='ls --tree'

alias bat='bat --theme="Monokai Extended Bright"'
alias cat='bat --plain'
alias dog='cat > /dev/null'

alias wget='wget --no-hsts'

alias pfgrafana='ssh -fNL 3000:localhost:3000 home'
alias pfoctopi='ssh -fNL 8080:octopi.local:80 home'
alias pfremopi='ssh -fNL 42897:raspberrypi3b.local:42897 home'

# fzf [jethrokuan/fzf: Ef-🐟-ient fish keybindings for fzf](https://github.com/jethrokuan/fzf)
set FZF_DISABLE_KEYBINDINGS 1
set FZF_FIND_FILE_COMMAND 'fd --type file --hidden --follow --exclude .git'
bind \ct '__fzf_find_file'
bind \cr '__fzf_reverse_isearch'
alias cdf='__fzf_cd --hidden'

# tmux
if test -z $TMUX && status --is-login
#   tmux new-session -A -s 0
  echo -e '\n\e[7m**TMUX**\e[m'
  tmux ls
end

# MacVim
if test -x /usr/local/bin/mvim
  function vi
    mvim $argv
  end
  function vim
    mvim $argv
  end
end

