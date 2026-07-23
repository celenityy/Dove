#!/bin/bash

set -euo pipefail

# Set-up our environment
if [[ -z "${DOVE_SET_ENVS+x}" ]]; then
  /bin/bash $(dirname $0)/env.sh
fi
source $(dirname $0)/env.sh

# Include utilities
source "${DOVE_UTILS}"

# Set verbosity
if [[ "${DOVE_VERBOSE}" == 1 ]]; then
  set -x
else
  set +x
fi

nix flake update || error_fn
echo
