#!/bin/bash

set -euo pipefail

# Set-up our environment
if [[ -z "${DOVE_CI+x}" ]]; then
  export DOVE_CI=1
fi
source $(dirname $0)/env.sh

# Include utilities
source "${DOVE_UTILS}"

# Get secrets
echo_red_text 'CI - Preparing secrets...'
set +x
/bin/bash "${DOVE_SCRIPTS}/ci-prep.sh" 's3-artifacts'
echo_green_text 'CI - SUCCESS: Prepared secrets.'

# Set verbosity
if [[ "${DOVE_VERBOSE}" == 1 ]]; then
  set -x
else
  set +x
fi

# Get dependencies
echo_red_text 'CI - Downloading dependencies...'
/bin/sudo /bin/dnf update -y --refresh
/bin/sudo /bin/dnf install -y as cc clang curl jq ld libxml2 libxml2-devel libxslt libxslt-devel tar zip
/bin/bash "${DOVE_SCRIPTS}/get_sources.sh" 'all'
/bin/bash "${DOVE_SCRIPTS}/get_sources.sh" 's3cmd'
echo_green_text 'CI - SUCCESS: Downloaded dependencies.'

# Build Dove
echo_red_text 'CI - Building Dove...'
/bin/bash "${DOVE_SCRIPTS}/build.sh" 'all'
echo_green_text 'CI - SUCCESS: Built Dove.'

# Upload artifacts
echo_red_text 'CI - Uploading artifacts..'
set +x
/bin/bash "${DOVE_SCRIPTS}/ci-upload-artifacts.sh" 'all'
echo_green_text 'CI - SUCCESS: Uploaded artifacts.'
