#!/bin/bash

set -euo pipefail

# Set-up our environment
bash -x $(dirname $0)/env.sh
source $(dirname $0)/env.sh

# Build Dove
export DOVE_FROM_BUILD=1
if [ "${DOVE_LOG_BUILD}" == 1 ]; then
    BUILD_LOG_FILE="${DOVE_LOG_DIR}/build.log"

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
