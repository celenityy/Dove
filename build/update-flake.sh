#!/usr/bin/env bash

source build/env.sh

# Update uBlock version in flake.nix
$SED -i "s/download\/.*\/uBlock0_.*\.thunderbird\.xpi/download\/$ubo_version\/uBlock0_$ubo_version\.thunderbird\.xpi/" flake.nix
$SED -i "s/uBlock\/refs\/tags\/.*\/LICENSE.txt/uBlock\/refs\/tags\/$ubo_version\/LICENSE.txt/" flake.nix

nix flake update
