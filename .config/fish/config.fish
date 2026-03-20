if test -x $HOME/.config/fish/config.fish.local
  source $HOME/.config/fish/config.fish.local
end

# PATH
## Homebrew
if test -x /home/linuxbrew/.linuxbrew/bin/brew
  set -x HOMEBREW_NO_ANALYTICS 1
  eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
end
## Rust
set fish_user_paths $HOME/.cargo/bin $fish_user_paths
## Go
set -x GOPATH $HOME/.go
set fish_user_paths $GOPATH/bin $fish_user_paths
## Perl
if test -d $HOME/perl5/lib/perl5
  eval (perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)
end

# Suppress welcome message
set fish_greeting

set -x EDITOR vim

# Alias
alias wget='wget --no-hsts'

# Starship: Cross-Shell Prompt - https://starship.rs/
starship init fish | source

# ajeetdsouza/zoxide: A faster way to navigate your filesystem - https://github.com/ajeetdsouza/zoxide
zoxide init fish | source

# lsd-rs/lsd: The next gen ls command - https://github.com/lsd-rs/lsd
alias ls='lsd -a --icon=never'
alias ll='ls -l'
alias lt='ls --tree'

# sharkdp/bat: A cat(1) clone with wings. - https://github.com/sharkdp/bat
alias bat='bat --theme="Monokai Extended Bright"'
alias cat='bat --plain'
alias dog='cat > /dev/null'

# fzf [jethrokuan/fzf: Ef-🐟-ient fish keybindings for fzf](https://github.com/jethrokuan/fzf)
set FZF_DISABLE_KEYBINDINGS 1
set FZF_FIND_FILE_COMMAND 'fd --type file --hidden --follow --exclude .git'
bind \ct '__fzf_find_file'
bind \cr '__fzf_reverse_isearch'
alias cdf='__fzf_cd --hidden'

# tmux
if test -e tmux && test -z $TMUX && status --is-login
#   tmux new-session -A -s 0
  echo -e '\n\e[7m**TMUX**\e[m'
  tmux ls
end

function tmux_switch_prefix
  set prefix (string sub -s 8 (tmux show-options -g prefix))
  if test $prefix = '`'
    tmux set -g prefix C-b
    tmux bind C-b run 'tmux last-pane || tmux last-window || tmux new-window'
  else if test $prefix = 'C-b'
    tmux set -g prefix '`'
    tmux bind '`' run 'tmux last-pane || tmux last-window || tmux new-window'
  end
end
