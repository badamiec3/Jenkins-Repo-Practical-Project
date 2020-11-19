#! /bin/bash/

if ! which wget > /dev/null; then
        sudo apt-get update
        sudo apt install wget
fi

if ! which unzip > /dev/null; then
        sudo apt-get update
        sudo apt install unzip
fi

if ! which terraform > /dev/null; then
        wget https://releases.hashicorp.com/terraform/0.13.5/terraform_0.13.5_linux_amd64.zip
        unzip terraform_0.13.5_linux_amd64.zip
        sudo mv terraform /usr/bin/
        rm -r terraform_0.13.5_linux_amd64.zip
        echo "The terraform version is:"  
        terraform --version      
fi