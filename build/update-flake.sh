#!/bin/bash

# Set-up our environment
bash -x $(dirname $0)/env.sh || error_fn
echo
source $(dirname $0)/env.sh || error_fn
echo

nix flake update || error_fn
echo
