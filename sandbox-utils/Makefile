SHELL := /bin/bash
GID_JENKINS_DOCKER := $(shell cut -d':' -f3<<<`getent group docker`)
export GID_JENKINS_DOCKER

all: build up

build: docker-compose.yml .env jenkins/Dockerfile
	@echo id of docker group: $(GID_JENKINS_DOCKER)
	docker-compose build

up:
	@echo id of docker group: $(GID_JENKINS_DOCKER)
	docker-compose up -d