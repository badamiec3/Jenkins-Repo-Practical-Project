#! /bin/bash

ssh -i /home/jenkins/.ssh/id_rsa ubuntu@10.0.1.18 << EOF
cd /home/ubuntu/
sudo rm -r Jenkins-Repo-Practical-Project
git clone https://github.com/badamiec3/Jenkins-Repo-Practical-Project.git
cd /home/ubuntu/Jenkins-Repo-Practical-Project
docker-compose up -d
docker exec frontend bash -c "pytest tests/ --cov application" | grep passed
EOF
