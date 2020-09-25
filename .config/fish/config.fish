# PATH
## Rust
set fish_user_paths $HOME/.cargo/bin $fish_user_paths
## Go
set -x GOPATH $HOME/.go
set fish_user_paths $GOPATH/bin $fish_user_paths

# Suppress welcome message
set fish_greeting

# jorgebucaran/fisher: A package manager for the fish shell. - https://github.com/jorgebucaran/fisher
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

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

# fzf [jethrokuan/fzf: Ef-🐟-ient fish keybindings for fzf](https://github.com/jethrokuan/fzf)
set FZF_DISABLE_KEYBINDINGS 1
set FZF_FIND_FILE_COMMAND 'fd --type file --hidden --follow --exclude .git'
bind \ct '__fzf_find_file'
bind \cr '__fzf_reverse_isearch'
alias cdf='__fzf_cd --hidden'

# MacVim
if test -x /usr/local/bin/mvim
  function vi
    mvim $argv
  end
  function vim
    mvim $argv
  end
end

