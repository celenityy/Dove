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

# Ensure we have `DOVE_CI`
verify_env "${DOVE_CI}" 'DOVE_CI' || exit 1

if [[ "${DOVE_CI}" != 1 ]]; then
  echo_red_text "ERROR: '$0' should only be called from CI!"
  exit 1
fi

# Ensure we have bash
verify_exec "${DOVE_BASH}" 'DOVE_BASH' || exit 1

# Ensure we have `DOVE_SCRIPTS`
verify_dir_with_env "${DOVE_SCRIPTS}" 'DOVE_SCRIPTS' || exit 1

# Ensure we have our target scripts
readonly DOVE_CI_DL_AR_SH="${DOVE_SCRIPTS}/ci-download-artifacts.sh"
verify_file "${DOVE_CI_DL_AR_SH}" || exit 1

readonly DOVE_CI_GET_SOURCES_SH="${DOVE_SCRIPTS}/get_sources.sh"
verify_file "${DOVE_CI_GET_SOURCES_SH}" || exit 1

readonly DOVE_CI_PREP_SH="${DOVE_SCRIPTS}/ci-prep.sh"
verify_file "${DOVE_CI_PREP_SH}" || exit 1

readonly DOVE_CI_PUBLISH_SH="${DOVE_SCRIPTS}/ci-push.sh"
verify_file "${DOVE_CI_PUBLISH_SH}" || exit 1

# Get dependencies
echo_red_text 'CI - Downloading dependencies...'
/bin/sudo /bin/dnf update -y --refresh || exit 1
/bin/sudo /bin/dnf install -y curl jq shasum tar zip || exit 1
"${DOVE_BASH}" "${DOVE_CI_GET_SOURCES_SH}" 'uv' || exit 1
"${DOVE_BASH}" "${DOVE_CI_GET_SOURCES_SH}" 'python' || exit 1
"${DOVE_BASH}" "${DOVE_CI_GET_SOURCES_SH}" 's3cmd' || exit 1
echo_green_text 'CI - SUCCESS: Downloaded dependencies.'

# Get secrets
echo_red_text 'CI - Preparing secrets...'
set +x || exit 1
"${DOVE_BASH}" "${DOVE_CI_PREP_SH}" 's3-releases' || exit 1
echo_green_text 'CI - SUCCESS: Prepared secrets.'

# Set verbosity
set_verbosity

# Get artifacts
echo_red_text 'CI - Downloading artifacts...'
"${DOVE_BASH}" "${DOVE_CI_DL_AR_SH}" 'all' || exit 1
echo_green_text 'CI - SUCCESS: Downloaded artifacts.'

# Publish our release
echo_red_text 'CI - Publishing release...'
set +x || exit 1
"${DOVE_BASH}" "${DOVE_CI_PUBLISH_SH}" || exit 1
echo_green_text 'CI - SUCCESS: Published release.'
