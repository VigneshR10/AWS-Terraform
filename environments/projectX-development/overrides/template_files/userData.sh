#!/bin/bash
cd /home/ubuntu
eval "$(ssh-agent)"
mkdir Deployments
chown -R ubuntu:ubuntu Deployments
cd Deployments
ssh-add /home/ubuntu/.ssh/rt-messages-web
git clone git@bitbucket.org:dev_teezle/dataviewer-webserver.git && chown -R ubuntu:ubuntu dataviewer-webserver 
cd dataviewer-webserver
npm install && cd bin
forever start web-ui-server.js
echo "Deployment Process Done"

