#!/bin/bash

set -euo pipefail

# Set-up our environment
if [[ -z "${DOVE_SET_ENVS+x}" ]]; then
    bash -x $(dirname $0)/env.sh
fi
source $(dirname $0)/env.sh

# Include utilities
source "${DOVE_UTILS}"

nix flake update || error_fn
echo
