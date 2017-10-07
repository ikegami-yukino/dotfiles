@echo off

SET USER=etern

bitsadmin.exe /TRANSFER htmlget https://raw.githubusercontent.com/ikegami-yukino/dotfiles/master/.vimrc  C:\Users\%USER%\.vimrc
md C:\Users\%USER%\.vim
md C:\Users\%USER%\.vim\tmp
md C:\Users\%USER%\.vim\backup
md C:\Users\%USER%\.vim\undo

echo Vim Python syntax checker
md C:\Users\%USER%\.vim\plugin
bitsadmin.exe /TRANSFER htmlget https://raw.githubusercontent.com/nvie/vim-flake8/master/ftplugin/python_flake8.vim C:\Users\%USER%\.vim\plugin\python_flake8.vim 
bitsadmin.exe /TRANSFER htmlget https://raw.githubusercontent.com/tell-k/vim-autopep8/master/ftplugin/python_autopep8.vim C:\Users\%USER%\.vim\plugin\python_autopep8.vim
md C:\Users\%USER%\.vim\autoload
bitsadmin.exe /TRANSFER htmlget https://raw.githubusercontent.com/nvie/vim-flake8/master/autoload/flake8.vim C:\Users\%USER%\.vim\autoload\flake8.vim 

echo Download ChocolatePapaya color for Vim
md C:\Users\%USER%\.vim\colors
bitsadmin.exe /TRANSFER htmlget https://raw.githubusercontent.com/PrideChung/Vim/master/.vim/colors/ChocolatePapaya.vim C:\Users\%USER%\.vim\colors\ChocolatePapaya.vim

echo Vim Scala syntax highlighting
for %%d in (ftdetect indent syntax) ; do (
  md C:\Users\%USER%\.vim\%%d
  bitsadmin.exe /TRANSFER htmlget https://raw.githubusercontent.com/derekwyatt/vim-scala/master/%%d/scala.vim  C:\Users\%USER%\.vim\%%d\scala.vim;
)

echo Vim indent guide
bitsadmin.exe /TRANSFER htmlget https://raw.githubusercontent.com/nathanaelkane/vim-indent-guides/master/autoload/color_helper.vim C:\Users\%USER%\.vim\autoload\color_helper.vim 
bitsadmin.exe /TRANSFER htmlget https://raw.githubusercontent.com/nathanaelkane/vim-indent-guides/master/autoload/indent_guides.vim C:\Users\%USER%\.vim\autoload\indent_guides.vim 
bitsadmin.exe /TRANSFER htmlget https://raw.githubusercontent.com/nathanaelkane/vim-indent-guides/master/plugin/indent_guides.vim C:\Users\%USER%\.vim\plugin\indent_guides.vim 

echo Install Chocolatey
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
