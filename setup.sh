#!/bin/bash


function CopyProfileFiles() {
    cp .screenrc ~
    cp .bazelrc ~
    mkdir -p ~/.emacs.d
    cp init.el ~/.emacs.d
}

function SystemType() {
    if [[ "${OSTYPE}" =~ "darwin"* ]];
    then
	echo "OSX"
	return
    elif [[ $(lsb_release -r) =~ "14" ]];
    then
	echo "Ubuntu14"
	return
    elif [[ $(lsb_release -r) =~ "12" ]];
    then
	echo "Ubuntu12"
	return
    else
	echo "Unknown"
    fi
}

function GitAliases() {
    git config --global alias.co checkout
    git config --global alias.br branch
    git config --global alias.ci commit
    git config --global alias.st status
}

if [[ ! -e ~/.emacs.d/init.el ]];
then
    CopyProfileFiles
fi

SYSTEM_TYPE=$(SystemType)

if [[ $SYSTEM_TYPE =~ "OSX" ]];
then
    if [[ ! -e /usr/local/bin/brew ]];
    then
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	sudo chown root /usr/local/bin/brew
    fi

    brew tap homebrew/science
    for package in $(cat osx/requirements.txt)
    do
	sudo brew install $package
    done
elif [[ $SYSTEM_TYPE =~ "Ubuntu" ]];
then
    sudo apt-get install -y software-properties-common
    sudo add-apt-repository -y ppa:george-edison55/cmake-3.x
    sudo apt-get update
    for package in $(cat ubuntu/requirements.txt)
    do
	sudo apt-get install -y $package
    done
    sudo easy_install -U distribute

    ./ubuntu/setup.sh
else
    echo "Unknown System type"
fi

GitAliases

# --- Python --- #
for package in $(cat python/requirements.txt)
do
    sudo pip install $package
done
