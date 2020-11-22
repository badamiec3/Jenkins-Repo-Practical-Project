#!/bin/bash

if ! which docker > /dev/null; then
        sudo apt update
        curl https://get.docker.com | sudo bash
        sudo usermod -aG docker ubuntu
else 
        echo 'already installed'
fi


if ! which docker-compose > /dev/null; then 
        sudo apt install -y curl jq
        version=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | jq -r '.tag_name')
        sudo curl -L "https://github.com/docker/compose/releases/download/${version}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
        sudo chmod +x /usr/local/bin/docker-compose
else 
        echo 'already installed'
fi