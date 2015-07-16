#!/bin/bash

packages=(liblas python python-pip ruby scalar emacs emacs24 emacs24-el emacs24-common-non-dfsg boost leveldb gflags opencv hdf5 gcc glob protobuf git curl openssl gradle snappy ag lmdb re2)
if [[ "${OSTYPE}" =~ "darwin"* ]];
then
    # ---  OSX ---- #
    # ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    # sudo chown root /usr/local/bin/brew
    INSTALL="sudo brew install"
    brew tap homebrew/science
else
    INSTALL="sudo apt-get install -y"
    sudo add-apt-repository ppa:cassou/emacs
    sudo apt-get update
    sudo easy_install -U distribute
    packages+=(gfortran libopenblas-dev liblapack-dev libpng-dev libfreetype6-dev)
fi

for package in ${packages[*]}; do
    ${INSTALL} $package
done

python_packages=(numpy pandas nltk gensim scipy stemming ipython==3.2.1 "ipython[notebook]" protobuf requests nose scikit-learn scikit-image mock re2 jinja2 jsonschema functools32 pyzmq tornado matplotlib)
for package in ${python_packages[*]}; do
    sudo pip install ${package}
done
