export DOCKERHUB_USER=mslocrian
export DOCKERHUB_REPO=docker-openconnect-vpn
export DOCKERHUB_VERSION=1.0.1

build:
	@docker build -f Dockerfile --no-cache -t $(DOCKERHUB_REPO):$(DOCKERHUB_VERSION) .

push: DOCKER_IMAGE_ID = $(shell docker images -q $(DOCKERHUB_REPO):$(DOCKERHUB_VERSION))
push:
	docker tag $(DOCKER_IMAGE_ID) $(DOCKERHUB_USER)/$(DOCKERHUB_REPO):latest
	docker push $(DOCKERHUB_USER)/$(DOCKERHUB_REPO):latest
	docker tag $(DOCKER_IMAGE_ID) $(DOCKERHUB_USER)/$(DOCKERHUB_REPO):$(DOCKERHUB_VERSION)
	docker push $(DOCKERHUB_USER)/$(DOCKERHUB_REPO):$(DOCKERHUB_VERSION)
