#! /bin/bash

ssh -i /home/jenkins/.ssh/id_rsa ubuntu@10.0.1.18 << EOF
cd /home/ubuntu/Jenkins-Repo-Practical-Project
docker exec backend bash -c "pytest tests/ --cov application"  | grep passed
EOF

