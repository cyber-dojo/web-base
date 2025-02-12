#!/usr/bin/env bash
set -Eeu

readonly ROOT_DIR="$(cd "$(dirname "${0}")" && cd .. && pwd)"

echo_env_vars()
{
  echo "CYBER_DOJO_WEB_BASE_IMAGE=cyberdojo/web-base:$(commit_tag)"
}

commit_sha()
{
  cd "${ROOT_DIR}" && git rev-parse HEAD
}

commit_tag()
{
  local -r sha="$(commit_sha)"
  echo "${sha:0:7}"
}

export $(echo_env_vars)

docker compose \
  --file "${ROOT_DIR}/docker-compose.yml" \
  build \
  --build-arg COMMIT_SHA=$(commit_sha)

echo "${CYBER_DOJO_WEB_BASE_IMAGE}"
