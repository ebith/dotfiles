# INSTALL
git clone git@github.com:ebith/dotfiles.git
./dotfiles/create_link.sh

## for vim
cd ~/dotfiles/.vim/autoload/ ; ln -s ../bundle/vim-pathogen/autoload/pathogen.vim .
cd ~/dotfiles/.vim/bundle/vimproc ; make -f make_...
