#!/usr/bin/env bash
set -Eeu

readonly ROOT_DIR="$(cd "$(dirname "${0}")" && cd .. && pwd)"
source "${ROOT_DIR}/sh/lib.sh"
export $(echo_env_vars)

docker compose \
  --file "${ROOT_DIR}/docker-compose.yml" \
  build \
  --build-arg COMMIT_SHA=$(commit_sha)

echo "${CYBER_DOJO_WEB_BASE_IMAGE}"
