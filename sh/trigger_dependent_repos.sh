#!/bin/bash
set -ev

declare -r SHA="${1}"
declare -r REPO_URLS="${@:2}"

for REPO_URL in ${REPO_URLS}; do                   # eg https://github.com/cyber-dojo/differ.git
  declare REPO_NAME=$(basename "${REPO_URL}" .git) # eg differ
  cd /tmp
  git clone "${REPO_URL}"
  cd "${REPO_NAME}"
  echo "${SHA}" > web-base.trigger
  git add .
  git config --global user.email "cyber-dojo-machine-user@cyber-dojo.org"
  git config --global user.name "Machine User"
  git commit -m "automated build trigger from cyberdojo/web-base ${SHA}"
  git push origin master
done
