# Dotfiles

## Usage
```sh
./create_link.py .config .gitconfig .tmux.conf .vim
mkdir -p ~/.vimlocal/{backup,swap,undo}
chsh -s $(which fish)
exec fish
fisher update
```

### tmux
[tmux-plugins/tpm: Tmux Plugin Manager](https://github.com/tmux-plugins/tpm)を入れて`prefix + I`する。
