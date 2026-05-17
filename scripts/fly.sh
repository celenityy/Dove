#!/bin/bash

set -euo pipefail

# Welcome to the Dove Unified build script!
# This script should be ran AFTER building Phoenix, from the ROOT of the Dove repo

# Set-up our environment
source $(dirname $0)/env.sh

# Include utilities
source "${DOVE_UTILS}"

if [[ -z "${DOVE_FROM_BUILD+x}" ]]; then
    echo_red_text 'ERROR: Do not call fly.sh directly. Instead, use build.sh.' >&1
    exit 1
fi

# Set-up Python venv
if [ "${DOVE_NIX}" != 1 ]; then
    source "${DOVE_PYENV}"
fi

# Include version info
source "${DOVE_VERSIONS}"

# Begin the build...
echo_red_text "Building Dove ${DOVE_VERSION}..."

# Prepare to build Dove
function prep_dove() {
    cp -f "${DOVE_ROOT}/dove-unified.cfg" "${DOVE_TEMP}/dove-parsed.cfg"

    # Update the versions
    "${DOVE_SED}" -i "s|{DOVE_VERSION}|${DOVE_VERSION}|" "${DOVE_TEMP}/dove-parsed.cfg"
    "${DOVE_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${DOVE_TEMP}/dove-parsed.cfg"
}

# Build Thunderbird's autoconfiguration database
function build_autoconfig() {
    echo_red_text 'Building the Thunderbird autoconfiguration database...'
    mkdir -p "${DOVE_BUILD}/autoconfig/v1.1"

    pushd "${DOVE_BUILD}/autoconfig"
    cp "${DOVE_AUTOCONFIG}/LICENSE" "${DOVE_BUILD}/autoconfig/LICENSE.txt"
    "${DOVE_PYTHON}" "${DOVE_AUTOCONFIG}/tools/convert.py" -d "${DOVE_BUILD}/autoconfig/v1.1" -a ${DOVE_AUTOCONFIG}/ispdb/*.xml
    popd

    echo_green_text 'SUCCESS: Built the Thunderbird autoconfiguration database'
}

# Build Phoenix
function build_phoenix() {
    echo_red_text 'Building Phoenix...'

    pushd "${DOVE_PHOENIX}"
    bash -x "${DOVE_PHOENIX}/scripts/build.sh"
    popd

    echo_green_text 'SUCCESS: Built Phoenix'
}

# Platform-specific build logic
function build_dove() {
    local readonly dove_platform="$1"
    local readonly dove_output_dir="${DOVE_OUTPUTS}/${dove_platform}"

    # Create our output directory
    mkdir -p "${dove_output_dir}/assets/autoconfig/v1.1"

    # Copy our bootstrap dove.js
    mkdir -p "${dove_output_dir}/defaults/pref"
    cp "${DOVE_ROOT}/dove.js" "${dove_output_dir}/defaults/pref/dove.js"

    # Copy our parsed dove.cfg
    if [ "${dove_platform}" == 'osx-silicon' ]; then
        # To ensure installs continue working as expected, this must be placed in (and copied from)
        ## the `macos` directory
        local readonly dove_cfg_output_dir="${dove_output_dir}/macos"
        local readonly phoenix_cfg_input_path="${dove_platform}/macos"
    else
        local readonly dove_cfg_output_dir="${dove_output_dir}"
        local readonly phoenix_cfg_input_path="${dove_platform}"
    fi
    mkdir -p "${dove_cfg_output_dir}"
    cp "${DOVE_PHOENIX}/outputs/${phoenix_cfg_input_path}/phoenix.cfg" "${dove_cfg_output_dir}/dove.cfg"

    # If necessary, copy our static dove.js
    if [ "${DOVE_STATIC_JS}" == 1 ]; then
        cp "${DOVE_PHOENIX}/outputs/${dove_platform}/phoenix-static-${PHOENIX_VERSION}-${dove_platform}.js" "${dove_output_dir}/dove-static-${DOVE_VERSION}-${dove_platform}.js"
    fi

    # Copy icon
    cp "${DOVE_ROOT}/assets/dove.png" "${dove_output_dir}/assets/dove.png"

    # Copy license
    cp "${DOVE_ROOT}/COPYING.txt" "${dove_output_dir}/COPYING.txt"

    # Copy README
    cp "${DOVE_ROOT}/README.md" "${dove_output_dir}/README.md"

    # Copy platform-specific files
    if [ "${dove_platform}" == 'linux-nonflatpak' ]; then
        cp -r "${DOVE_ROOT}/linux/etc" "${dove_output_dir}/"
    elif [ "${dove_platform}" == 'osx-silicon' ] || [ "${dove_platform}" == 'osx-intel' ]; then
        cp -r "${DOVE_ROOT}/osx/shared/Library" "${dove_output_dir}/"
        cp -r "${DOVE_ROOT}/osx/${dove_platform}/Library/" "${dove_output_dir}/Library/"
    fi

    # Copy enterprise policies
    if [ "${dove_platform}" == 'linux-nonflatpak' ] || [ "${dove_platform}" == 'linux-flatpak' ]; then
        cp -r "${DOVE_PHOENIX}/outputs/${dove_platform}/policies" "${dove_output_dir}/"
    elif [ "${dove_platform}" == 'osx-silicon' ]; then
        cp "${DOVE_PHOENIX}/outputs/${dove_platform}/macos/org.mozilla.firefox.plist" "${dove_output_dir}/macos/org.mozilla.thunderbird.plist"
    elif [ "${dove_platform}" == 'osx-intel' ]; then
        cp "${DOVE_PHOENIX}/outputs/${dove_platform}/org.mozilla.firefox.plist" "${dove_output_dir}/org.mozilla.thunderbird.plist"
    elif [ "${dove_platform}" == 'windows' ]; then
        cp -r "${DOVE_PHOENIX}/outputs/${dove_platform}/distribution" "${dove_output_dir}/"
    fi
    
    # For OS X, also copy the standard policies.json
    if [ "${dove_platform}" == 'osx-silicon' ] || [ "${dove_platform}" == 'osx-intel' ]; then
        mkdir -p "${dove_output_dir}/unused"
        cp "${DOVE_PHOENIX}/outputs/${dove_platform}/unused/policies.json" "${dove_output_dir}/unused/policies.json"
    fi

    # Copy Thunderbird's autoconfiguration files
    cp -vrf "${DOVE_BUILD}/autoconfig" "${dove_output_dir}/assets/"

    # Finally, create our platform-specific archives
    if [[ "${DOVE_OS}" == 'osx' ]]; then
        /usr/sbin/dot_clean -mv "${dove_output_dir}"
    fi

    pushd "${dove_output_dir}"
    if [ "${dove_platform}" == 'windows' ]; then
        zip -r "${DOVE_OUTPUTS}/dove-${DOVE_VERSION}-${dove_platform}.zip" * -x '.DS_Store'
    else
        "${DOVE_TAR}" -cJv --no-xattrs --exclude ".DS_Store" -f "${DOVE_OUTPUTS}/dove-${DOVE_VERSION}-${dove_platform}.tar.xz" *
    fi
    popd
}

# Create our temporary file directory
mkdir -p "${DOVE_TEMP}"

# First, prepare our build environment
prep_dove

# Build Thunderbird's autoconfiguration Database
build_autoconfig

# Build Phoenix
build_phoenix

# Build Dove for Linux (non-Flatpak)
if [ "${DOVE_LINUX}" == 1 ]; then
    build_dove 'linux-nonflatpak'
fi

# Build Dove for Linux (Flatpak)
if [ "${DOVE_LINUX_FLATPAK}" == 1 ]; then
    build_dove 'linux-flatpak'
fi

# Build Dove for OS X (Silicon)
if [ "${DOVE_OSX}" == 1 ]; then
    build_dove 'osx-silicon'
fi

# Build Dove for OS X (Intel)
if [ "${DOVE_OSX_INTEL}" == 1 ]; then
    build_dove 'osx-intel'
fi

# Build Dove for Windows
if [ "${DOVE_WINDOWS}" == 1 ]; then
    build_dove 'windows'
fi

echo_green_text "SUCCESS: Built Dove ${DOVE_VERSION}"

# Clean-up temporary files
rm -rf "${DOVE_TEMP}"
