# Dotfiles

## Usage
```sh
./create_link.py .config .gitconfig .tmux.conf .vim
mkdir -p ~/.vimlocal/{backup,swap,undo}
chsh -s $(which fish)
exec fish

# [jorgebucaran/fisher: A plugin manager for Fish](https://github.com/jorgebucaran/fisher)
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
fisher update
```

### tmux
[tmux-plugins/tpm: Tmux Plugin Manager](https://github.com/tmux-plugins/tpm)を入れて`prefix + I`する。
