
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
