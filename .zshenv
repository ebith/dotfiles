export PATH=~/bin:$PATH

# Homebrew
if [ -x /usr/local/bin/brew ]; then
  export PATH=/usr/local/bin:$PATH
  if [ -d /usr/local/sbin ]; then
    export PATH=/usr/local/sbin:$PATH
  fi
fi

# Macでもgnu coreutils使う
case ${OSTYPE} in
  darwin*)
    if [ -d $(brew --prefix coreutils)/libexec/gnubin ]; then
      export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
      export MANPATH="$(brew --prefix coreutils)/libexec/gnuman:$MANPATH"
    fi
esac

# golang
export GOPATH=$HOME/.go
export GOROOT=/usr/local/opt/go/libexec
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

# riywo/anyenv - https://github.com/riywo/anyenv
if [ -d ~/.anyenv/ ]; then
  export PATH="$HOME/.anyenv/bin:$PATH"
  eval "$(anyenv init -)"
  source ~/.anyenv/completions/anyenv.zsh
fi

# Node.js
export PATH=./node_modules/.bin:$PATH
alias gulp="nocorrect gulp"
