#!/bin/bash
cd /home/ubuntu
eval "$(ssh-agent)"
mkdir Deployments
chown -R ubuntu:ubuntu Deployments
cd Deployments
ssh-add /home/ubuntu/.ssh/rt-messages-web
git clone git@bitbucket.org:dev_xyz/sample_repo.git && chown -R ubuntu:ubuntu sample-repo 
cd sample-repo 
npm install && cd bin
forever start server.js
echo "Deployment Process Done"

