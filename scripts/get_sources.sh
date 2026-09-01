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

# Set up target parameters
if [[ -z "${1+x}" ]]; then
  readonly target='all'
else
  readonly target=$(echo "${1}" | "${DOVE_AWK}" '{print tolower($0)}')
fi

if [[ -z "${2+x}" ]]; then
  readonly mode='download'
else
  readonly mode=$(echo "${2}" | "${DOVE_AWK}" '{print tolower($0)}')
fi

# Get sources
readonly DOVE_FROM_SOURCES=1
export DOVE_FROM_SOURCES
if [[ "${DOVE_LOG_SOURCES}" == 1 ]]; then
  # Ensure we have mkdir
  verify_exec "${DOVE_MKDIR}" 'DOVE_MKDIR' || exit 1

  # Ensure we have rm
  verify_exec "${DOVE_RM}" 'DOVE_RM' || exit 1

  # Ensure we have tee
  verify_exec "${DOVE_TEE}" 'DOVE_TEE' || exit 1

  readonly SOURCES_LOG_FILE="${DOVE_LOG_DIR}/get_sources.log"

  # If the log file already exists, remove it
  if [[ -f "${SOURCES_LOG_FILE}" ]]; then
    "${DOVE_RM}" "${SOURCES_LOG_FILE}"
  fi

  # Ensure our log directory exists
  "${DOVE_MKDIR}" -vp "${DOVE_LOG_DIR}"

  /bin/bash "${DOVE_SCRIPTS}/get_sources-dove.sh" "${target}" "${mode}" > >("${DOVE_TEE}" -a "${SOURCES_LOG_FILE}") 2>&1 || exit 1
else
  /bin/bash "${DOVE_SCRIPTS}/get_sources-dove.sh" "${target}" "${mode}" || exit 1
fi
