[alias]
	st = status
	co = checkout
	br = branch
	ci = commit
	ca = commit -a
	cia = commit -a -m $1
	up = !gitup
	cl = clone
	lg = log --color --graph --stat
	serve = !git daemon --reuseaddr --verbose  --base-path=. --export-all
	graphviz = "!f() { echo 'digraph git {' ; git log --pretty='format:  %h -> { %p }' \"$@\" | sed 's/[0-9a-f][0-9a-f]*/\"&\"/g' ; echo '}'; }; f"
  lc = log ORIG_HEAD.. --stat --no-merges  
	who-did-what = log --pretty="format:%an - %s"
	hist = log --pretty=format:\"%h %ad | %s%d [%an]\" --graph --date=short
  type = cat-file -t
  dump = cat-file -p
	iweb = instaweb -d webrick
	pl = !bash -c 'git log --graph --pretty=oneline --abbrev-commit HEAD~"${1:-10}"..HEAD' -
[alias]
  w = whatchanged
  st = status
	co = checkout
	br = branch
	ci = commit
	ca = commit -a
	cia = commit -a -m $1
	up = !gitup
	cl = clone
	lg = log --color --graph --stat
	serve = !git daemon --reuseaddr --verbose  --base-path=. --export-all
	graphviz = "!f() { echo 'digraph git {' ; git log --pretty='format:  %h -> { %p }' \"$@\" | sed 's/[0-9a-f][0-9a-f]*/\"&\"/g' ; echo '}'; }; f"
  lc = log ORIG_HEAD.. --stat --no-merges  
	who-did-what = log --pretty="format:%an - %s"
	iweb = instaweb -d webrick
	pl = !bash -c 'git log --graph --pretty=oneline --abbrev-commit HEAD~"${1:-10}"..HEAD' -

[user]
	name = Ari Lerner
	email = arilerner@mac.com
[gui]
	recentrepo = /Users/alerner/Development/c/open-source/ebb
[push]
	default = current
[difftool "Kaleidoscope"]
	cmd = ksdiff-wrapper git \"$LOCAL\" \"$REMOTE\"
[difftool]
	prompt = false
[diff]
	tool = Kaleidoscope
[core]
	autocrlf = input
	safecrlf = true
[color]
  diff = auto
  status = auto
  branch = auto
  interactive = auto
  ui = true
  pager = true
[merge]
  summary = true
[push]
  default = tracking
[remote "origin"]
	push = HEAD
[github]
	user = auser
	token = 98557e02df00c9b04a4106682ec2f951
[diff]
  ignoresubmodules = untracked
