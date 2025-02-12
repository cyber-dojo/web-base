
SHORT_SHA := $(shell git rev-parse HEAD | head -c7)
IMAGE_NAME := cyberdojo/web-base:${SHORT_SHA}

.PHONY: image snyk-container

image:
	${PWD}/sh/build_docker_image.sh


snyk-container: image
	snyk container test ${IMAGE_NAME} \
		--file=Dockerfile \
		--policy-path=.snyk \
		--sarif \
		--sarif-file-output=snyk.container.scan.json

