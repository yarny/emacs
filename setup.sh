#!/bin/bash
#install brew
# ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# sudo chown root /usr/local/bin/brew
echo ${OSTYPE}

if [[ "${OSTYPE}" =~ "darwin"* ]];
then
    INSTALL="sudo brew install"
    brew tap homebrew/science
else
    INSTALL="sudo apt-get"
fi

packages=(liblas python ruby scalar emacs boost leveldb gflags opencv hdf5 gcc glob protobuf git curl openssl gradle snappy ag)

for package in ${packages[*]}; do
    ${INSTALL} $package
done
exit

python_packages=(numpy pandas nltk gensim scipy stemming ipython "ipython[notebook]" protobuf)
for package in ${python_packages[*]}; do
    sudo pip install ${package}
done
