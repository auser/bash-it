#!/bin/bash

# functions
function apply_template {
  a=$(md5 -q $1 || "")
  b=$(md5 -q $2 || "")
  
  if [ "$a" != "$b" ]; then 
    echo "Replacing $1 with $2"
    ln -sF $2 $1
  fi
}

# VARIABLES
RUBY=$(which ruby)
SCRIPT="$(cd "${0%/*}" 2>/dev/null; echo "$PWD"/"${0##*/}")"
DIR=`dirname "${SCRIPT}"}`

# Install homebrew
if [ -z $(which brew) ]; then
  echo "Installing homebrew"
  $RUBY -e "$(curl -fsSL https://raw.github.com/gist/323731)"
fi

BREW=$(which brew)

# Install emacs
if [ -z $(which emacs) ]; then
  echo "Installing emacs"
  $BREW install emacs
fi

# tmux
if [ -z $(which tmux) ]; then
  $BREW install tmux
fi

# Templates
apply_template $HOME/.tmux.conf $DIR/template/tmux.template.conf
