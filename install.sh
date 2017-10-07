#!/usr/bin/env bash
set -eu

make_link() {
  items=${@}
  for x in ${items[@]}
  do
    if [ ! -e ~/${x} ]; then
      echo "Create ${x}"
      ln -s ~/dotfiles/${x} ~/
    fi
  done
}

homebrew() {
  items=${@}
  for x in ${items[@]}
  do
    if type ${x} 1> /dev/null 2> /dev/null ; then
      if brew upgrade ${x} ; then
        :
      fi
    else
      echo "install ${x}"
      brew install ${x}
    fi
  done
}

homebrewcask() {
  items=${@}
  for x in ${items[@]}
  do
    if type ${x} 1> /dev/null 2> /dev/null ; then
      :
    else
      echo "install ${x}"
      brew cask install ${x}
    fi
  done
}

make_dir() {
if [ ! -d ~/${1} ]; then
    echo "mkdir: ${1}"
    mkdir -p ${1}
fi
}

if [ ! -d /work ]; then
    echo "mkdir: /work"
    sudo mkdir /work
    sudo chmod 777 /work
fi

###############
# Git
###############
if type apt-get 1> /dev/null 2> /dev/null ; then
  apt-get update
  sudo apt-get install -y git
fi
if [ ! -d ~/dotfiles ]; then
  git clone https://github.com/ikegami-yukino/dotfiles.git ~/dotfiles
fi

make_link {.bashrc,.gitconfig,.gitignore_global,.gvimrc,.ipython,.jupyter,.matplotlib,.profile,.ssh,.vim,.vimrc}

git config --global user.name "Yukino Ikegami"
git config --global user.email yknikgm@gmail.com
git config --global core.excludesfile $HOME/.gitignore_global

###############
# OSX
###############
if [ "$(uname)" == 'Darwin' ]; then
  echo 'source .profile' > ~/.bashrc

  if xcode-select --install 1> /dev/null ; then
    :
  fi

  if type brew 1> /dev/null 2> /dev/null ; then
    :
  else
    echo 'Install Homebrew'
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  homebrew tig nkf wget coreutils gnu-sed python3 ag

  echo 'Install Java'
  brew tap caskroom/versions
  homebrewcask java

  echo 'Install Ricty font'
  brew tap sanemat/font
  brew install Caskroom/cask/xquartz ricty
  ln -sf /usr/local/Cellar/ricty/*/share/fonts/Ricty*.ttf ~/Library/Fonts/
  fc-cache -vf

  echo 'Install QuickLook plugins'
  homebrewcask install qlcolorcode qlstephen qlmarkdown quicklook-json quicklook-csv betterzipql

  echo 'Install GUI apps'
  homebrewcask slack macvim totalspaces flux
  homebrewcask google-chrome
  homebrewcask dropbox iterm2 appcleaner

  ###############
  # OSX settings
  ###############
  # ネットワークボリュームに.DS_Storeを作らない
  defaults write com.apple.desktopservices DSDontWriteNetworkStores true
  # USBドライブに.DS_Shareを作らない
  defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
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
  # 撮影した画像のファイル名を変更する
  defaults write com.apple.screencapture name cap

elif type apt 1> /dev/null 2> /dev/null ; then

  # Install building tool
  sudo apt install -y build-essential python3.5-dev python-pip virtualenv python3-pip

  # Install Developper tool
  sudo apt install vim-gnome byobu

  # Install scipy dependencies
  sudo apt install -y gfortran liblapack-dev libblas-dev

  # Install matplotlib dependencies
  sudo apt install -y libtiff5-dev libjpeg8-dev zlib1g-dev
  sudo apt install -y libfreetype6-dev liblcms2-dev libwebp-dev

  # Install Java8
  sudo add-apt-repository ppa:webupd8team/java
  sudo apt update
  sudo apt install -y oracle-java8-installer
  sudo apt install oracle-java8-set-default

  # Install Elasticsearch
  wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.6.2.deb
  sudo dpkg -i elasticsearch-5.6.2.deb
  sudo service elasticsearch start

  # Set Japan timezone
  sudo ln -sf /usr/share/zoneinfo/Japan /etc/localtime

  # Install substitute fonts to use in WordMap job
  sudo apt install -y fonts-migmix
  
  # Rename directories
  LANG=C xdg-user-dirs-gtk-update
  
  # Diasble guest session
  sudo sh -c 'printf "[SeatDefaults]\nallow-guest=false\n" >/usr/share/lightdm/lightdm.conf.d/50-no-guest.conf'

  # Prevents Windows's clock from shifting
  sudo timedatectl set-local-rtc true
  
  # Change setting clock server
  sudo sed -i 's/#NTP=/NTP=ntp.nict.jp/g' /etc/systemd/timesyncd.conf
  
  # Change nautilus's address bar to text style
  gsettings set org.gnome.nautilus.preferences always-use-location-entry true
fi

###############
# Vim
###############
# Make Vim cache dir
make_dir ~/.vim/backup
make_dir ~/.vim/tmp
make_dir ~/.vim/undo

# Download ChocolatePapaya color for Vim
make_dir ~/.vim/colors
wget -O ~/.vim/colors/ChocolatePapaya.vim https://raw.githubusercontent.com/PrideChung/Vim/master/.vim/colors/ChocolatePapaya.vim

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

# vim-yapf
sudo pip install yapf
make_dir ~/.vim/ftplugin
wget -O ~/.vim/ftplugin/python_yapf.vim https://raw.githubusercontent.com/mindriot101/vim-yapf/master/ftplugin/python_yapf.vim

###############
# Jupyter magic
###############
sudo pip install jupyter autopep8
jupyter nbextension install https://github.com/kenkoooo/jupyter-autopep8/archive/master.zip --user
jupyter nbextension enable jupyter-autopep8-master/jupyter-autopep8
