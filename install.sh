if [ "$(uname)" == 'Darwin' ]; then
  # Install usefull commands
  xcode-select --install
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew install tig nkf wget coreutils gnu-sed python3

  # Install Java
  brew tap phinze/homebrew-cask
  brew install brew-cask
  brew tap caskroom/versions

  brew cask install java

  # Install Ricty font
  brew tap sanemat/font
  brew install Caskroom/cask/xquartz ricty
  cp -f /usr/local/Cellar/ricty/3.2.4/share/fonts/Ricty*.ttf ~/Library/Fonts/
  fc-cache -vf

  # Install GUI apps
  brew cask install skype macvim-kaoriya totalspaces flux google-chrome firefox dropbox mendeley-desktop iterm2 appcleaner

  # for heavy development machine
  # brew cask install eclipse-java virtualbox vagrant

  # for media server
  # brew cask install lyrics-master bettertouchtool no-ip-duc vlc

  # Download ChocolatePapaya color for Vim
  mkdir -p ~/.vim/colors
  wget -O ~/.vim/colors/ChocolatePapaya.vim https://raw.githubusercontent.com/PrideChung/Vim/master/.vim/colors/ChocolatePapaya.vim

  # misc
  defaults write com.apple.desktopservices DSDontWriteNetworkStores true
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
  OS='Linux'
fi

# Make Vim cache dir
mkdir -p ~/.vim/backup ~/.vim/tmp

# Vim Python syntax checker
mkdir -p ~/.vim/plugin
wget -O ~/.vim/plugin/python_flake8.vim https://raw.githubusercontent.com/nvie/vim-flake8/master/ftplugin/python_flake8.vim
wget -O ~/.vim/plugin/python_autopep8.vim https://raw.githubusercontent.com/tell-k/vim-autopep8/master/ftplugin/python_autopep8.vim

mkdir -p ~/.vim/autoload
wget -O ~/.vim/autoload/flake8.vim https://raw.githubusercontent.com/nvie/vim-flake8/master/autoload/flake8.vim

# Vim Scala syntax highlighting
mkdir -p ~/.vim/{ftdetect,indent,syntax} && for d in ftdetect indent syntax ; do wget --no-check-certificate -O ~/.vim/$d/scala.vim https://raw.githubusercontent.com/derekwyatt/vim-scala/master/$d/scala.vim; done

# Vim indent guide
wget -O ~/.vim/autoload/color_helper.vim https://raw.githubusercontent.com/nathanaelkane/vim-indent-guides/master/autoload/color_helper.vim
wget -O ~/.vim/autoload/indent_guides.vim https://raw.githubusercontent.com/nathanaelkane/vim-indent-guides/master/autoload/indent_guides.vim
wget -O ~/.vim/plugin/indent_guides.vim https://raw.githubusercontent.com/nathanaelkane/vim-indent-guides/master/plugin/indent_guides.vim

# Jupyter notebook settings
if [ ! -f ${HOME}/.ipython/profile_default ]; then
  mkdir -p ${HOME}/.ipython/profile_default
fi
cp .ipython/profile_default/* ${HOME}/.ipython/profile_default/

cp .* ~/
