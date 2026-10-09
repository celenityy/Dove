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

# Ensure we have `DOVE_CI`
verify_env "${DOVE_CI}" 'DOVE_CI' || exit 1

if [[ "${DOVE_CI}" != 1 ]]; then
  echo_red_text "ERROR: '$0' should only be called from CI!"
  exit 1
fi

# Ensure we have GNU awk
verify_exec "${DOVE_AWK}" 'DOVE_AWK' || exit 1

# Ensure we have `DOVE_LOG_AR_DOWN`
verify_env "${DOVE_LOG_AR_DOWN}" 'DOVE_LOG_AR_DOWN' || exit 1

# Ensure we have `DOVE_CI_TYPE`
verify_env "${DOVE_CI_TYPE}" 'DOVE_CI_TYPE' || exit 1

# Ensure we have `DOVE_SCRIPTS`
verify_dir_with_env "${DOVE_SCRIPTS}" 'DOVE_SCRIPTS' || exit 1

# Ensure we have our target script
readonly DOVE_AR_DOWN_SH="${DOVE_SCRIPTS}/ci-download-artifacts-dove.sh"
verify_file "${DOVE_AR_DOWN_SH}" || exit 1

# Set our CI ID
## For Forgejo (Codeberg), we use the run ID
## For GitLab, we use the pipeline ID
if [[ "${DOVE_CI_TYPE}" == 'forgejo' ]]; then
  verify_env "${FORGEJO_RUN_ID}" 'FORGEJO_RUN_ID' || exit 1
  readonly DOVE_CI_ID="${FORGEJO_RUN_ID}"
elif [[ "${DOVE_CI_TYPE}" == 'gitlab' ]]; then
  verify_env "${CI_PIPELINE_ID}" 'CI_PIPELINE_ID' || exit 1
  readonly DOVE_CI_ID="${CI_PIPELINE_ID}"
else
  echo_red_text "ERROR: Unknown CI type: '${DOVE_CI_TYPE}'!"
  exit 1
fi
export DOVE_CI_ID

# Set-up target parameters
if [[ -z "${1+x}" ]]; then
  readonly target_artifact='all'
else
  readonly target_artifact=$(echo "${1}" | "${DOVE_AWK}" '{print tolower($0)}')
fi

pushd "${DOVE_ROOT}"

# Download our artifacts
readonly DOVE_FROM_AR_DOWN=1
export DOVE_FROM_AR_DOWN
if [[ "${DOVE_LOG_AR_DOWN}" == 1 ]]; then
  # Ensure we have mkdir
  verify_exec "${DOVE_MKDIR}" 'DOVE_MKDIR' || exit 1

  # Ensure we have rm
  verify_exec "${DOVE_RM}" 'DOVE_RM' || exit 1

  # Ensure we have tee
  verify_exec "${DOVE_TEE}" 'DOVE_TEE' || exit 1

  # Ensure we have `DOVE_LOG_DIR`
  verify_env "${DOVE_LOG_DIR}" 'DOVE_LOG_DIR' || exit 1

  readonly AR_DOWN_LOG_FILE="${DOVE_LOG_DIR}/download-artifacts-${DOVE_CI_ID}-${target_artifact}.log"

  # If the log file already exists, remove it
  if [[ -f "${AR_DOWN_LOG_FILE}" ]]; then
    "${DOVE_RM}" "${AR_DOWN_LOG_FILE}"
  fi

  # Ensure our log directory exists
  "${DOVE_MKDIR}" -vp "${DOVE_LOG_DIR}"

  source "${DOVE_AR_DOWN_SH}" "${target_artifact}" > >("${DOVE_TEE}" -a "${AR_DOWN_LOG_FILE}") 2>&1 || exit 1
else
  source "${DOVE_AR_DOWN_SH}" "${target_artifact}" || exit 1
fi

popd
