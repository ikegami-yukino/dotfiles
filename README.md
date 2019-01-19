# dotfiles

## install on Mac / Linux

`curl -L https://raw.githubusercontent.com/ikegami-yukino/dotfiles/master/install.sh | bash`

## Install on Windows
On administrative WIndows Power shell

(スタートを押しながらXを押し、メニューが出たらAを押す.)
```
Set-ExecutionPolicy Bypass; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

curl -LO https://raw.githubusercontent.com/ikegami-yukino/dotfiles/master/packages.config
choco install packages.config

curl -LO https://raw.githubusercontent.com/ikegami-yukino/dotfiles/master/windows.bat
windows.bat
```
