#!/bin/bash

if [[ "${OSTYPE}" =~ "darwin"* ]];
then
    # ---  OSX ---- #
    # ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    # sudo chown root /usr/local/bin/brew
    brew tap homebrew/science
    cat osx/requirements.txt | xargs sudo brew install
else
    # --- Ubuntu -- #
    sudo add-apt-repository ppa:cassou/emacs
    cat ubuntu/requirements.txt | xargs sudo aptitude install -y
    sudo easy_install -U distribute
fi

# --- Python --- #
pip install -r python/requirements.txt
