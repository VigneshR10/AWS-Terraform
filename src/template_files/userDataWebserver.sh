#!/bin/bash
cd /home/ubuntu
eval "$(ssh-agent)"
mkdir Deployments
chown -R ubuntu:ubuntu Deployments
cd Deployments
ssh-add /home/ubuntu/.ssh/rt-messages-web
git clone git@bitbucket.org:xxx/webserver.git && chown -R ubuntu:ubuntu webserver 
cd webserver
npm install && cd bin
forever start server.js
echo "Deployment Process Done"
