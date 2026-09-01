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

if [[ -z "${DOVE_CI_TYPE+x}" ]] || [[ "${DOVE_CI_TYPE}" == "" ]]; then
  echo_red_text "ERROR: Missing CI type! Please set 'DOVE_CI_TYPE'."
  exit 1
fi

# Ensure we have GNU awk
verify_exec "${DOVE_AWK}" 'DOVE_AWK' || exit 1

# Set our CI ID
## For Forgejo (Codeberg), we use the run ID
## For GitLab, we use the pipeline ID
if [[ "${DOVE_CI_TYPE}" == 'forgejo' ]]; then
  if [[ -z "${FORGEJO_RUN_ID+x}" ]] || [[ "${FORGEJO_RUN_ID}" == "" ]]; then
    echo_red_text "ERROR: Missing Forgejo run ID! Please set 'FORGEJO_RUN_ID'."
    exit 1
  else
    readonly DOVE_CI_ID="${FORGEJO_RUN_ID}"
  fi
elif [[ "${DOVE_CI_TYPE}" == 'gitlab' ]]; then
  if [[ -z "${CI_PIPELINE_ID+x}" ]] || [[ "${CI_PIPELINE_ID}" == "" ]]; then
    echo_red_text "ERROR: Missing GitLab pipeline ID! Please set 'CI_PIPELINE_ID'."
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

# Upload our artifacts
readonly DOVE_FROM_AR_UP=1
export DOVE_FROM_AR_UP
if [[ "${DOVE_LOG_AR_UP}" == 1 ]]; then
  # Ensure we have mkdir
  verify_exec "${DOVE_MKDIR}" 'DOVE_MKDIR' || exit 1

  # Ensure we have rm
  verify_exec "${DOVE_RM}" 'DOVE_RM' || exit 1

  # Ensure we have tee
  verify_exec "${DOVE_TEE}" 'DOVE_TEE' || exit 1

  readonly AR_UP_LOG_FILE="${DOVE_LOG_DIR}/upload-artifacts-${DOVE_CI_ID}-${target_artifact}.log"

  # If the log file already exists, remove it
  if [[ -f "${AR_UP_LOG_FILE}" ]]; then
    "${DOVE_RM}" "${AR_UP_LOG_FILE}"
  fi

  # Ensure our log directory exists
  "${DOVE_MKDIR}" -vp "${DOVE_LOG_DIR}"

  /bin/bash "${DOVE_SCRIPTS}/ci-upload-artifacts-dove.sh" "${target_artifact}" > >("${DOVE_TEE}" -a "${AR_UP_LOG_FILE}") 2>&1 || exit 1
else
  /bin/bash "${DOVE_SCRIPTS}/ci-upload-artifacts-dove.sh" "${target_artifact}" || exit 1
fi
