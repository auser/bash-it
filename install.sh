#!/bin/bash

# VARIABLES
RUBY=$(which ruby)

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