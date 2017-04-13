# INSTALL
``` sh
curl -sL zplug.sh/installer | zsh

ghq get ebith/dotfiles
~/.ghq/github.com/ebith/dotfiles/create_link.sh
```

# for Mac
## [Homebrew — The missing package manager for macOS](http://brew.sh/)
``` sh
brew tap Homebrew/bundle
brew bundle --file=~/dotfiles/Brewfile
```

## [mac - Increase the maximum number of open file descriptors in Snow Leopard? - Super User](https://superuser.com/a/1171023)
```sh
sudo chown root:wheel ~/.ghq/github.com/ebith/dotfiles/launchd/limit.maxfiles.plist
sudo ln -s ~/.ghq/github.com/ebith/dotfiles/launchd/limit.maxfiles.plist /Library/LaunchDaemons/
sudo launchctl load -w /Library/LaunchDaemons/limit.maxfiles.plist
```
