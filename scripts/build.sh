#!/bin/bash

set -euo pipefail

# Set-up our environment
if [[ -z "${DOVE_SET_ENVS+x}" ]]; then
  /bin/bash $(dirname $0)/env.sh
fi
source $(dirname $0)/env.sh

# Set-up target parameters
if [[ -z "${1+x}" ]]; then
  readonly target='all'
else
  readonly target=$(echo "${1}" | "${DOVE_AWK}" '{print tolower($0)}')
fi

# Build Dove
readonly DOVE_FROM_BUILD=1
export DOVE_FROM_BUILD
if [[ "${DOVE_LOG_BUILD}" == 1 ]]; then
  readonly BUILD_LOG_FILE="${DOVE_LOG_DIR}/build.log"

  # If the log file already exists, remove it
  if [[ -f "${BUILD_LOG_FILE}" ]]; then
    "${DOVE_RM}" "${BUILD_LOG_FILE}"
  fi

  # Ensure our log directory exists
  "${DOVE_MKDIR}" -vp "${DOVE_LOG_DIR}"

  /bin/bash "${DOVE_SCRIPTS}/fly.sh" "${target}" > >("${DOVE_TEE}" -a "${BUILD_LOG_FILE}") 2>&1
else
  /bin/bash "${DOVE_SCRIPTS}/fly.sh" "${target}"
fi
