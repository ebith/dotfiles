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

