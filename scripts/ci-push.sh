#!/bin/bash

set -euo pipefail

# Set-up our environment
if [[ -z "${DOVE_CI+x}" ]]; then
  export DOVE_CI=1
fi
if [[ -z "${DOVE_SET_ENVS+x}" ]]; then
  /bin/bash $(dirname $0)/env.sh
fi
source $(dirname $0)/env.sh

# Include utilities
source "${DOVE_UTILS}"

# Push Dove
readonly DOVE_FROM_PUSH=1
export DOVE_FROM_PUSH
if [[ "${DOVE_LOG_PUSH}" == 1 ]]; then
  readonly PUSH_LOG_FILE="${DOVE_LOG_DIR}/push.log"

  # If the log file already exists, remove it
  if [[ -f "${PUSH_LOG_FILE}" ]]; then
    "${DOVE_RM}" "${PUSH_LOG_FILE}"
  fi

  # Ensure our log directory exists
  "${DOVE_MKDIR}" -vp "${DOVE_LOG_DIR}"

  /bin/bash "${DOVE_SCRIPTS}/ci-push-dove.sh" > >("${DOVE_TEE}" -a "${PUSH_LOG_FILE}") 2>&1
else
  /bin/bash "${DOVE_SCRIPTS}/ci-push-dove.sh"
fi
