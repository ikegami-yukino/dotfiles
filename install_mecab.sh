git clone --depth=1 https://github.com/ikegami-yukino/mecab
cd mecab/mecab
./configure  --enable-utf8-only
make
sudo make install
sudo ldconfig
cd ../mecab-ipadic/
./configure --with-charset=utf8
make
sudo make install
cd ../../
rm -rf mecab
