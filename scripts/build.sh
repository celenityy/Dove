#!/bin/bash

set -euo pipefail

# Set-up our environment
if [[ -z "${DOVE_SET_ENVS+x}" ]]; then
    bash -x $(dirname $0)/env.sh
fi
source $(dirname $0)/env.sh

# Build Dove
readonly DOVE_FROM_BUILD=1
export DOVE_FROM_BUILD
if [ "${DOVE_LOG_BUILD}" == 1 ]; then
    readonly BUILD_LOG_FILE="${DOVE_LOG_DIR}/build.log"

    # If the log file already exists, remove it
    if [ -f "${BUILD_LOG_FILE}" ]; then
        rm "${BUILD_LOG_FILE}"
    fi

    # Ensure our log directory exists
    mkdir -vp "${DOVE_LOG_DIR}"

    bash -x "${DOVE_SCRIPTS}/build-dove.sh" > >(tee -a "${BUILD_LOG_FILE}") 2>&1
else
    bash -x "${DOVE_SCRIPTS}/build-dove.sh"
fi
