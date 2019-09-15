export LANG=ja_JP.UTF-8
export LC_ALL=C
export LC_ALL=ja_JP.UTF-8
export PS1="\h:\W \u\\$ "

export CLICOLOR=1
export LSCOLORS=DxGxcxdxCxegedabagacad
export HISTCONTROL=ignoreboth

# bash history
export HISTSIZE=9999

# bash completion
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# aliases
alias l='ls -lah -G'
alias ls='ls -G'
alias ll='ls -alh -G'
alias keys="ssh-add -l"
if [ "$(uname)" == 'Darwin' ]; then
  alias gvim='open /Applications/MacVim.app'
fi

# Python
export PYTHONDONTWRITEBYTECODE=1
export PATH=${HOME}/.local/bin/:${PATH}

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

# Java
alias java='java -Dfile.encoding=UTF-8'
alias javac='javac -J-Dfile.encoding=UTF-8'

# MeCab
export PATH=${PATH}:/usr/local/libexec/mecab
export LD_LIBRARY_PATH=/usr/local/lib/java/mecab/:${LD_LIBRARY_PATH}
alias neologd='mecab -d /usr/local/lib/mecab/dic/mecab-ipadic-neologd'
neologd_update (){
  git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git /tmp/mecab-ipadic-neologd
  bash /tmp/mecab-ipadic-neologd/bin/install-mecab-ipadic-neologd -n -y
  rm -rf /tmp/mecab-ipadic-neologd
}

##################
# Private settings
##################
if [ -e ~/.private_profile ]; then
  source ~/.private_profile
fi
