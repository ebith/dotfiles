function tmux_switch_prefix
  set prefix (string sub -s 8 (tmux show-options -g prefix))
  if test $prefix = '`'
    echo $prefix
    tmux set -g prefix C-t
    tmux bind C-t run 'tmux last-pane || tmux last-window || tmux new-window'
  else if test $prefix = 'C-t'
    tmux set -g prefix '`'
    tmux bind '`' run 'tmux last-pane || tmux last-window || tmux new-window'
  end
end

