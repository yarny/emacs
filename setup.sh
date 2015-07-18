#!/bin/bash

if [[ "${OSTYPE}" =~ "darwin"* ]];
then
    # ---  OSX ---- #
    # ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    # sudo chown root /usr/local/bin/brew
    brew tap homebrew/science
    for package in $(cat osx/requirements.txt)
    do
	sudo brew install $package
    done
else
    # --- Ubuntu -- #
    for package in $(cat ubuntu/requirements.txt)
    do
	sudo apt-get install -y $package
    done
    sudo easy_install -U distribute

    # -- emacs24 --- #
    sudo add-apt-repository -y ppa:cassou/emacs
    sudo apt-get install -y emacs24 emacs24-el emacs24-common-non-dfsg
fi

# --- Python --- #
for package in $(cat python/requirements.txt)
do
    sudo pip install $package
done
