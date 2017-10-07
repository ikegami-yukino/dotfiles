#!/usr/bin/env bash
set -eu

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

homebrewcask lyrics-master bettertouchtool vlc no-ip-duc
