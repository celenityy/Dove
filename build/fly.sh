#!/bin/bash

set -euo pipefail

# Functions
function echo_red_text() {
	echo -e "\033[31m$1\033[0m"
}

function echo_green_text() {
	echo -e "\033[32m$1\033[0m"
}

function error_fn() {
	echo
	echo_red_text -e "\033[31mSomething went wrong! The script failed.\033[0m"
	echo_red_text -e "\033[31mPlease report this (with the output message) to https://dove.celenity.dev/issues\033[0m"
	echo
	exit 1
}

# Welcome to the Dove Unified build script!
# This script should be ran AFTER building Phoenix, from the ROOT of the Dove repo

# Set-up our environment
bash -x $(dirname $0)/env.sh || error_fn
echo
source $(dirname $0)/env.sh || error_fn
echo

# Move files to their appropriate locations
if [[ -f "${DOVE_OSX_DIR}/macos/org.mozilla.firefox.plist" ]]; then
    mv "${DOVE_OSX_DIR}/macos/org.mozilla.firefox.plist" "${DOVE_OSX_DIR}/macos/org.mozilla.thunderbird.plist" || error_fn
    echo
fi

if [[ -f "${DOVE_OSX_INTEL_DIR}/org.mozilla.firefox.plist" ]]; then
    mv "${DOVE_OSX_INTEL_DIR}/org.mozilla.firefox.plist" "${DOVE_OSX_INTEL_DIR}/org.mozilla.thunderbird.plist" || error_fn
    echo
fi

if [[ -f "${DOVE_OSX_DIR}/macos/policies.json" ]]; then
    mv "${DOVE_OSX_DIR}/macos/policies.json" "${DOVE_UNUSED}/macos/policies.json" || error_fn
    echo
fi

if [[ -f "${DOVE_OSX_INTEL_DIR}/policies.json" ]]; then
    mv "${DOVE_OSX_INTEL_DIR}/policies.json" "${DOVE_UNUSED}/macos-intel/policies.json" || error_fn
    echo
fi

if [[ -f "${DOVE_TEMP}/prefs/dove-linux.cfg" ]]; then
    mv "${DOVE_TEMP}/prefs/dove-linux.cfg" "${DOVE_UNUSED}/linux/dove.cfg" || error_fn
    echo
fi

if [[ -f "${DOVE_TEMP}/prefs/dove-linux-flatpak.cfg" ]]; then
    mv "${DOVE_TEMP}/prefs/dove-linux-flatpak.cfg" "${DOVE_UNUSED}/linux-flatpak/dove.cfg" || error_fn
    echo
fi

if [[ -f "${DOVE_TEMP}/prefs/dove-osx.cfg" ]]; then
    # Remove lines containing [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-OSX], [NO-SILICON-OSX], [LINUX-NON-FLATPAK-ONLY], and [WINDOWS-ONLY]
    grep -vE 'FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-OSX|NO-SILICON-OSX|NON-FLATPAK-LINUX-ONLY|WINDOWS-ONLY' "${DOVE_TEMP}/dove-user-pref-parsed.cfg" > "${DOVE_UNUSED}/macos/dove-user-pref.cfg" || error_fn
    echo

    cat "${DOVE_TEMP}/prefs/dove-osx.cfg" "${DOVE_UNUSED}/macos/dove-user-pref.cfg" > "${DOVE_OSX_DIR}/macos/dove.cfg" || error_fn
    echo
fi

if [[ -f "${DOVE_TEMP}/prefs/dove-osx-intel.cfg" ]]; then
    # Remove lines containing [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-OSX], [NO-SILICON-OSX], [LINUX-NON-FLATPAK-ONLY], and [WINDOWS-ONLY]
    grep -vE 'FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-OSX|NO-SILICON-OSX|NON-FLATPAK-LINUX-ONLY|WINDOWS-ONLY' "${DOVE_TEMP}/dove-user-pref-parsed.cfg" > "${DOVE_UNUSED}/macos-intel/dove-user-pref.cfg" || error_fn
    echo

    cat "${DOVE_TEMP}/prefs/dove-osx-intel.cfg" "${DOVE_UNUSED}/macos-intel/dove-user-pref.cfg" > "${DOVE_OSX_INTEL_DIR}/dove.cfg" || error_fn
    echo
fi

if [[ -f "${DOVE_TEMP}/prefs/dove-windows.cfg" ]]; then
    # Remove lines containing [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-WINDOWS], [LINUX-NON-FLATPAK-ONLY], [OSX-ONLY], and [SILICON-OSX-ONLY]
    grep -vE 'FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-WINDOWS|NON-FLATPAK-LINUX-ONLY|OSX-ONLY|SILICON-OSX-ONLY' "${DOVE_TEMP}/dove-user-pref-parsed.cfg" > "${DOVE_UNUSED}/windows/dove-user-pref.cfg" || error_fn
    echo

    cat "${DOVE_TEMP}/prefs/dove-windows.cfg" "${DOVE_UNUSED}/windows/dove-user-pref.cfg" > "${DOVE_WINDOWS_DIR}/dove.cfg" || error_fn
    echo
fi

if [[ -f "${DOVE_TEMP}/prefs/dove-linux.js" ]]; then
    mv "${DOVE_TEMP}/prefs/dove-linux.js" "${DOVE_ROOT}/linux/defaults/pref/dove.js" || error_fn
    echo
fi

if [[ -f "${DOVE_TEMP}/prefs/dove-linux-flatpak.js" ]]; then
    mv "${DOVE_TEMP}/prefs/dove-linux-flatpak.js" "${DOVE_ROOT}/linux-flatpak/defaults/pref/dove.js" || error_fn
    echo
fi

if [[ -f "${DOVE_TEMP}/prefs/dove-osx.js" ]]; then
    mv "${DOVE_TEMP}/prefs/dove-osx.js" "${DOVE_UNUSED}/macos/dove.js" || error_fn
    echo
fi

if [[ -f "${DOVE_TEMP}/prefs/dove-osx-intel.js" ]]; then
    mv "${DOVE_TEMP}/prefs/dove-osx-intel.js" "${DOVE_UNUSED}/macos-intel/dove.js" || error_fn
    echo
fi

if [[ -f "${DOVE_TEMP}/prefs/dove-windows.js" ]]; then
    mv "${DOVE_TEMP}/prefs/dove-windows.js" "${DOVE_UNUSED}/windows/dove.js" || error_fn
    echo
fi

# GNU/LINUX
if [ "${DOVE_LINUX}" == 1 ]; then
    echo_green_text 'Building Dove for Linux...'

    # Copy license
    cp -vf "${DOVE_ROOT}/COPYING.txt" "${DOVE_LINUX_DIR}/" || error_fn
    echo

    # Copy README
    cp -vf "${DOVE_ROOT}/README.md" "${DOVE_LINUX_DIR}/" || error_fn
    echo

    # Copy Thunderbird's autoconfiguration files
    rm -vrf "${DOVE_LINUX_DIR}/assets/autoconfig/*" || error_fn
    echo
    mkdir -vp "${DOVE_LINUX_DIR}/assets/autoconfig/v1.1" || error_fn
    echo
    cp -vrf "${DOVE_AUTOCONFIG_OUTPUT}" "${DOVE_LINUX_DIR}/assets/" || error_fn
    echo

    # Copy environment variables
    cp "${DOVE_BUILD}/linux/etc/profile.d/dove-env-overrides.sh" "${DOVE_LINUX_DIR}/etc/profile.d/dove-env-overrides.sh" || error_fn
    echo

    # Remove lines containing [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [NO-LINUX], [NO-NON-FLATPAK-LINUX], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|NO-LINUX|NO-NON-FLATPAK-LINUX|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${DOVE_TEMP}/dove-user-pref-parsed.cfg" > "${DOVE_LINUX_DIR}/dove.cfg" || error_fn
    echo
    echo "Created ${DOVE_LINUX_DIR}/dove.cfg"
fi

# GNU/LINUX (FLATPAK)
if [ "${DOVE_LINUX_FLATPAK}" == 1 ]; then
    echo_green_text 'Building Dove for Linux (Flatpak)...'

    # Copy license
    cp -vf "${DOVE_ROOT}/COPYING.txt" "${DOVE_LINUX_FLATPAK_DIR}/" || error_fn
    echo

    # Copy README
    cp -vf "${DOVE_ROOT}/README.md" "${DOVE_LINUX_FLATPAK_DIR}/" || error_fn
    echo

    # Copy Thunderbird's autoconfiguration files
    rm -vrf "${DOVE_LINUX_FLATPAK_DIR}/assets/autoconfig/*" || error_fn
    echo
    mkdir -vp "${DOVE_LINUX_FLATPAK_DIR}/assets/autoconfig/v1.1" || error_fn
    echo
    cp -vrf "${DOVE_AUTOCONFIG_OUTPUT}" "${DOVE_LINUX_FLATPAK_DIR}/assets/" || error_fn
    echo

    # Remove lines containing [INTEL-OSX-ONLY], [NO-FLATPAK-LINUX], [NO-LINUX], [LINUX-NON-FLATPAK-ONLY], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'INTEL-OSX-ONLY|NO-FLATPAK-LINUX|NO-LINUX|NON-FLATPAK-LINUX-ONLY|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${DOVE_TEMP}/dove-user-pref-parsed.cfg" > "${DOVE_LINUX_FLATPAK_DIR}/dove.cfg" || error_fn
    echo
    echo "Created ${DOVE_LINUX_FLATPAK_DIR}/dove.cfg"
fi

# OS X
if [ "${DOVE_OSX}" == 1 ]; then
    echo_green_text 'Building Dove for OS X...'

    # Copy license
    cp -vf "${DOVE_ROOT}/COPYING.txt" "${DOVE_OSX_DIR}/" || error_fn
    echo

    # Copy README
    cp -vf "${DOVE_ROOT}/README.md" "${DOVE_OSX_DIR}/" || error_fn
    echo

    # Copy Thunderbird's autoconfiguration files
    rm -vrf "${DOVE_OSX_DIR}/assets/autoconfig/*" || error_fn
    echo
    mkdir -vp "${DOVE_OSX_DIR}/assets/autoconfig/v1.1" || error_fn
    echo
    cp -vrf "${DOVE_AUTOCONFIG_OUTPUT}" "${DOVE_OSX_DIR}/assets/" || error_fn
    echo

    # Remove lines containing [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-OSX], [NO-SILICON-OSX], [LINUX-NON-FLATPAK-ONLY], and [WINDOWS-ONLY]
    grep -vE 'FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-OSX|NO-SILICON-OSX|NON-FLATPAK-LINUX-ONLY|WINDOWS-ONLY' "${DOVE_BUILD}/dove-bootstrap.js" > "${DOVE_OSX_DIR}/defaults/pref/dove.js" || error_fn
    echo
    echo "Created ${DOVE_OSX_DIR}/defaults/pref/dove.js"
fi

# OS X (INTEL)
if [ "${DOVE_OSX_INTEL}" == 1 ]; then
    echo_green_text 'Building Dove for OS X (Intel)...'

    # Copy license
    cp -vf "${DOVE_ROOT}/COPYING.txt" "${DOVE_OSX_INTEL_DIR}/" || error_fn
    echo

    # Copy README
    cp -vf "${DOVE_ROOT}/README.md" "${DOVE_OSX_INTEL_DIR}/" || error_fn
    echo

    # Copy Thunderbird's autoconfiguration files
    rm -vrf "${DOVE_OSX_INTEL_DIR}/assets/autoconfig/*" || error_fn
    echo
    mkdir -vp "${DOVE_OSX_INTEL_DIR}/assets/autoconfig/v1.1" || error_fn
    echo
    cp -vrf "${DOVE_AUTOCONFIG_OUTPUT}" "${DOVE_OSX_INTEL_DIR}/assets/" || error_fn
    echo

    # Remove lines containing [FLATPAK-LINUX-ONLY], [LINUX-ONLY], [NO-INTEL-OSX], [NO-OSX], [LINUX-NON-FLATPAK-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'FLATPAK-LINUX-ONLY|LINUX-ONLY|NO-INTEL-OSX|NO-OSX|NON-FLATPAK-LINUX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${DOVE_BUILD}/dove-bootstrap.js" > "${DOVE_OSX_INTEL_DIR}/defaults/pref/dove.js" || error_fn
    echo
    echo "Created ${DOVE_OSX_INTEL_DIR}/defaults/pref/dove.js"
fi

# WINDOWS
if [ "${DOVE_WINDOWS}" == 1 ]; then
    echo_green_text 'Building Dove for Windows...'

    # Copy license
    cp -vf "${DOVE_ROOT}/COPYING.txt" "${DOVE_WINDOWS_DIR}/" || error_fn
    echo

    # Copy README
    cp -vf "${DOVE_ROOT}/README.md" "${DOVE_WINDOWS_DIR}/" || error_fn
    echo

    # Copy Thunderbird's autoconfiguration files
    rm -vrf "${DOVE_WINDOWS_DIR}/assets/autoconfig/*" || error_fn
    echo
    mkdir -vp "${DOVE_WINDOWS_DIR}/assets/autoconfig/v1.1" || error_fn
    echo
    cp -vrf "${DOVE_AUTOCONFIG_OUTPUT}" "${DOVE_WINDOWS_DIR}/assets/" || error_fn
    echo

    # Remove lines containing [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-WINDOWS], [LINUX-NON-FLATPAK-ONLY], [OSX-ONLY], and [SILICON-OSX-ONLY]
    grep -vE 'FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-WINDOWS|NON-FLATPAK-LINUX-ONLY|OSX-ONLY|SILICON-OSX-ONLY' "${DOVE_BUILD}/dove-bootstrap.js" > "${DOVE_WINDOWS_DIR}/defaults/pref/dove.js" || error_fn
    echo
    echo "Created ${DOVE_WINDOWS_DIR}/defaults/pref/dove.js"
fi
