
.PHONY: image snyk-container-scan

image:
	@${PWD}/sh/build_image.sh

snyk-container-scan:
	@${PWD}/sh/snyk_container_scan.sh

