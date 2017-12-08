#!/bin/bash

# See: https://github.com/gibiansky/IHaskell

sudo apt-get install -y libtinfo-dev libzmq3-dev libcairo2-dev libpango1.0-dev libmagic-dev libblas-dev liblapack-dev

virtualenv -p python3.5 venv
venv/bin/pip install --upgrade pip
source venv/bin/activate

# NOTE: also add $HOME/.local/bin to PATH in ~/.profile
export PATH=$PATH:/$HOME/.local/bin

mkdir -p ~/IHaskell
pushd ~/IHaskell
curl -sSL https://get.haskellstack.org/ | sh
git clone https://github.com/gibiansky/IHaskell .
pip install -r requirements.txt
stack install gtk2hs-buildtools
stack install --fast
ihaskell install --stack
popd
