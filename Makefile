APP_NAME?=pyflask
GIT_COMMIT=$(shell git rev-parse --short HEAD)
DOCKER_REGISTRY_USER?=arboulahdour
DOCKER_IMAGE_TAG?=v0.1.0
DOCKER_INTERNAL_PORT=5000
DOCKER_EXTERNAL_PORT=5000

.PHONY: all

default: all

install:
	pip install -r requirements.txt

test:
	python3 -m pytest --import-mode=append tests/

build:
	docker build -t $(APP_NAME):$(GIT_COMMIT) .

tag:
	docker tag $(APP_NAME):$(GIT_COMMIT) $(APP_NAME):$(DOCKER_IMAGE_TAG)
	docker tag $(APP_NAME):$(GIT_COMMIT) $(DOCKER_REGISTRY_USER)/$(APP_NAME):$(DOCKER_IMAGE_TAG)
	docker tag $(APP_NAME):$(GIT_COMMIT) $(DOCKER_REGISTRY_USER)/$(APP_NAME):latest

deploy:
	docker run --name $(APP_NAME) -e VERSION=$(DOCKER_IMAGE_TAG) -p $(DOCKER_EXTERNAL_PORT):$(DOCKER_INTERNAL_PORT) -d $(APP_NAME):$(DOCKER_IMAGE_TAG)

all: install test build tag deploy

clean-container:
	docker rm --force $(APP_NAME)

clean-image:
	docker rmi $(APP_NAME):$(GIT_COMMIT)
	docker rmi $(APP_NAME):$(DOCKER_IMAGE_TAG)
	docker rmi $(DOCKER_REGISTRY_NAME)/$(APP_NAME):$(DOCKER_IMAGE_TAG)
	docker rmi $(DOCKER_REGISTRY_NAME)/$(APP_NAME):latest

clean: clean-container clean-image