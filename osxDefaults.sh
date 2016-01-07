#!/bin/sh

# .DS_Storeを作らせない
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Dockを左に
defaults write com.apple.dock orientation -string 'left'

# Dockを自動的に隠す
defaults write com.apple.dock autohide -bool true

# Dockのデフォルトアプリを削除
defaults write com.apple.dock persistent-apps -array

# 写真アプリを自動起動させない
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool YES
