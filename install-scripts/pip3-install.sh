#! /bin/bash/

if ! which python3 > /dev/null; then
        sudo apt-get update
        sudo apt install python3 -y
        echo "The python3 version is:"
        python3 --version
fi

if ! which pip3 > /dev/null; then
        sudo apt update
        sudo apt install python3-pip -y
        echo "The pip3 version is:"
        pip3 --version
fi

