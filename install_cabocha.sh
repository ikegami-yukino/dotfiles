#!/usr/bin/env bash

git clone --depth=1 https://github.com/taku910/cabocha /tmp/cabocha
pushd
cd cabocha
curl -O https://raw.githubusercontent.com/humem/cabocha/patch/install-sh
curl -O https://raw.githubusercontent.com/humem/cabocha/patch/missing
./configure --with-charset=utf8 --enable-utf8-only
make
sudo make install
popd
rm -rf /tmp/cabocha
