#!/bin/bash

set -euo pipefail

# Functions
echo_red_text() {
	echo -e "\033[31m$1\033[0m"
}

echo_green_text() {
	echo -e "\033[32m$1\033[0m"
}

error_fn() {
	echo
	echo_red_text -e "\033[31mSomething went wrong! The script failed.\033[0m"
	echo_red_text -e "\033[31mPlease report this (with the output message) to https://dove.celenity.dev/issues\033[0m"
	echo
	exit 1
}

# Set-up our environment
bash -x $(dirname $0)/env.sh || error_fn
echo
source $(dirname $0)/env.sh || error_fn
echo

# Set-up pip venv
if [ "${DOVE_NIX_FLAKE}" != 1 ]; then
    python -m venv "${DOVE_PIP_DIR}" || error_fn
    echo
    source "${DOVE_PIP_ENV}" || error_fn
    echo
    pip install --upgrade pip || error_fn
    echo
    pip install lxml || error_fn
    echo
fi

mkdir -vp "${DOVE_AUTOCONFIG_OUTPUT}" || error_fn
echo

pushd "${DOVE_AUTOCONFIG_OUTPUT}" || error_fn
echo
rm -vrf * || error_fn
echo
cp "${DOVE_AUTOCONFIG}/LICENSE" "${DOVE_AUTOCONFIG_OUTPUT}/LICENSE.txt" || error_fn
echo
mkdir -vp "${DOVE_AUTOCONFIG_OUTPUT}/v1.1" || error_fn
echo
python "${DOVE_AUTOCONFIG}/tools/convert.py" -d "${DOVE_AUTOCONFIG_OUTPUT}/v1.1" -a ${DOVE_AUTOCONFIG}/ispdb/*.xml || error_fn
echo
popd || error_fn
echo

pushd "${DOVE_ROOT}" || error_fn
echo
bash -x "${DOVE_BUILD}/fly.sh" || error_fn
echo
bash -x "${DOVE_BUILD}/gen_archive.sh" || error_fn
echo
popd || error_fn
echo
