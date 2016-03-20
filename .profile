export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8
export PS1="\h:\W \u\\$ "

export CLICOLOR=1
export LSCOLORS=DxGxcxdxCxegedabagacad
export HISTCONTROL=ignoreboth

# aliases
alias l='ls -lah -G'
alias ls='ls -G'
alias ll='ls -alh -G'
alias keys="ssh-add -l"
alias gvim='open ~/Applications/MacVim.app'

# Python
export PYTHONDONTWRITEBYTECODE=1

# Git
alias b="git branch"
alias c="git commit"
alias m="git checkout master"
alias gs="git status"
alias gf="git diff"
alias gc="git diff --cached"
alias gb="git branch --no-merge"
alias gbr="git branch -r --no-merge"
alias gitauthorreset="git commit --amend --reset-author"
alias gitvgmail="git config user.email yukino_ikegami@voyagegroup.com"

# Java
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
alias java='java -Dfile.encoding=UTF-8'
alias javac='javac -J-Dfile.encoding=UTF-8'

# MeCab
export PATH=${PATH}:/usr/local/libexec/mecab
export LD_LIBRARY_PATH=/usr/local/lib/java/mecab/:${LD_LIBRARY_PATH}


##################
# Private settings
##################
if [ -e ~/.private_profile ]; then
  source ~/.private_profile
fi
