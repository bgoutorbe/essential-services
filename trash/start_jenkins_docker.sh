#!/bin/bash

# creating volume for data
echo "Creating volume jenkins_data"
docker volume create jenkins_data

# creating network
echo "Creating network cmarb-net"
docker network create cmarb-net

# creating system user jenkins and adding it to docker group
echo "creating user jenkins and adding it to docker group"
useradd -r --uid 1000 jenkins
usermod -aG docker jenkins

# getting user id of jenkins and group id of docker to pass them to container
# so that it can access docker daemon on host
uid=$(id -u jenkins)
gid=$(cut -d':' -f3<<<`getent group docker`)
echo "Got user jenkins uid=$uid, group docker gid=$gid"

# running docker
docker run \
    -d --rm \
    --name jenkins \
    --user $uid:$gid \
    --network cmarb-net \
    -p 8080:8080 -p 50000:50000 \
    -v jenkins_data:/var/jenkins_home \
    -v /var/run/docker.sock:/var/run/docker.sock \
    --env JAVA_OPTS="-Dorg.apache.commons.jelly.tags.fmt.timeZone=Europe/Paris" \
    h1kkan/jenkins-docker:lts-alpine
