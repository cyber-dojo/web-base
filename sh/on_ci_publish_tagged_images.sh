#!/usr/bin/env bash
set -Eeu

readonly ROOT_DIR="$(cd "$(dirname "${0}")" && cd .. && pwd)"
source "${ROOT_DIR}/sh/lib.sh"
export $(echo_env_vars)

on_ci_publish_tagged_images()
{
  if ! on_ci; then
    echo 'not on CI so not publishing tagged images'
    return
  fi
  echo 'on CI so publishing tagged images'
  echo "${DOCKER_PASS}" | docker login --username "${DOCKER_USER}" --password-stdin
  docker push "${CYBER_DOJO_WEB_BASE_IMAGE}"
  docker logout
}

on_ci()
{
  [ -n "${CI:-}" ]
}

on_ci_publish_tagged_images
