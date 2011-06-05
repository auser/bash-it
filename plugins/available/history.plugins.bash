#!/bin/bash
#
# Adds history to the commandline
#

hg='history | grep'
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'
