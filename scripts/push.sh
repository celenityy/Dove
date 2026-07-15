#!/bin/bash

set -euo pipefail

# Set-up our environment
if [[ -z "${DOVE_SET_ENVS+x}" ]]; then
  /bin/bash -x $(dirname $0)/env.sh
fi
source $(dirname $0)/env.sh

# Include utilities
source "${DOVE_UTILS}"

# Set up target parameters
if [[ -z "${1+x}" ]]; then
  readonly target='all'
else
  readonly target=$(echo "${1}" | "${DOVE_AWK}" '{print tolower($0)}')
fi

# Push Dove
readonly DOVE_FROM_PUSH=1
export DOVE_FROM_PUSH
if [[ "${DOVE_LOG_PUSH}" == 1 ]]; then
  readonly PUSH_LOG_FILE="${DOVE_LOG_DIR}/push-${target}.log"

  # If the log file already exists, remove it
  if [[ -f "${PUSH_LOG_FILE}" ]]; then
    "${DOVE_RM}" "${PUSH_LOG_FILE}"
  fi

  # Ensure our log directory exists
  "${DOVE_MKDIR}" -vp "${DOVE_LOG_DIR}"

  /bin/bash "${DOVE_SCRIPTS}/push-dove.sh" "${target}" > >("${DOVE_TEE}" -a "${PUSH_LOG_FILE}") 2>&1
else
  /bin/bash "${DOVE_SCRIPTS}/push-dove.sh" "${target}"
fi
