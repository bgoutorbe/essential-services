SHELL := /bin/bash

_ := $(shell useradd -r --uid 1000 jenkins && usermod -aG docker jenkins)
UID_JENKINS_DOCKER := $(shell id -u jenkins)
export UID_JENKINS_DOCKER

GID_JENKINS_DOCKER := $(shell cut -d':' -f3<<<`getent group docker`)
export GID_JENKINS_DOCKER

all: build up

build: docker-compose.yml
	@echo id of user and docker group: $(UID_JENKINS_DOCKER):$(GID_JENKINS_DOCKER)
	docker-compose build

up:
	@echo id of user and docker group: $(UID_JENKINS_DOCKER):$(GID_JENKINS_DOCKER)
	docker-compose up -d
