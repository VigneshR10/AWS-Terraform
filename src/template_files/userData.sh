#!/bin/bash
cd /home/ubuntu
mkdir rt-deployment
chown -R ubuntu:ubuntu rt-deployment
cd /home/ubuntu/rt-deployment
eval "$(ssh-agent)"
ssh-add /home/ubuntu/.ssh/rt-messages-web
git clone git@bitbucket.org:xxx/webserver.git
cd /home/ubuntu/rt-deployment/webserver
npm install
cd /home/ubuntu/rt-deployment/webserver/bin
forever server.js
echo "Deployment Process Done"