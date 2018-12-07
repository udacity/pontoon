#!/bin/sh

main() {
  init_ssh_env
  init_venv $@
}

init_ssh_env() {
  if [ -d /ssh ]; then
    cp -a /ssh ~/.ssh
    chown -R $(id -u):$(id -g) ~/.ssh || :
    chmod 700 ~/.ssh
    if [ -f ~/.ssh/config ]; then
      fix_circleci_specific_quirks
    fi
  fi
}

fix_circleci_specific_quirks() {
  sed -i 's/\/home\/ubuntu/~/g' ~/.ssh/config
  chmod 600 ~/.ssh/config
}

init_venv() {
  local env_full_path=${1:-/app/.udacityenv}
  cd $(dirname ${env_full_path})
  virtualenv ${env_full_path}
  # Update the timestamp for Make to detect changes.
  touch ${env_full_path}
  source ${env_full_path}/bin/activate
  pip install -U -r requirements.txt
}

main $@
