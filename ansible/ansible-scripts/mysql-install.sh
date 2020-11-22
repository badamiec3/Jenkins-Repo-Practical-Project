#!/bin/bash

if ! which mysql > /dev/null; then
        sudo apt update -y
        sudo apt install mysql-client-core-5.7 -y
        echo "The mysql version is:"
        mysql --version
else 
        echo 'already installed'
fi