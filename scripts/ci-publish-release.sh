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
/bin/bash "${DOVE_SCRIPTS}/ci-prep.sh" 's3-releases'
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
/bin/sudo /bin/dnf install -y curl jq shasum tar zip
/bin/bash "${DOVE_SCRIPTS}/get_sources.sh" 'uv'
/bin/bash "${DOVE_SCRIPTS}/get_sources.sh" 'python'
/bin/bash "${DOVE_SCRIPTS}/get_sources.sh" 's3cmd'
echo_green_text 'CI - SUCCESS: Downloaded dependencies.'

# Get artifacts
echo_red_text 'CI - Downloading artifacts...'
/bin/bash "${DOVE_SCRIPTS}/ci-download-artifacts.sh" 'all'
echo_green_text 'CI - SUCCESS: Downloaded artifacts.'

# Publish our release
echo_red_text 'CI - Publishing release...'
set +x
/bin/bash "${DOVE_SCRIPTS}/ci-push.sh"
echo_green_text 'CI - SUCCESS: Published release.'
