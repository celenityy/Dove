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

if [[ -z "${DOVE_CI_TYPE+x}" ]]; then
  echo_red_text 'ERROR: Missing CI type! Please set DOVE_CI_TYPE.'
  exit 1
fi

# Set our CI ID
## For Forgejo (Codeberg), we use the run ID
## For GitLab, we use the pipeline ID
if [[ "${DOVE_CI_TYPE}" == 'forgejo' ]]; then
  if [[ -z "${FORGEJO_RUN_ID+x}" ]]; then
    echo_red_text 'ERROR: Missing Forgejo run ID! Please set FORGEJO_RUN_ID.'
    exit 1
  else
    readonly DOVE_CI_ID="${FORGEJO_RUN_ID}"
  fi
elif [[ "${DOVE_CI_TYPE}" == 'gitlab' ]]; then
  if [[ -z "${CI_PIPELINE_ID+x}" ]]; then
    echo_red_text 'ERROR: Missing GitLab pipeline ID! Please set CI_PIPELINE_ID.'
    exit 1
  else
    readonly DOVE_CI_ID="${CI_PIPELINE_ID}"
  fi
else
  echo_red_text "ERRROR: Unknown CI type!: ${DOVE_CI_TYPE}"
  exit 1
fi
export DOVE_CI_ID

# Set-up target parameters
if [[ -z "${1+x}" ]]; then
  readonly target_artifact='all'
else
  readonly target_artifact=$(echo "${1}" | "${DOVE_AWK}" '{print tolower($0)}')
fi

# Download our artifacts
readonly DOVE_FROM_AR_DOWN=1
export DOVE_FROM_AR_DOWN
if [[ "${DOVE_LOG_AR_DOWN}" == 1 ]]; then
  readonly AR_DOWN_LOG_FILE="${DOVE_LOG_DIR}/download-artifacts-${DOVE_CI_ID}-${target_artifact}.log"

  # If the log file already exists, remove it
  if [[ -f "${AR_DOWN_LOG_FILE}" ]]; then
    "${DOVE_RM}" "${AR_DOWN_LOG_FILE}"
  fi

  # Ensure our log directory exists
  "${DOVE_MKDIR}" -vp "${DOVE_LOG_DIR}"

  /bin/bash "${DOVE_SCRIPTS}/ci-download-artifacts-dove.sh" "${target_artifact}" > >("${DOVE_TEE}" -a "${AR_DOWN_LOG_FILE}") 2>&1
else
  /bin/bash "${DOVE_SCRIPTS}/ci-download-artifacts-dove.sh" "${target_artifact}"
fi
