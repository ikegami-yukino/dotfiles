@echo off

SET USER=etern

curl -L https://raw.githubusercontent.com/ikegami-yukino/dotfiles/master/.flake8 > C:\Users\%USER%\.flake8

curl -L https://raw.githubusercontent.com/ikegami-yukino/dotfiles/master/_vimrc > C:\Users\%USER%\_vimrc
curl -L https://raw.githubusercontent.com/ikegami-yukino/dotfiles/master/_gvimrc > C:\Users\%USER%\_gvimrc
md C:\Users\%USER%\vimfiles

echo Vim Python syntax checker
md C:\Users\%USER%\vimfiles\ftplugin
curl -L https://raw.githubusercontent.com/nvie/vim-flake8/master/ftplugin/python_flake8.vim > C:\Users\%USER%\vimfiles\ftplugin\python_flake8.vim
curl -L https://raw.githubusercontent.com/tell-k/vim-autopep8/master/ftplugin/python_autopep8.vim > C:\Users\%USER%\vimfiles\ftplugin\python_autopep8.vim
md C:\Users\%USER%\.vim\autoload
curl -L https://raw.githubusercontent.com/nvie/vim-flake8/master/autoload/flake8.vim > C:\Users\%USER%\vimfiles\autoload\flake8.vim

echo Download ChocolatePapaya color for Vim
md C:\Users\%USER%\.vim\colors
curl -L https://raw.githubusercontent.com/PrideChung/Vim/master/.vim/colors/ChocolatePapaya.vim > C:\Users\%USER%\vimfiles\colors\ChocolatePapaya.vim

echo Vim Scala syntax highlighting
for %%d in (ftdetect indent syntax) ; do (
  md C:\Users\%USER%\vimfiles\%%d
  curl -L https://raw.githubusercontent.com/derekwyatt/vim-scala/master/%%d/scala.vim > C:\Users\%USER%\vimfiles\%%d\scala.vim;
)

echo Vim isort
curl -L https://raw.githubusercontent.com/fisadev/vim-isort/master/ftplugin/python_vimisort.vim > C:\Users\%USER%\vimfiles\ftplugin\python_vimisort.vim

echo Vim Rainbow Parentheses Improved
md C:\Users\%USER%\vimfiles\plugin
curl -L https://raw.githubusercontent.com/luochen1990/rainbow/master/plugin/rainbow_main.vim > C:\Users\%USER%\vimfiles\plugin\rainbow_main.vim
curl -L https://raw.githubusercontent.com/luochen1990/rainbow/master/autoload/rainbow.vim > C:\Users\%USER%\vimfiles\autoload\rainbow.vim
curl -L https://raw.githubusercontent.com/luochen1990/rainbow/master/autoload/rainbow_main.vim > C:\Users\%USER%\vimfiles\autoload\rainbow_main.vim
