#!/bin/bash -Eeu

# - - - - - - - - - - - - - - - - - - - - - - - -
on_ci_publish_tagged_images()
{
  if ! on_ci; then
    echo 'not on CI so not publishing tagged images'
    return
  fi
  echo 'on CI so publishing tagged images'
  local -r image="$(image_name)"
  local -r sha="$(image_sha)"
  local -r tag=${sha:0:7}
  echo "${DOCKER_PASS}" | docker login --username "${DOCKER_USER}" --password-stdin
  docker push ${image}:latest
  docker push ${image}:${tag}
  docker logout
}

# - - - - - - - - - - - - - - - - - - - - - - - -
on_ci()
{
  [ -n "${CI:-}" ]
}

#- - - - - - - - - - - - - - - - - - - - - - - -
image_name()
{
  echo cyberdojo/web-base
}

#- - - - - - - - - - - - - - - - - - - - - - - -
image_sha()
{
  docker run --rm "$(image_name):latest" sh -c 'echo ${SHA}'
}

# - - - - - - - - - - - - - - - - - - - - - - - -
on_ci_publish_tagged_images
