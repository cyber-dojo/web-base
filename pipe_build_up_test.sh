#!/bin/bash
set -e

readonly MY_DIR="$( cd "$( dirname "${0}" )" && pwd )"

"${MY_DIR}/.circleci/build_docker_image.sh"
