#!/bin/basORANGEh

# Colors
ORANGE='\e[0;33m'
GREY='\e[1:37m'

DEFAULT_COLOR='\[${white}\]'

USER_COLOR='\[${purple}\]'
SUPERUSER_COLOR='\[${red}\]'
MACHINE_COLOR=$ORANGE
DIRECTORY_COLOR='\[${bold_green}\]'

VE_COLOR='\[${red}\]'
RVM_COLOR='\[${purple}\]'

# SCM prompts
SCM_THEME_PROMPT_DIRTY=' ${bold_red}✗${normal}'
SCM_THEME_PROMPT_CLEAN=' ${bold_green}✓${normal}'

# Max length of PWD to display
MAX_PWD_LENGTH=20

# Max length of Git Hex to display
MAX_GIT_HEX_LENGTH=5

# Use http://geoff.greer.fm/lscolors/

# Displays the current virtualenv information
function curr_virtualenv_info() {
    [ ! -z "$VIRTUAL_ENV" ] && echo "`basename $VIRTUAL_ENV`"
}

# Displays the current rvm information w/gemset
function curr_rvm_info() {
    local ruby_version=$(echo $MY_RUBY_HOME | awk -F'-' '{print $2}')
    local ruby_gemset=$(echo $GEM_HOME | awk -F'@' '{print $2}')

    if [ "$ruby_version" != "" ]; then
        [ "$ruby_gemset" != "" ] && ruby_gemset="@$ruby_gemset"
        echo "$ruby_version$ruby_gemset"
    fi
}

# Displays using ...
function virtual_info() {
    local virtual_env_info=$(curr_virtualenv_info)
    local rvm_info=$(curr_rvm_info)
    local prompt="using"

    # If no virtual info, just return
    [ "$virtual_env_info" == "" -a "$rvm_info" == "" ] && return

    # If virtual_env info present, append to prompt
    [ "$virtual_env_info" != "" ] && prompt="$prompt virtualenv: ${VE_COLOR}$virtual_env_info${DEFAULT_COLOR}"

    if [ "$rvm_info" != "" ]
    then
        [ "$virtual_env_info" != "" ] && prompt="$prompt,"
        prompt="$prompt rvm: ${RVM_COLOR}$rvm_info${DEFAULT_COLOR}"
    fi
    echo $prompt
}


# SCM information
function scm_info() {
    SCM_CHAR=$(scm_char)
    [ "$SCM_CHAR" == "$SCM_NONE_CHAR" ] && return
    local prompt="on"
    [ "$SCM_CHAR" == "$SCM_GIT_CHAR" ] && echo "$prompt$(parse_git_info)" && return
}

# Parse git info
function parse_git_info() {
    if [[ -n $(git status -s 2> /dev/null |grep -v ^# |grep -v "working directory clean") ]]; then
      state=${GIT_THEME_PROMPT_DIRTY:-$SCM_THEME_PROMPT_DIRTY}
    else
      state=${GIT_THEME_PROMPT_CLEAN:-$SCM_THEME_PROMPT_CLEAN}
    fi
    prefix=${GIT_THEME_PROMPT_PREFIX:-$SCM_THEME_PROMPT_PREFIX}
    suffix=${GIT_THEME_PROMPT_SUFFIX:-$SCM_THEME_PROMPT_SUFFIX}
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    rawhex=$(git rev-parse HEAD 2>/dev/null) || return

    echo -e "$prefix${ref#refs/heads/} (${rawhex:0:$MAX_GIT_HEX_LENGTH})$state$suffix"
}

# Displays last X characters of pwd 
function limited_pwd() {

    # Replace $HOME with ~ if possible 
    RELATIVE_PWD=${PWD/#$HOME/\~}

    local offset=$((${#RELATIVE_PWD}-$MAX_PWD_LENGTH))

    if [ $offset -gt "0" ]
    then
        local truncated_symbol="..."
        TRUNCATED_PWD=${RELATIVE_PWD:$offset:$MAX_PWD_LENGTH}
        echo "${truncated_symbol}/${TRUNCATED_PWD#*/}"
    else
        echo "${RELATIVE_PWD}"
    fi
}

# Displays the current prompt
function prompt() {

  local UC=$USER_COLOR
  [ $UID -eq "0" ] && UC=$SUPERUSER_COLOR
    
  PS1="$(scm_char) ${UC}\u ${DEFAULT_COLOR}at ${MACHINE_COLOR}\h${DEFAULT_COLOR} in ${DIRECTORY_COLOR}$(limited_pwd)${DEFAULT_COLOR} $(virtual_info) $(scm_info) \$ "
  PS2='> '
  PS4='+ '
}

PROMPT_COMMAND=prompt
