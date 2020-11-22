#!/bin/bash

if ! which pytest > /dev/null; then
        sudo apt update -y
        sudo apt install python-pytest -y
        echo "The pytest version is:"
        pytest --version
else 
        echo 'already installed'
fi
