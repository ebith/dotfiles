#!/usr/bin/env zsh
prefix=$(tmux show-options -g prefix)
if [[ ${prefix:7}  == '`' ]]; then
  tmux set -g prefix C-t
  tmux bind C-t run 'tmux last-pane || tmux last-window || tmux new-window'
elif [[ ${prefix:7}  == 'C-t' ]]; then
  tmux set -g prefix '`'
  tmux bind '`' run 'tmux last-pane || tmux last-window || tmux new-window'
fi
