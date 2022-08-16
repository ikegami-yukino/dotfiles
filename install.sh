#!/usr/bin/env bash
set -eu

make_link() {
  items=${@}
  for x in ${items[@]}
  do
    if [ ! -e ~/${x} ]; then
      echo "Create ${x}"
      ln -sf ~/dotfiles/${x} ~/
    fi
  done
}

make_dir() {
if [ ! -d ~/${1} ]; then
    echo "mkdir: ${1}"
    mkdir -p ${1}
fi
}

if [ ! -d ${HOME}/work ]; then
    echo "mkdir: ${HOME}/work"
    mkdir ${HOME}/work
fi

if [ "$(uname)" == 'Darwin' ]; then
    if xcode-select --install 1> /dev/null ; then
    :
    fi
fi

###############
# Git
###############
if type apt-get 1> /dev/null 2> /dev/null ; then
  sudo apt-get update
  sudo apt-get install -y git
fi
if [ ! -d ~/dotfiles ]; then
  git clone git@github.com:ikegami-yukino/dotfiles.git ~/dotfiles
fi

make_link {.bashrc,.gitconfig,.gitignore_global,.gvimrc,.ipython,.jupyter,.matplotlib,.profile,.ssh,.vim,.vimrc,.keras,.zshenv,.zsh,.tigrc}

git config --global user.name "Yukino Ikegami"
git config --global user.email yknikgm@gmail.com
git config --global core.excludesfile ${HOME}/.gitignore_global

###############
# OSX
###############
if [ "$(uname)" == 'Darwin' ]; then
  if type brew 1> /dev/null 2> /dev/null ; then
    :
  else
    echo 'Install Homebrew'
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  # Setting Git
  brew install git tig
  ln -s /opt/homebrew/share/git-core/contrib/diff-highlight/diff-highlight /opt/homebrew/bin/

  # echo 'Install apps by Homebrew'
  # brew bundle

  ###############
  # OSX settings
  ###############
  # ネットワークボリュームに.DS_Storeを作らない
  defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
  # USBドライブに.DS_Shareを作らない
  defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
  # 隠しファイルの表示
  defaults write com.apple.finder AppleShowAllFiles -bool true
  # 拡張子変更時に警告しない
  defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
  # 未確認アプリケーション実行時のダイアログを無効
  defaults write com.apple.LaunchServices LSQuarantine -bool false
  # ライブラリディレクトリを表示
  sudo chflags nohidden ~/Library
  # /Volumes ディレクトリを表示
  sudo chflags nohidden /Volumes
  # Finderのタイトルバーにフルパスを表示
  defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
  # Quick Lookでテキストを選択可能に
  defaults write com.apple.finder QLEnableTextSelection -bool true
  # スクリーンショットの保存先を変更
  defaults write com.apple.screencapture location ${HOME}/SS/;killall SystemUIServer
  # スクリーンショットの画像から影のエフェクトを無くす
  defaults write com.apple.screencapture disable-shadow -bool true
  # スクリーンショットのファイル名を変更する
  defaults write com.apple.screencapture name cap
  # Enable "Tap to click"
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
  defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
  defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
  # キーリピートの時間
  defaults write NSGlobalDomain KeyRepeat -int 2
  # キーリピート認識までの時間
  defaults write NSGlobalDomain InitialKeyRepeat -int 15
  # Dockを自動的に非表示にする
  defaults write com.apple.dock autohide -bool true
  # Dockの拡大機能ON
  defaults write com.apple.dock magnification -bool true

elif type apt 1> /dev/null 2> /dev/null ; then

  # Install building tool
  sudo apt install -y build-essential python3-dev python3-pip

  # Install Developper tool
  sudo apt install byobu tig openssh-server

  # Install scipy dependencies
  sudo apt install -y gfortran liblapack-dev libblas-dev

  # Install matplotlib dependencies
  sudo apt install -y libtiff5-dev libjpeg8-dev zlib1g-dev
  sudo apt install -y libfreetype6-dev liblcms2-dev libwebp-dev

  # Install Java10
  sudo apt install openjdk-11-jre-headless

  # Set Japan timezone
  sudo ln -sf /usr/share/zoneinfo/Japan /etc/localtime

  if type xdg-user-dirs-gtk-update 1> /dev/null 2> /dev/null ; then
    # Install Developper tool
    sudo apt install vim-gnome

    # Rename directories
    LANG=C xdg-user-dirs-gtk-update

    # Diasble guest session
    sudo sh -c 'printf "[SeatDefaults]\nallow-guest=false\n" >/usr/share/lightdm/lightdm.conf.d/50-no-guest.conf'

    # Prevents Windows's clock from shifting
    sudo timedatectl set-local-rtc true

    # Change nautilus's address bar to text style
    gsettings set org.gnome.nautilus.preferences always-use-location-entry true

    # mount exFAT
    sudo apt-get install exfat-fuse exfat-utils
  fi

  # Change setting clock server
  sudo sed -i 's/#NTP=/NTP=ntp.nict.jp/g' /etc/systemd/timesyncd.conf

  # git
  sudo install -m 0755 /usr/share/doc/git/contrib/diff-highlight/diff-highlight /usr/local/bin/
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
curl -o ~/.vim/colors/ChocolatePapaya.vim https://raw.githubusercontent.com/PrideChung/Vim/master/.vim/colors/ChocolatePapaya.vim

# Vim Python syntax checker
python3 -m pip install flake8 autopep8 autoflake --user
make_dir ~/.vim/plugin
make_dir ~/.vim/ftplugin
curl -o ~/.vim/plugin/python_flake8.vim https://raw.githubusercontent.com/nvie/vim-flake8/master/ftplugin/python_flake8.vim
curl -o ~/.vim/plugin/python_autopep8.vim https://raw.githubusercontent.com/tell-k/vim-autopep8/master/ftplugin/python_autopep8.vim
curl -o ~/.vim/ftplugin/python_autoflake.vim https://raw.githubusercontent.com/tell-k/vim-autoflake/master/ftplugin/python_autoflake.vim

make_dir ~/.vim/autoload
curl -o ~/.vim/autoload/flake8.vim https://raw.githubusercontent.com/nvie/vim-flake8/master/autoload/flake8.vim

# Vim Rainbow Parentheses Improved
curl -o ~/.vim/plugin/rainbow_main.vim https://raw.githubusercontent.com/luochen1990/rainbow/master/plugin/rainbow_main.vim
curl -o ~/.vim/autoload/rainbow.vim https://raw.githubusercontent.com/luochen1990/rainbow/master/autoload/rainbow.vim
curl -o ~/.vim/autoload/rainbow_main.vim https://raw.githubusercontent.com/luochen1990/rainbow/master/autoload/rainbow_main.vim

# Vim Scala syntax highlighting
mkdir -p ~/.vim/{ftdetect,indent,syntax} && for d in ftdetect indent syntax ; do curl  -o ~/.vim/$d/scala.vim https://raw.githubusercontent.com/derekwyatt/vim-scala/master/$d/scala.vim; done

# Vim indent guide
curl -o ~/.vim/autoload/color_helper.vim https://raw.githubusercontent.com/nathanaelkane/vim-indent-guides/master/autoload/color_helper.vim
curl -o ~/.vim/autoload/indent_guides.vim https://raw.githubusercontent.com/nathanaelkane/vim-indent-guides/master/autoload/indent_guides.vim
curl -o ~/.vim/plugin/indent_guides.vim https://raw.githubusercontent.com/nathanaelkane/vim-indent-guides/master/plugin/indent_guides.vim

# vim-isort
python3 -m pip install isort --user
curl -o ~/.vim/ftplugin/python_vimisort.vim https://raw.githubusercontent.com/fisadev/vim-isort/master/ftplugin/python_vimisort.vim

###############
# Jupyter magic
###############
python3 -m pip install jupyter --user
python3 -m pip install jupyter_contrib_nbextensions --user
export PATH=${HOME}/Library/Python/3.9/bin:${PATH}
jupyter contrib nbextension install --user
jupyter nbextension enable code_prettify/autopep8
jupyter nbextension enable code_prettify/isort
