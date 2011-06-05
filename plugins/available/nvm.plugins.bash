#!/bin/bash
#
# Adds NVM if it's available
#

NVM_DIR=$HOME/.nvm
if [ -e ~/.bashrc ] ; then
  . $NVM_DIR/nvm.sh
fi