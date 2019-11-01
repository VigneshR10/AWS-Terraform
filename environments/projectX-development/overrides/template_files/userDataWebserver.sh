#!/bin/bash
cd /home/ubuntu
eval "$(ssh-agent)"
touch runDeployment
/bin/echo "cd /home/ubuntu
mkdir rt-deployment
chown -R ubuntu:ubuntu rt-deployment
cd /home/ubuntu/rt-deployment
ssh-add /home/ubuntu/.ssh/rt-messages-web
git clone git@bitbucket.org:dev_teezle/dataviewer-webserver.git
cd /home/ubuntu/rt-deployment/dataviewer-webserver
npm install
cd /home/ubuntu/rt-deployment/dataviewer-webserver/bin
forever web-ui-server.js
echo "Deployment Process Done" " >> runDeployment
chown ubuntu:ubuntu runDeployment
/bin/bash /home/ubuntu/runDeployment
