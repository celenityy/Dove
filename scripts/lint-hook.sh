#!/bin/bash

# Script to configure a git pre-commit hook for linting

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

# Ensure we have git
verify_exec "${DOVE_GIT}" 'DOVE_GIT' || exit 1

# Ensure we have mkdir
verify_exec "${DOVE_MKDIR}" 'DOVE_MKDIR' || exit 1

# Ensure we have rm
verify_exec "${DOVE_RM}" 'DOVE_RM' || exit 1

# Ensure we have touch
verify_exec "${DOVE_TOUCH}" 'DOVE_TOUCH' || exit 1

# Ensure we have `DOVE_BUILD`
verify_env "${DOVE_BUILD}" 'DOVE_BUILD' || exit 1

# Check if the hook has already been set-up
if [[ -f "${DOVE_BUILD}/set-hook" ]]; then
  echo_red_text 'It looks like the git pre-commit hook has already been set-up!'
  read -p "Are you sure you want to continue? [y/N] " -n 1 -r
  echo
  if [[ "${REPLY}" =~ ^[Nn]$ ]]; then
    exit 0
  else
    "${DOVE_RM}" -f "${DOVE_BUILD}/set-hook"
  fi
fi

# Enable the pre-commit hook so shell scripts are linted (shellcheck + shfmt)
# before each commit. CI enforces the same checks, so this is just a fast local
# safeguard (and is bypassable with `git commit --no-verify`).
echo_red_text 'Configuring git pre-commit hook...'
"${DOVE_GIT}" -C "${DOVE_ROOT}" config core.hooksPath scripts/git-hooks
echo_green_text 'SUCCESS: Configured git pre-commit hook'

# Indicate that the hook has been set-up
"${DOVE_MKDIR}" -p "${DOVE_BUILD}"
"${DOVE_TOUCH}" "${DOVE_BUILD}/set-hook"
