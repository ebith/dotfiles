#!/bin/sh

brew update
brew upgrade

brew tap caskroom/cask
brew install brew-cask
brew tap caskroom/versions

brew tap homebrew/dupes
brew tap homebrew/versions

brew install ag
brew install coreutils
brew install git
brew install httpie
brew install jq
brew install phantomjs
brew install pwgen
brew install reattach-to-user-namespace
brew install ssh-copy-id
brew install sshfs
brew install terminal-notifier
brew install tig
brew install tmux
brew install tree
brew install wget
brew install zsh --disable-etcdir
brew install zsh-completions
brew install ttyrec

brew install laurent22/massren/massren
brew install motemen/ghq/ghq
brew install peco/peco/peco
brew install migemogrep

brew cask install appcleaner
brew cask install dropbox
brew cask install firefox-ja
brew cask install flash
brew cask install flashlight
brew cask install google-chrome
brew cask install google-japanese-ime
brew cask install iterm2
brew cask install karabiner
brew cask install libreoffice
brew cask install limechat
brew cask install macvim-kaoriya
brew cask install robomongo
brew cask install sourcetree
brew cask install steam
brew cask install teamspeak-client
brew cask install the-unarchiver
brew cask install transmission
brew cask install vagrant
brew cask install virtualbox
brew cask install gyazo
brew cask install bittorrent-sync

brew cleanup
brew cask cleanup
