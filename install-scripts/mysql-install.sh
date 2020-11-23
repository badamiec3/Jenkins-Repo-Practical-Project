#! /bin/bash/

if ! which mysql > /dev/null; then 
	sudo apt-get update
	sudo apt install mysql-client-core-5.7 -y
        echo "The mysql version is:"  
        mysql --version
fi


