APP_NAME?=pyflask
DOCKER_REGISTRY_NAME?=docker.io
DOCKER_IMAGE_TAG?=latest
DOCKER_INTERNAL_PORT=5000
DOCKER_EXTERNAL_PORT=5000

.PHONY: all

default: all

install:
	pip install -r requirements.txt

test:
	python3 -m pytest --import-mode=append tests/

build:
	docker build -t $(APP_NAME):$(DOCKER_IMAGE_TAG) .

deploy:
	docker run --name $(APP_NAME) -p $(DOCKER_EXTERNAL_PORT):$(DOCKER_INTERNAL_PORT) -d $(APP_NAME):$(DOCKER_IMAGE_TAG)

all: install test build deploy

clean-container:
	docker rm --force $(APP_NAME)

clean-image:
	docker rmi $(APP_NAME):$(DOCKER_IMAGE_TAG)

clean: clean-container clean-image