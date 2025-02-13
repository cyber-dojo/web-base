#!/usr/bin/env bash
set -Eeu

readonly ROOT_DIR="$(cd "$(dirname "${0}")" && cd .. && pwd)"
source "${ROOT_DIR}/sh/lib.sh"
export $(echo_env_vars)

snyk container test "${CYBER_DOJO_WEB_BASE_IMAGE}" \
  --file="${ROOT_DIR}/Dockerfile" \
  --policy-path="${ROOT_DIR}/.snyk" \
  --sarif \
  --sarif-file-output="${ROOT_DIR}/snyk.container.scan.json"

