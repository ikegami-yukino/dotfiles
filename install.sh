#!/bin/sh
set -eu

homebrew() {
  items=${@}
  for x in ${items[@]}
  do
    echo "install ${x}"
    brew install ${x},
  done
}
homebrewcask() {
  items=${@}
  for x in ${items[@]}
  do
    echo "install ${x}"
    brew cask install ${x},
  done
}
make_dir() {
if [ ! -d ~/$1 ]; then
    echo "mkdir: $1"
    mkdir -p $1
fi
}

echo 'source .profile' > ~/.bashrc

sudo mkdir /work
sudo chmod 777 /work

###############
# Git
###############
if [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
  sudo apt-get install -y git
fi
git clone https://github.com/ikegami-yukino/dotfiles.git ~/dotfiles

ln -s ~/dotfiles/.* ~/

git config --global user.name "Yukino Ikegami"
git config --global user.email yknikgm@gmail.com
git config --global core.excludesfile $HOME/.gitignore_global

###############
# OSX
###############
if [ "$(uname)" == 'Darwin' ]; then
  echo 'Install xcode'
  xcode-select --install

  echo 'Install Homebrew'
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  homebrew tig nkf wget coreutils gnu-sed python3

  echo 'Install Java'
  brew tap phinze/homebrew-cask
  brew install brew-cask
  brew tap caskroom/versions

  homebrewcask java

  echo 'Install Ricty font'
  brew tap sanemat/font
  brew install Caskroom/cask/xquartz ricty
  ln -s /usr/local/Cellar/ricty/*/share/fonts/Ricty*.ttf ~/Library/Fonts/
  fc-cache -vf

  echo 'Install GUI apps'
  homebrewcask skype macvim-kaoriya totalspaces flux
  homebrewcask google-chrome firefox chromium
  homebrewcask dropbox mendeley-desktop iterm2 appcleaner

  # for development computer
  homebrewcask eclipse-java virtualbox vagrant no-ip-duc

  # for media server
  homebrewcask lyrics-master bettertouchtool vlc

  # Download ChocolatePapaya color for Vim
  make_dir ~/.vim/colors
  wget -O ~/.vim/colors/ChocolatePapaya.vim https://raw.githubusercontent.com/PrideChung/Vim/master/.vim/colors/ChocolatePapaya.vim

  ###############
  # OSX settings
  ###############
  # ネットワークボリュームに.DS_Storeを作らない
  defaults write com.apple.desktopservices DSDontWriteNetworkStores true
  # 隠しファイルの表示
  defaults write com.apple.finder AppleShowAllFiles -bool true
  # ライブラリフォルダの表示
  chflags nohidden ~/Library
  # Finderのタイトルバーにフルパスを表示
  defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
  # Quick Lookでテキストを選択可能に
  defaults write com.apple.finder QLEnableTextSelection -bool true
  # 撮影した画像から影のエフェクトを無くす
  defaults write com.apple.screencapture disable-shadow -bool true
  # 撮影した画像のファイル名を好きな名称に変更する
  defaults write com.apple.screencapture name cap

elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
  apt-get update

  # Install building tool
  apt-get install -y build-essential python3.5-dev python-pip virtualenv

  # Install scipy dependencies
  apt-get install -y gfortran liblapack-dev libblas-dev

  # Install matplotlib dependencies
  apt-get install -y libtiff4-dev libjpeg8-dev zlib1g-dev
  apt-get install -y libfreetype6-dev liblcms2-dev libwebp-dev

  # Install Java8
  sudo add-apt-repository ppa:webupd8team/java
  sudo apt-get update
  sudo apt-get install -y oracle-java8-installer
  sudo apt-get install oracle-java8-set-default

  # Install Elasticsearch
  https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.7.5.deb
  dpkg -i elasticsearch-1.7.5.deb
  service elasticsearch start

  # Set Japan timezone
  ln -sf /usr/share/zoneinfo/Japan /etc/localtime

  # Install substitute fonts to use in WordMap job
  apt-get install -y fonts-migmix
fi

###############
# Vim
###############
# Make Vim cache dir
make_dir ~/.vim/backup
make_dir ~/.vim/tmp
make_dir ~/.vim/undo

# Vim Python syntax checker
make_dir ~/.vim/plugin
wget -O ~/.vim/plugin/python_flake8.vim https://raw.githubusercontent.com/nvie/vim-flake8/master/ftplugin/python_flake8.vim
wget -O ~/.vim/plugin/python_autopep8.vim https://raw.githubusercontent.com/tell-k/vim-autopep8/master/ftplugin/python_autopep8.vim

make_dir ~/.vim/autoload
wget -O ~/.vim/autoload/flake8.vim https://raw.githubusercontent.com/nvie/vim-flake8/master/autoload/flake8.vim

# Vim Scala syntax highlighting
mkdir -p ~/.vim/{ftdetect,indent,syntax} && for d in ftdetect indent syntax ; do wget --no-check-certificate -O ~/.vim/$d/scala.vim https://raw.githubusercontent.com/derekwyatt/vim-scala/master/$d/scala.vim; done

# Vim indent guide
wget -O ~/.vim/autoload/color_helper.vim https://raw.githubusercontent.com/nathanaelkane/vim-indent-guides/master/autoload/color_helper.vim
wget -O ~/.vim/autoload/indent_guides.vim https://raw.githubusercontent.com/nathanaelkane/vim-indent-guides/master/autoload/indent_guides.vim
wget -O ~/.vim/plugin/indent_guides.vim https://raw.githubusercontent.com/nathanaelkane/vim-indent-guides/master/plugin/indent_guides.vim

###############
# Jupyter magic
###############
wget -O ~/.ipython/extensions/autopep8magic.py https://raw.githubusercontent.com/ikegami-yukino/misc/master/misc/autopep8magic/autopep8magic.py
