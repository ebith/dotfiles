# Dotfiles

## Requirements
[zplug/zplug: A next-generation plugin manager for zsh](https://github.com/zplug/zplug)

## Usage
```sh
./create_link.py .hammerspoon .zshrc .config/peco
```

## For Mac
### [Homebrew — The missing package manager for macOS](http://brew.sh/)

### [mac - Increase the maximum number of open file descriptors in Snow Leopard? - Super User](https://superuser.com/a/1171023)
```sh
sudo chown root:wheel ~/.ghq/github.com/ebith/dotfiles/launchd/limit.maxfiles.plist
sudo ln -s ~/.ghq/github.com/ebith/dotfiles/launchd/limit.maxfiles.plist /Library/LaunchDaemons/
sudo launchctl load -w /Library/LaunchDaemons/limit.maxfiles.plist
```

