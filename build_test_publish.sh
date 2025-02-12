#!/bin/bash -Eeu

readonly SH_DIR="$(cd "$( dirname "${0}" )/sh" && pwd)"

"${SH_DIR}/build_docker_image.sh"
"${SH_DIR}/on_ci_publish_tagged_images.sh"
