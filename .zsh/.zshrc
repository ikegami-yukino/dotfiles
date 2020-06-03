export LANG=ja_JP.UTF-8
export LC_ALL=C
export LC_ALL=ja_JP.UTF-8
export PS1="%n@%m%f: %c$ "

export CLICOLOR=1
export LSCOLORS=DxGxcxdxCxegedabagacad
export HISTCONTROL=ignoreboth

# command history
export HISTSIZE=9999
setopt hist_ignore_all_dups

# zsh-completions
if [ -e /usr/local/share/zsh-completions ]; then
  fpath=(/usr/local/share/zsh-completions $fpath)
fi
autoload -U compinit
compinit -u

# aliases
alias l='ls -lah -G'
alias ls='ls -G'
alias ll='ls -alh -G'
alias keys="ssh-add -l"
alias his='history | grep'

[ -f $ZDOTDIR/.zshrc_`uname` ] && . $ZDOTDIR/.zshrc_`uname`

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
