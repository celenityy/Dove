#!/bin/bash

set -euo pipefail

# Set-up our environment
function setup_env() {
  if [[ -z "${DOVE_SET_ENVS+x}" ]] || [[ "${DOVE_SET_ENVS}" != 1 ]]; then
    # Find dirname
    if [[ -n "${DOVE_DIRNAME+x}" ]] && [[ -x "${DOVE_DIRNAME}" ]]; then
      local -r dirname="${DOVE_DIRNAME}"
    elif [[ -x '/bin/dirname' ]]; then
      local -r dirname='/bin/dirname'
    elif [[ -x '/usr/bin/dirname' ]]; then
      local -r dirname='/usr/bin/dirname'
    else
      if ! command -v dirname > /dev/null 2>&1; then
        echo "ERROR: Missing dirname!" >&2
        exit 1
      fi
      # It isn't a known location, so we sadly have to just fall-back to the PATH
      local -r dirname="$(dirname)"
    fi

    # Set-up our environment
    readonly DOVE_ENV_SH="$("${dirname}" $0)/env.sh"
    if [[ ! -f "${DOVE_ENV_SH}" ]] || [[ ! -s "${DOVE_ENV_SH}" ]]; then
      echo "ERROR: '${DOVE_ENV_SH}' is invalid!"
      exit 1
    fi
    source "${DOVE_ENV_SH}" || exit 1
  fi
}

# Set-up our environment
setup_env

# Set verbosity
set_verbosity

nix flake update || error_fn
echo
