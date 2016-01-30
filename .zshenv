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
export PATH=$GOPATH/bin:$PATH

# riywo/anyenv - https://github.com/riywo/anyenv
if [ -d ~/.anyenv/ ]; then
  export PATH="$HOME/.anyenv/bin:$PATH"
  # for thinca/vim-quickrun
  # for rPath in ~/.anyenv/envs/*(/); do
  #     aPath=`readlink -f $rPath`
  #     export PATH="$aPath/shims:$PATH"
  # done
fi

# Node.js
export PATH=./node_modules/.bin:$PATH
alias gulp="nocorrect gulp"
