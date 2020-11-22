#!/bin/bash

if ! which aws > /dev/null; then
        sudo apt update
        sudo apt install awscli -y
        echo "The awscli version is:"
        aws --version
else 
        echo 'already installed'
fi

