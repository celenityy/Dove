#!/bin/bash

set -euo pipefail

# Set-up our environment
if [[ -z "${DOVE_SET_ENVS+x}" ]]; then
  /bin/bash $(dirname $0)/env.sh || exit 1
fi
source $(dirname $0)/env.sh || exit 1

# Include utilities
source "${DOVE_UTILS}" || exit 1

# Ensure we have GNU awk
verify_exec "${DOVE_AWK}" 'DOVE_AWK' || exit 1

# Set-up target parameters
if [[ -z "${1+x}" ]]; then
  readonly target='all'
else
  readonly target=$(echo "${1}" | "${DOVE_AWK}" '{print tolower($0)}')
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

  readonly BUILD_LOG_FILE="${DOVE_LOG_DIR}/build.log"

  # If the log file already exists, remove it
  if [[ -f "${BUILD_LOG_FILE}" ]]; then
    "${DOVE_RM}" "${BUILD_LOG_FILE}"
  fi

  # Ensure our log directory exists
  "${DOVE_MKDIR}" -vp "${DOVE_LOG_DIR}"

  /bin/bash "${DOVE_SCRIPTS}/fly.sh" "${target}" > >("${DOVE_TEE}" -a "${BUILD_LOG_FILE}") 2>&1 || exit 1
else
  /bin/bash "${DOVE_SCRIPTS}/fly.sh" "${target}" || exit 1
fi

popd
