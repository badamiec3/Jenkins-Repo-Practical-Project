#! /bin/bash/

if ! which awscli > /dev/null; then
        sudo apt update
        sudo apt install awscli -y
        echo "The awscli version is:"
        aws --version
fi

