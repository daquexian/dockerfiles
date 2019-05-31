#! /usr/bin/env bash

set -e

sed -i 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
apt update

apt install -y software-properties-common 

add-apt-repository -y ppa:neovim-ppa/stable
add-apt-repository -y ppa:deadsnakes/ppa
apt update

apt install -y python python3.7 neovim build-essential autoconf automake libtool make gcc g++ curl wget tar libevent-dev libncurses-dev unzip

TMUX_VERSION=2.8
wget https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz
tar xf tmux-${TMUX_VERSION}.tar.gz
rm -f tmux-${TMUX_VERSION}.tar.gz
pushd tmux-${TMUX_VERSION}
./configure
make
sudo make install
popd
rm -rf tmux-*

curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3.7 get-pip.py
pip3 install cmake

python get-pip.py
