#!/bin/bash
#install brew
# ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# sudo chown root /usr/local/bin/brew

brew tap homebrew/science
for package in liblas python ruby scalar emacs boost leveldb gflags opencv hdf5 gcc glob protobuf git curl openssl gradle snappy ag; do
    sudo brew install ${package}
done

for package in numpy pandas nltk gensim scipy stemming ipython "ipython[notebook]" protobuf; do
    sudo pip install ${package}
done
