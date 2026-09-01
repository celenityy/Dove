#!/bin/bash

set -euo pipefail

# Set-up our environment
if [[ -z "${DOVE_SET_ENVS+x}" ]]; then
  /bin/bash $(dirname $0)/env.sh || exit 1
fi
source $(dirname $0)/env.sh || exit 1

# Include utilities
source "${DOVE_UTILS}" || exit 1

if [[ "${DOVE_CI}" != 1 ]]; then
  echo_red_text "ERROR: '$0' should only be called from CI!"
  exit 1
fi

# Push Dove
readonly DOVE_FROM_PUSH=1
export DOVE_FROM_PUSH
if [[ "${DOVE_LOG_PUSH}" == 1 ]]; then
  # Ensure we have mkdir
  verify_exec "${DOVE_MKDIR}" 'DOVE_MKDIR' || exit 1

  # Ensure we have rm
  verify_exec "${DOVE_RM}" 'DOVE_RM' || exit 1

  # Ensure we have tee
  verify_exec "${DOVE_TEE}" 'DOVE_TEE' || exit 1

  readonly PUSH_LOG_FILE="${DOVE_LOG_DIR}/push.log"

  # If the log file already exists, remove it
  if [[ -f "${PUSH_LOG_FILE}" ]]; then
    "${DOVE_RM}" "${PUSH_LOG_FILE}"
  fi

  # Ensure our log directory exists
  "${DOVE_MKDIR}" -vp "${DOVE_LOG_DIR}"

  /bin/bash "${DOVE_SCRIPTS}/ci-push-dove.sh" > >("${DOVE_TEE}" -a "${PUSH_LOG_FILE}") 2>&1 || exit 1
else
  /bin/bash "${DOVE_SCRIPTS}/ci-push-dove.sh" || exit 1
fi
