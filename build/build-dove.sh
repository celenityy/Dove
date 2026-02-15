#!/bin/bash

set -euo pipefail

if [[ -z "${DOVE_FROM_BUILD+x}" ]]; then
    echo_red_text 'ERROR: Do not call build-dove.sh directly. Instead, use build.sh.' >&1
    exit 1
fi

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

# Include version info
source "${DOVE_VERSIONS}" || error_fn
echo

# Prepare build environment...
echo_red_text 'Preparing your build environment...' || error_fn
echo

# Ensure files aren't left-over from previous builds...
if [[ -d "${DOVE_TEMP}" ]]; then
    rm -rf "${DOVE_TEMP}" || error_fn
    echo
fi

if [[ -d "${DOVE_OUTPUTS}" ]]; then
    rm -rf "${DOVE_OUTPUTS}" || error_fn
    echo
fi

mkdir -p "${DOVE_AUTOCONFIG_OUTPUT}" || error_fn
echo
mkdir -p "${DOVE_TEMP}/prefs" || error_fn
echo
mkdir -p "${DOVE_TEMP}/policies" || error_fn
echo

cp -f "${DOVE_BUILD}/dove-unified.js" "${DOVE_TEMP}/dove-unified-parsed.js" || error_fn
echo
cp -f "${DOVE_BUILD}/dove-user-pref.cfg" "${DOVE_TEMP}/dove-user-pref-parsed.cfg" || error_fn
echo

# Set our versions
"${DOVE_SED}" -i "s|{DOVE_VERSION}|${DOVE_VERSION}|" "${DOVE_TEMP}/dove-unified-parsed.js" || error_fn
echo
"${DOVE_SED}" -i "s|{DOVE_VERSION}|${DOVE_VERSION}|" "${DOVE_TEMP}/dove-user-pref-parsed.cfg" || error_fn
echo
"${DOVE_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${DOVE_TEMP}/dove-unified-parsed.js" || error_fn
echo
"${DOVE_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${DOVE_TEMP}/dove-user-pref-parsed.cfg" || error_fn
echo

echo_green_text 'SUCCESS: Prepared build environment' || error_fn
echo

# Begin the build...
echo_red_text "Building Dove ${DOVE_VERSION}..." || error_fn
echo

# Build Thunderbird's autoconfiguration database...
echo_red_text 'Building the Thunderbird autoconfiguration database...' || error_fn
echo

pushd "${DOVE_AUTOCONFIG_OUTPUT}" || error_fn
echo
cp "${DOVE_AUTOCONFIG}/LICENSE" "${DOVE_AUTOCONFIG_OUTPUT}/LICENSE.txt" || error_fn
echo
mkdir -p "${DOVE_AUTOCONFIG_OUTPUT}/v1.1" || error_fn
echo
python "${DOVE_AUTOCONFIG}/tools/convert.py" -d "${DOVE_AUTOCONFIG_OUTPUT}/v1.1" -a ${DOVE_AUTOCONFIG}/ispdb/*.xml || error_fn
echo
popd || error_fn
echo

echo_green_text 'SUCCESS: Built the Thunderbird autoconfiguration database' || error_fn
echo

# Build Phoenix...
echo_red_text 'Building Phoenix...' || error_fn
echo

pushd "${DOVE_PHOENIX}" || error_fn
echo
bash -x "${DOVE_PHOENIX}/build/build.sh" || error_fn
echo
popd || error_fn
echo

echo_green_text 'SUCCESS: Built Phoenix' || error_fn
echo

pushd "${DOVE_ROOT}" || error_fn
echo

bash -x "${DOVE_BUILD}/fly.sh" || error_fn
echo
bash -x "${DOVE_BUILD}/gen_archive.sh" || error_fn
echo

popd || error_fn
echo

echo_green_text "SUCCESS: Built Dove ${DOVE_VERSION}" || error_fn
echo
