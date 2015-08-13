export LANG=ja_JP.UTF-8
export PS1="\h:\W \u\\$ "

export CLICOLOR=1
export LSCOLORS=DxGxcxdxCxegedabagacad
export HISTCONTROL=ignoreboth

alias ls='ls -G'
alias ll='ls -alh -G'

# Git
alias b="git branch"
alias c="git commit"
alias m="git checkout master"
alias gitauthorreset="git commit --amend --reset-author"
alias gitvgmail="git config user.email yukino_ikegami@voyagegroup.com"

# Java
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
alias java='java -Dfile.encoding=UTF-8'
alias javac='javac -J-Dfile.encoding=UTF-8'

# Java MeCab
export LD_LIBRARY_PATH=/usr/local/lib/java/mecab/:${LD_LIBRARY_PATH}

# Kauli Setting
if [ -e "/kauli" ]; then
  source ~/.profile.kauli
fi
