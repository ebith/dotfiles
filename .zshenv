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
    if [ -d /usr/local/opt/coreutils/libexec/gnubin ]; then
      export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
      export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
    fi
esac

# golang
export GOPATH=$HOME/.go
export PATH=$GOPATH/bin:$PATH

# Node.js
export PATH="./node_modules/.bin:$PATH"

# theos
export THEOS=~/.ghq/github.com/theos/theos

# git diff-highlight
export PATH="/usr/local/share/git-core/contrib/diff-highlight:$PATH"

# Ruby
export PATH="/usr/local/opt/ruby/bin:$PATH"

# Rust
export PATH="/Users/ebith/.cargo/bin:$PATH"
