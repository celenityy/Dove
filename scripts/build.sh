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

# Ensure we have GNU awk
verify_exec "${DOVE_AWK}" 'DOVE_AWK' || exit 1

# Set-up target parameters
if [[ -z "${1+x}" ]]; then
  readonly build_target='all'
else
  readonly build_target=$(echo "${1}" | "${DOVE_AWK}" '{print tolower($0)}')
fi

pushd "${DOVE_ROOT}"

# Build Dove
readonly DOVE_FROM_BUILD=1
export DOVE_FROM_BUILD
if [[ "${DOVE_LOG_BUILD}" == 1 ]]; then
  # Ensure we have mkdir
  verify_exec "${DOVE_MKDIR}" 'DOVE_MKDIR' || exit 1

  # Ensure we have rm
  verify_exec "${DOVE_RM}" 'DOVE_RM' || exit 1

  # Ensure we have tee
  verify_exec "${DOVE_TEE}" 'DOVE_TEE' || exit 1

  # Ensure we have `DOVE_LOG_DIR`
  verify_env "${DOVE_LOG_DIR}" 'DOVE_LOG_DIR' || exit 1

  readonly BUILD_LOG_FILE="${DOVE_LOG_DIR}/build.log"

  # If the log file already exists, remove it
  if [[ -f "${BUILD_LOG_FILE}" ]]; then
    "${DOVE_RM}" "${BUILD_LOG_FILE}"
  fi

  # Ensure our log directory exists
  "${DOVE_MKDIR}" -vp "${DOVE_LOG_DIR}"

  source "${DOVE_SCRIPTS}/fly.sh" "${build_target}" > >("${DOVE_TEE}" -a "${BUILD_LOG_FILE}") 2>&1 || exit 1
else
  source "${DOVE_SCRIPTS}/fly.sh" "${build_target}" || exit 1
fi

popd
