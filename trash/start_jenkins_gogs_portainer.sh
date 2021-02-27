#!/bin/bash

# creating system user jenkins and adding it to docker group
echo "creating user jenkins and adding it to docker group"
useradd -r --uid 1000 jenkins
usermod -aG docker jenkins

# getting user id of jenkins and group id of docker to pass them to container
# so that it can access docker daemon on host
export uid=$(id -u jenkins)
export gid=$(cut -d':' -f3<<<`getent group docker`)
echo "Got user jenkins uid=$uid, group docker gid=$gid"

# running all services: Jenkins, gogs and portainer
docker-compose up -d

