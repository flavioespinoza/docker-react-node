NAME   := flavioespinoza/docker-react-node
TAG    := $(shell git rev-parse --abbrev-ref HEAD)
IMG    := ${NAME}:${TAG}

.PHONY: test

build:
	@make build-docker

build-docker:
	@echo "***** Docker Build & Push Image: " ${IMG} "*****"
	
	yarn run docker:prep
	yarn run docker:build

build-drone:
	yarn run docker:prep

test:
	@echo "** Testing **"
	yarn install
	yarn run test

lint:
	@echo "** Linting **"
	yarn install
	yarn run tslint
