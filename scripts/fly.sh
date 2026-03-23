#!/bin/bash

set -euo pipefail

if [[ -z "${DOVE_FROM_BUILD+x}" ]]; then
    echo_red_text 'ERROR: Do not call fly.sh directly. Instead, use build.sh.' >&1
    exit 1
fi

# Welcome to the Dove Unified build script!
# This script should be ran AFTER building Phoenix, from the ROOT of the Dove repo

# Set-up our environment
source $(dirname $0)/env.sh || error_fn
echo

# Ensure our directories exist
if [ "${DOVE_LINUX}" == 1 ]; then
    mkdir -vp "${DOVE_LINUX_OUTPUTS}/unused" || error_fn
    echo
fi
if [ "${DOVE_LINUX_FLATPAK}" == 1 ]; then
    mkdir -vp "${DOVE_LINUX_FLATPAK_OUTPUTS}/unused" || error_fn
    echo
fi
if [ "${DOVE_OSX}" == 1 ]; then
    mkdir -vp "${DOVE_OSX_OUTPUTS}/unused" || error_fn
    echo
fi
if [ "${DOVE_OSX_INTEL}" == 1 ]; then
    mkdir -vp "${DOVE_OSX_INTEL_OUTPUTS}/unused" || error_fn
    echo
fi
if [ "${DOVE_WINDOWS}" == 1 ]; then
    mkdir -vp "${DOVE_WINDOWS_OUTPUTS}/unused" || error_fn
    echo
fi

# Move files to their appropriate locations
if [[ -f "${DOVE_OSX_OUTPUTS}/macos/org.mozilla.firefox.plist" ]]; then
    mv "${DOVE_OSX_OUTPUTS}/macos/org.mozilla.firefox.plist" "${DOVE_OSX_OUTPUTS}/macos/org.mozilla.thunderbird.plist" || error_fn
    echo
fi

if [[ -f "${DOVE_OSX_INTEL_OUTPUTS}/org.mozilla.firefox.plist" ]]; then
    mv "${DOVE_OSX_INTEL_OUTPUTS}/org.mozilla.firefox.plist" "${DOVE_OSX_INTEL_OUTPUTS}/org.mozilla.thunderbird.plist" || error_fn
    echo
fi

if [[ -f "${DOVE_OSX_OUTPUTS}/macos/policies.json" ]]; then
    mv "${DOVE_OSX_OUTPUTS}/macos/policies.json" "${DOVE_OSX_OUTPUTS}/unused/policies.json" || error_fn
    echo
fi

if [[ -f "${DOVE_OSX_INTEL_OUTPUTS}/policies.json" ]]; then
    mv "${DOVE_OSX_INTEL_OUTPUTS}/policies.json" "${DOVE_OSX_INTEL_OUTPUTS}/unused/policies.json" || error_fn
    echo
fi

if [[ -f "${DOVE_TEMP}/prefs/dove-linux.cfg" ]]; then
    mv "${DOVE_TEMP}/prefs/dove-linux.cfg" "${DOVE_LINUX_OUTPUTS}/unused/dove.cfg" || error_fn
    echo
fi

if [[ -f "${DOVE_TEMP}/prefs/dove-linux-flatpak.cfg" ]]; then
    mv "${DOVE_TEMP}/prefs/dove-linux-flatpak.cfg" "${DOVE_LINUX_FLATPAK_OUTPUTS}/unused/dove.cfg" || error_fn
    echo
fi

if [[ -f "${DOVE_TEMP}/prefs/dove-osx.cfg" ]]; then
    # Remove lines containing [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-OSX], [NO-SILICON-OSX], [LINUX-NON-FLATPAK-ONLY], and [WINDOWS-ONLY]
    grep -vE 'FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-OSX|NO-SILICON-OSX|NON-FLATPAK-LINUX-ONLY|WINDOWS-ONLY' "${DOVE_TEMP}/dove-user-pref-parsed.cfg" > "${DOVE_OSX_OUTPUTS}/unused/dove-user-pref.cfg" || error_fn
    echo

    cat "${DOVE_TEMP}/prefs/dove-osx.cfg" "${DOVE_OSX_OUTPUTS}/unused/dove-user-pref.cfg" > "${DOVE_OSX_OUTPUTS}/macos/dove.cfg" || error_fn
    echo
fi

if [[ -f "${DOVE_TEMP}/prefs/dove-osx-intel.cfg" ]]; then
    # Remove lines containing [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-OSX], [NO-SILICON-OSX], [LINUX-NON-FLATPAK-ONLY], and [WINDOWS-ONLY]
    grep -vE 'FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-OSX|NO-SILICON-OSX|NON-FLATPAK-LINUX-ONLY|WINDOWS-ONLY' "${DOVE_TEMP}/dove-user-pref-parsed.cfg" > "${DOVE_OSX_INTEL_OUTPUTS}/unused/dove-user-pref.cfg" || error_fn
    echo

    cat "${DOVE_TEMP}/prefs/dove-osx-intel.cfg" "${DOVE_OSX_INTEL_OUTPUTS}/unused/dove-user-pref.cfg" > "${DOVE_OSX_INTEL_OUTPUTS}/dove.cfg" || error_fn
    echo
fi

if [[ -f "${DOVE_TEMP}/prefs/dove-windows.cfg" ]]; then
    # Remove lines containing [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-WINDOWS], [LINUX-NON-FLATPAK-ONLY], [OSX-ONLY], and [SILICON-OSX-ONLY]
    grep -vE 'FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-WINDOWS|NON-FLATPAK-LINUX-ONLY|OSX-ONLY|SILICON-OSX-ONLY' "${DOVE_TEMP}/dove-user-pref-parsed.cfg" > "${DOVE_WINDOWS_OUTPUTS}/unused/dove-user-pref.cfg" || error_fn
    echo

    cat "${DOVE_TEMP}/prefs/dove-windows.cfg" "${DOVE_WINDOWS_OUTPUTS}/unused/dove-user-pref.cfg" > "${DOVE_WINDOWS_OUTPUTS}/dove.cfg" || error_fn
    echo
fi

if [[ -f "${DOVE_TEMP}/prefs/dove-linux.js" ]]; then
    mv "${DOVE_TEMP}/prefs/dove-linux.js" "${DOVE_LINUX_OUTPUTS}/defaults/pref/dove.js" || error_fn
    echo
fi

if [[ -f "${DOVE_TEMP}/prefs/dove-linux-flatpak.js" ]]; then
    mv "${DOVE_TEMP}/prefs/dove-linux-flatpak.js" "${DOVE_LINUX_FLATPAK_OUTPUTS}/defaults/pref/dove.js" || error_fn
    echo
fi

if [[ -f "${DOVE_TEMP}/prefs/dove-osx.js" ]]; then
    mv "${DOVE_TEMP}/prefs/dove-osx.js" "${DOVE_OSX_OUTPUTS}/unused/dove.js" || error_fn
    echo
fi

if [[ -f "${DOVE_TEMP}/prefs/dove-osx-intel.js" ]]; then
    mv "${DOVE_TEMP}/prefs/dove-osx-intel.js" "${DOVE_OSX_INTEL_OUTPUTS}/unused/dove.js" || error_fn
    echo
fi

if [[ -f "${DOVE_TEMP}/prefs/dove-windows.js" ]]; then
    mv "${DOVE_TEMP}/prefs/dove-windows.js" "${DOVE_WINDOWS_OUTPUTS}/unused/dove.js" || error_fn
    echo
fi

# GNU/LINUX
if [ "${DOVE_LINUX}" == 1 ]; then
    echo_green_text 'Building Dove for Linux...'
    mkdir -vp "${DOVE_LINUX_OUTPUTS}/assets" || error_fn
    echo
    mkdir -vp "${DOVE_LINUX_OUTPUTS}/defaults/pref" || error_fn
    echo
    mkdir -vp "${DOVE_LINUX_OUTPUTS}/etc/profile.d" || error_fn
    echo
    mkdir -vp "${DOVE_LINUX_OUTPUTS}/policies" || error_fn
    echo

    # Copy license
    cp -vf "${DOVE_ROOT}/COPYING.txt" "${DOVE_LINUX_OUTPUTS}/" || error_fn
    echo

    # Copy README
    cp -vf "${DOVE_ROOT}/README.md" "${DOVE_LINUX_OUTPUTS}/" || error_fn
    echo

    # Copy assets
    cp "${DOVE_BUILD_RESOURCES}/assets/dove.png" "${DOVE_LINUX_OUTPUTS}/assets/" || error_fn
    echo

    # Copy Thunderbird's autoconfiguration files
    rm -vrf "${DOVE_LINUX_OUTPUTS}/assets/autoconfig/*" || error_fn
    echo
    mkdir -vp "${DOVE_LINUX_OUTPUTS}/assets/autoconfig/v1.1" || error_fn
    echo
    cp -vrf "${DOVE_BUILD}/autoconfig" "${DOVE_LINUX_OUTPUTS}/assets/" || error_fn
    echo

    # Copy environment variables
    cp "${DOVE_BUILD_RESOURCES}/linux/etc/profile.d/dove-env-overrides.sh" "${DOVE_LINUX_OUTPUTS}/etc/profile.d/" || error_fn
    echo

    # Remove lines containing [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [NO-LINUX], [NO-NON-FLATPAK-LINUX], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|NO-LINUX|NO-NON-FLATPAK-LINUX|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${DOVE_TEMP}/dove-user-pref-parsed.cfg" > "${DOVE_LINUX_OUTPUTS}/dove.cfg" || error_fn
    echo
    echo "Created ${DOVE_LINUX_OUTPUTS}/dove.cfg"
fi

# GNU/LINUX (FLATPAK)
if [ "${DOVE_LINUX_FLATPAK}" == 1 ]; then
    echo_green_text 'Building Dove for Linux (Flatpak)...'
    mkdir -vp "${DOVE_LINUX_FLATPAK_OUTPUTS}/assets" || error_fn
    echo
    mkdir -vp "${DOVE_LINUX_FLATPAK_OUTPUTS}/defaults/pref" || error_fn
    echo
    mkdir -vp "${DOVE_LINUX_FLATPAK_OUTPUTS}/policies" || error_fn
    echo

    # Copy license
    cp -vf "${DOVE_ROOT}/COPYING.txt" "${DOVE_LINUX_FLATPAK_OUTPUTS}/" || error_fn
    echo

    # Copy README
    cp -vf "${DOVE_ROOT}/README.md" "${DOVE_LINUX_FLATPAK_OUTPUTS}/" || error_fn
    echo

    # Copy assets
    cp "${DOVE_BUILD_RESOURCES}/assets/dove.png" "${DOVE_LINUX_FLATPAK_OUTPUTS}/assets/" || error_fn
    echo

    # Copy Thunderbird's autoconfiguration files
    rm -vrf "${DOVE_LINUX_FLATPAK_OUTPUTS}/assets/autoconfig/*" || error_fn
    echo
    mkdir -vp "${DOVE_LINUX_FLATPAK_OUTPUTS}/assets/autoconfig/v1.1" || error_fn
    echo
    cp -vrf "${DOVE_BUILD}/autoconfig" "${DOVE_LINUX_FLATPAK_OUTPUTS}/assets/" || error_fn
    echo

    # Remove lines containing [INTEL-OSX-ONLY], [NO-FLATPAK-LINUX], [NO-LINUX], [LINUX-NON-FLATPAK-ONLY], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'INTEL-OSX-ONLY|NO-FLATPAK-LINUX|NO-LINUX|NON-FLATPAK-LINUX-ONLY|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${DOVE_TEMP}/dove-user-pref-parsed.cfg" > "${DOVE_LINUX_FLATPAK_OUTPUTS}/dove.cfg" || error_fn
    echo
    echo "Created ${DOVE_LINUX_FLATPAK_OUTPUTS}/dove.cfg"
fi

# OS X
if [ "${DOVE_OSX}" == 1 ]; then
    echo_green_text 'Building Dove for OS X...'
    mkdir -vp "${DOVE_OSX_OUTPUTS}/assets" || error_fn
    echo
    mkdir -vp "${DOVE_OSX_OUTPUTS}/defaults/pref" || error_fn
    echo
    mkdir -vp "${DOVE_OSX_OUTPUTS}/Library/celenity" || error_fn
    echo
    mkdir -vp "${DOVE_OSX_OUTPUTS}/macos" || error_fn
    echo

    # Copy license
    cp -vf "${DOVE_ROOT}/COPYING.txt" "${DOVE_OSX_OUTPUTS}/" || error_fn
    echo

    # Copy README
    cp -vf "${DOVE_ROOT}/README.md" "${DOVE_OSX_OUTPUTS}/" || error_fn
    echo

    # Copy assets
    cp "${DOVE_BUILD_RESOURCES}/assets/dove.png" "${DOVE_OSX_OUTPUTS}/assets/" || error_fn
    echo

    # Copy Thunderbird's autoconfiguration files
    rm -vrf "${DOVE_OSX_OUTPUTS}/assets/autoconfig/*" || error_fn
    echo
    mkdir -vp "${DOVE_OSX_OUTPUTS}/assets/autoconfig/v1.1" || error_fn
    echo
    cp -vrf "${DOVE_BUILD}/autoconfig" "${DOVE_OSX_OUTPUTS}/assets/" || error_fn
    echo

    # Copy OS X-specific files
    cp -rf "${DOVE_BUILD_RESOURCES}/osx-shared/Library/LaunchAgents" "${DOVE_OSX_OUTPUTS}/Library/"

    cp -rf "${DOVE_BUILD_RESOURCES}/osx/Library/celenity/Dove" "${DOVE_OSX_OUTPUTS}/Library/celenity/"
    cp -rf "${DOVE_BUILD_RESOURCES}/osx/Library/LaunchDaemons" "${DOVE_OSX_OUTPUTS}/Library/"

    # Remove lines containing [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-OSX], [NO-SILICON-OSX], [LINUX-NON-FLATPAK-ONLY], and [WINDOWS-ONLY]
    grep -vE 'FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-OSX|NO-SILICON-OSX|NON-FLATPAK-LINUX-ONLY|WINDOWS-ONLY' "${DOVE_BUILD_RESOURCES}/dove-bootstrap.js" > "${DOVE_OSX_OUTPUTS}/defaults/pref/dove.js" || error_fn
    echo
    echo "Created ${DOVE_OSX_OUTPUTS}/defaults/pref/dove.js"
fi

# OS X (INTEL)
if [ "${DOVE_OSX_INTEL}" == 1 ]; then
    echo_green_text 'Building Dove for OS X (Intel)...'
    mkdir -vp "${DOVE_OSX_INTEL_OUTPUTS}/assets" || error_fn
    echo
    mkdir -vp "${DOVE_OSX_INTEL_OUTPUTS}/defaults/pref" || error_fn
    echo
    mkdir -vp "${DOVE_OSX_INTEL_OUTPUTS}/Library/celenity" || error_fn
    echo

    # Copy license
    cp -vf "${DOVE_ROOT}/COPYING.txt" "${DOVE_OSX_INTEL_OUTPUTS}/" || error_fn
    echo

    # Copy README
    cp -vf "${DOVE_ROOT}/README.md" "${DOVE_OSX_INTEL_OUTPUTS}/" || error_fn
    echo

    # Copy assets
    cp "${DOVE_BUILD_RESOURCES}/assets/dove.png" "${DOVE_OSX_INTEL_OUTPUTS}/assets/" || error_fn
    echo

    # Copy Thunderbird's autoconfiguration files
    rm -vrf "${DOVE_OSX_INTEL_OUTPUTS}/assets/autoconfig/*" || error_fn
    echo
    mkdir -vp "${DOVE_OSX_INTEL_OUTPUTS}/assets/autoconfig/v1.1" || error_fn
    echo
    cp -vrf "${DOVE_BUILD}/autoconfig" "${DOVE_OSX_INTEL_OUTPUTS}/assets/" || error_fn
    echo

    # Copy OS X-specific files
    cp -rf "${DOVE_BUILD_RESOURCES}/osx-shared/Library/LaunchAgents" "${DOVE_OSX_INTEL_OUTPUTS}/Library/"

    cp -rf "${DOVE_BUILD_RESOURCES}/osx-intel/Library/celenity/Dove" "${DOVE_OSX_INTEL_OUTPUTS}/Library/celenity/"
    cp -rf "${DOVE_BUILD_RESOURCES}/osx-intel/Library/LaunchDaemons" "${DOVE_OSX_INTEL_OUTPUTS}/Library/"

    # Remove lines containing [FLATPAK-LINUX-ONLY], [LINUX-ONLY], [NO-INTEL-OSX], [NO-OSX], [LINUX-NON-FLATPAK-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'FLATPAK-LINUX-ONLY|LINUX-ONLY|NO-INTEL-OSX|NO-OSX|NON-FLATPAK-LINUX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${DOVE_BUILD_RESOURCES}/dove-bootstrap.js" > "${DOVE_OSX_INTEL_OUTPUTS}/defaults/pref/dove.js" || error_fn
    echo
    echo "Created ${DOVE_OSX_INTEL_OUTPUTS}/defaults/pref/dove.js"
fi

# WINDOWS
if [ "${DOVE_WINDOWS}" == 1 ]; then
    echo_green_text 'Building Dove for Windows...'

    # Copy license
    cp -vf "${DOVE_ROOT}/COPYING.txt" "${DOVE_WINDOWS_OUTPUTS}/" || error_fn
    echo

    # Copy README
    cp -vf "${DOVE_ROOT}/README.md" "${DOVE_WINDOWS_OUTPUTS}/" || error_fn
    echo

    # Copy assets
    cp "${DOVE_BUILD_RESOURCES}/assets/dove.png" "${DOVE_WINDOWS_OUTPUTS}/assets/" || error_fn
    echo

    # Copy Thunderbird's autoconfiguration files
    rm -vrf "${DOVE_WINDOWS_OUTPUTS}/assets/autoconfig/*" || error_fn
    echo
    mkdir -vp "${DOVE_WINDOWS_OUTPUTS}/assets/autoconfig/v1.1" || error_fn
    echo
    cp -vrf "${DOVE_BUILD}/autoconfig" "${DOVE_WINDOWS_OUTPUTS}/assets/" || error_fn
    echo

    # Remove lines containing [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-WINDOWS], [LINUX-NON-FLATPAK-ONLY], [OSX-ONLY], and [SILICON-OSX-ONLY]
    grep -vE 'FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-WINDOWS|NON-FLATPAK-LINUX-ONLY|OSX-ONLY|SILICON-OSX-ONLY' "${DOVE_BUILD_RESOURCES}/dove-bootstrap.js" > "${DOVE_WINDOWS_OUTPUTS}/defaults/pref/dove.js" || error_fn
    echo
    echo "Created ${DOVE_WINDOWS_OUTPUTS}/defaults/pref/dove.js"
fi
