#!/bin/bash
#
# Switch between cloud environments

CLOUD_DIRECTORY="$HOME/.ec2"

function _current_cloud_env() {
  CURRENT_CLOUD_ENVIRONMENT_FILE="$HOME/.current_cloud_environment"
  if [ -z "$1" ]; then
    # Get cloud environment
    cat "$CURRENT_CLOUD_ENVIRONMENT_FILE"
    # Set the cloud environment
  fi
}

function cloud_env() {
  if [ -z "$1" ]; then
    _current_cloud_env
  elif [ "$1" == "list" ]; then
    echo "Environments"
    for d in $CLOUD_DIRECTORY/*; do echo "  $(basename $d)"; done
  else
    DIR="$CLOUD_DIRECTORY/$1"
    if [ -d "$DIR" ]; then
      if [ -f "$DIR/novarc" ]; then
        source $DIR/novarc
        echo "$1" > $CURRENT_CLOUD_ENVIRONMENT_FILE
        _current_cloud_env $1
      elif [ -f "$DIR/environment" ]; then
        source $DIR/environment
        _current_cloud_env $1
      else
        echo "Not a valid envionrment"
      fi
    else
      echo "Unknown environment. Please try again"
    fi
  fi
}
