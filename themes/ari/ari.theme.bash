# For unstaged(*) and staged(+) values next to branch name in __git_ps1
GIT_PS1_SHOWDIRTYSTATE="enabled"

function rvm_version_prompt {
  local gemset=$(echo $GEM_HOME | awk -F'@' '{print $2}')

  [ "$gemset" != "" ] && gemset="@$gemset"
  local version=$(echo $MY_RUBY_HOME | awk -F'-' '{print $2}')

  [ "$version" == "1.9.2" ] && version=""

  local full="$version$gemset"

  [ "$full" != "" ] && echo "$full"
}

# Check http://github.com/Sirupsen/dotfiles for screenshot
PS1='\[$green\]\W/\[$bold_blue\]$(rvm_version_prompt)\[$bold_green\]$(__git_ps1 " (%s)") \[${normal}\]$ '
PS1='\[$purple\]\W/$(rvm_version_prompt)\[$yellow\]$(__git_ps1 " (%s)") \[${normal}\]$ '
