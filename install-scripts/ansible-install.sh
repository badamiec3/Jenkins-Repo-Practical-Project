#! /bin/bash/

if ! which ansible > /dev/null; then
        mkdir -p ~/.local/bin
        echo 'PATH=$PATH:~/.local/bin' >> ~/.bashrc
        source ~/.bashrc
        pip3 install --user ansible
        echo "The ansible version is:"
        ansible --version
fi
