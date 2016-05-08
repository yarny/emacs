#!/bin/bash


function InstallBazel() {
    if [ ! -z `which bazel` ]; then
	echo return
    fi

    #sudo add-apt-repository ppa:webupd8team/java
    #sudo apt-get update
    #sudo apt-get install oracle-java8-installer
    wget https://github.com/bazelbuild/bazel/releases/download/0.1.3/bazel-0.1.3-installer-linux-x86_64.sh
    chmod +x ./bazel-0.1.3-installer-linux-x86_64.sh
    sudo ./bazel-0.1.3-installer-linux-x86_64.sh
    sudo chown $USER /home/$USER/.cache/bazel/
}

# -- emacs24 --- #
EMACS_VERSION=`emacs --version`

if [[ ! $EMACS_VERSION =~ "24" ]]; then
    sudo add-apt-repository -y ppa:cassou/emacs
    sudo apt-get update
    sudo apt-get install -y emacs24 emacs24-el emacs24-common-non-dfsg
fi

InstallBazel
