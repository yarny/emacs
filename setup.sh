#!/bin/bash


if [[ "${OSTYPE}" =~ "darwin"* ]];
then
    # ---  OSX ---- #
    # ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    # sudo chown root /usr/local/bin/brew
    INSTALL="sudo brew install"
    brew tap homebrew/science
else
    INSTALL="sudo apt-get"
fi

packages=(liblas python ruby scalar emacs boost leveldb gflags opencv hdf5 gcc glob protobuf git curl openssl gradle snappy ag lmdb re2)

for package in ${packages[*]}; do
    ${INSTALL} $package
done

python_packages=(numpy pandas nltk gensim scipy stemming ipython "ipython[notebook]" protobuf requests nose scikit-learn scikit-image mock re2)
for package in ${python_packages[*]}; do
    sudo pip install ${package}
done
