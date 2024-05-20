# Sample script for Deployment
#!/bin/bash
cd /home/ubuntu
eval "$(ssh-agent)"
touch runDeployment
/bin/echo "cd /home/ubuntu
mkdir rt-deployment
chown -R ubuntu:ubuntu rt-deployment
cd /home/ubuntu/rt-deployment
ssh-add /home/ubuntu/.ssh/rt-messages-web
git clone git@bitbucket.org:dev_xyz/sample_repo.git
cd /home/ubuntu/rt-deployment/sample_repo
npm install
cd /home/ubuntu/rt-deployment/sample_repo/bin
forever server.js
echo "Deployment Process Done" " >> runDeployment
chown ubuntu:ubuntu runDeployment
/bin/bash /home/ubuntu/runDeployment
