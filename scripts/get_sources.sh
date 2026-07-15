#!/bin/bash

set -euo pipefail

# Set-up our environment
if [[ -z "${DOVE_SET_ENVS+x}" ]]; then
  /bin/bash -x $(dirname $0)/env.sh
fi
source $(dirname $0)/env.sh

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
  readonly SOURCES_LOG_FILE="${DOVE_LOG_DIR}/get_sources.log"

  # If the log file already exists, remove it
  if [[ -f "${SOURCES_LOG_FILE}" ]]; then
    "${DOVE_RM}" "${SOURCES_LOG_FILE}"
  fi

  # Ensure our log directory exists
  "${DOVE_MKDIR}" -vp "${DOVE_LOG_DIR}"

  /bin/bash -x "${DOVE_SCRIPTS}/get_sources-dove.sh" "${target}" "${mode}" > >("${DOVE_TEE}" -a "${SOURCES_LOG_FILE}") 2>&1
else
  /bin/bash -x "${DOVE_SCRIPTS}/get_sources-dove.sh" "${target}" "${mode}"
fi
