#!/bin/bash


function CopyProfileFiles() {
    cp .screenrc ~
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

function InstallGlog()  {
    WORK_DIR=$PWD
    wget https://google-glog.googlecode.com/files/glog-0.3.3.tar.gz
    tar zxvf glog-0.3.3.tar.gz
    cd glog-0.3.3
    ./configure
    make && sudo make install
    cd $WORK_DIR
}

function InstallGflags() {
    WORK_DIR=$PWD
    wget https://github.com/schuhschuh/gflags/archive/master.zip
    unzip -o master.zip
    cd gflags-master
    mkdir build && cd build
    export CXXFLAGS="-fPIC" && cmake .. && make VERBOSE=1
    make && sudo make install
    cd $WORK_DIR
}

function InstallCMake() {
    WORK_DIR=$PWD
    wget http://www.cmake.org/files/v2.8/cmake-2.8.12.tar.gz
    tar zxvf cmake-2.8.12.tar.gz
    cd cmake-2.8.12
    ./bootstrap; make; sudo make install
    cd $WORK_DIR
}

function InstallLmdb() {
    WORK_DIR=$PWD
    git clone https://github.com/LMDB/lmdb.git
    cd lmdb/libraries/liblmdb
    make && sudo make install
    cd $WORK_DIR
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
    if [[ $SYSTEM_TYPE =~ "12" ]];
    then
	InstallCMake
	InstallGlog
	InstallGflags
	InstallLmdb
    fi

    for package in $(cat ubuntu/requirements.txt)
    do
	sudo apt-get install -y $package
    done
    sudo easy_install -U distribute

    # -- emacs24 --- #
    sudo add-apt-repository -y ppa:cassou/emacs
    sudo apt-get update
    sudo apt-get install -y emacs24 emacs24-el emacs24-common-non-dfsg
else
    echo "Unknown System type"
fi

# --- Python --- #
for package in $(cat python/requirements.txt)
do
    sudo pip install $package
done
