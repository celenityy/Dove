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

# Welcome to the Dove Unified build script!
# This script should be ran from inside the directory where you store Dove, not directly from the 'archives' or `build` folder...

# Set-up our environment
bash -x $(dirname $0)/env.sh || error_fn
echo
source $(dirname $0)/env.sh || error_fn
echo

# Include version info
source "${DOVE_VERSIONS}" || error_fn
echo

mkdir -vp "${DOVE_TEMP}/policies" || error_fn
echo

DOVE_LICENSE="${DOVE_ROOT}/COPYING.txt"
DOVE_README="${DOVE_ROOT}/README.md"

PHOENIX_UNIFIED_PREFS="${DOVE_PHOENIX}/build/phoenix-unified.js"
DOVE_UNIFIED_PREFS="${DOVE_BUILD}/dove-unified.js"

DOVE_LINUX_FLATPAK_PREFS="${DOVE_LINUX_FLATPAK_DIR}/defaults/pref/dove.js"
DOVE_LINUX_PREFS="${DOVE_LINUX_DIR}/defaults/pref/dove.js"
DOVE_OSX_INTEL_PREFS="${DOVE_UNUSED}/macos-intel/dove.js"
DOVE_OSX_PREFS="${DOVE_UNUSED}/macos/dove.js"
DOVE_WINDOWS_PREFS="${DOVE_UNUSED}/windows/dove.js"

DOVE_BOOTSTRAP="${DOVE_BUILD}/dove-bootstrap.js"

DOVE_OSX_BOOTSTRAP="${DOVE_OSX_DIR}/defaults/pref/dove.js"
DOVE_OSX_INTEL_BOOTSTRAP="${DOVE_OSX_INTEL_DIR}/defaults/pref/dove.js"
DOVE_WINDOWS_BOOTSTRAP="${DOVE_WINDOWS_DIR}/defaults/pref/dove.js"

DOVE_USER_PREF_CFG="${DOVE_BUILD}/dove-user-pref.cfg"

DOVE_LINUX_FLATPAK_USER_PREF_CFG="${DOVE_LINUX_FLATPAK_DIR}/dove.cfg"
DOVE_LINUX_USER_PREF_CFG="${DOVE_LINUX_DIR}/dove.cfg"

DOVE_LINUX_CFG="${DOVE_UNUSED}/linux/dove.cfg"
DOVE_LINUX_FLATPAK_CFG="${DOVE_UNUSED}/linux-flatpak/dove.cfg"
DOVE_OSX_CFG="${DOVE_OSX_DIR}/macos/dove.cfg"
DOVE_OSX_INTEL_CFG="${DOVE_OSX_INTEL_DIR}/dove.cfg"
DOVE_WINDOWS_CFG="${DOVE_WINDOWS_DIR}/dove.cfg"

PHOENIX_EXTENDED_UNIFIED_PREFS="${DOVE_PHOENIX}/build/phoenix-extended-unified.js"

PHOENIX_UNIFIED_POLICIES="${DOVE_PHOENIX}/build/policies/phoenix-unified.json"

PHOENIX_BLOCKLIST_POLICIES="${DOVE_PHOENIX}/build/policies/blocklist.json"
PHOENIX_COOKIES_POLICIES="${DOVE_PHOENIX}/build/policies/cookies.json"

PHOENIX_UNIFIED_LINUX_FLATPAK_POLICIES="${DOVE_PHOENIX}/build/policies/phoenix-linux-flatpak-unified.json"
PHOENIX_UNIFIED_LINUX_POLICIES="${DOVE_PHOENIX}/build/policies/phoenix-linux-unified.json"
PHOENIX_UNIFIED_LINUX_NONFLATPAK_POLICIES="${DOVE_PHOENIX}/build/policies/phoenix-linux-non-flatpak-unified.json"
PHOENIX_UNIFIED_OSX_INTEL_POLICIES="${DOVE_PHOENIX}/build/policies/phoenix-osx-intel-unified.json"
PHOENIX_UNIFIED_OSX_POLICIES="${DOVE_PHOENIX}/build/policies/phoenix-osx-unified.json"
PHOENIX_UNIFIED_OSX_SILICON_POLICIES="${DOVE_PHOENIX}/build/policies/phoenix-osx-silicon-unified.json"
PHOENIX_UNIFIED_WINDOWS_POLICIES="${DOVE_PHOENIX}/build/policies/phoenix-windows-unified.json"

DOVE_UNIFIED_POLICIES="${DOVE_BUILD}/policies/dove-unified.json"

DOVE_UNIFIED_LINUX_FLATPAK_POLICIES="${DOVE_BUILD}/policies/dove-linux-flatpak.json"
DOVE_UNIFIED_LINUX_NONFLATPAK_POLICIES="${DOVE_BUILD}/policies/dove-linux-nonflatpak.json"
DOVE_UNIFIED_LINUX_POLICIES="${DOVE_BUILD}/policies/dove-linux.json"
DOVE_UNIFIED_OSX_INTEL_POLICIES="${DOVE_BUILD}/policies/dove-osx-intel.json"
DOVE_UNIFIED_OSX_POLICIES="${DOVE_BUILD}/policies/dove-osx.json"
DOVE_UNIFIED_OSX_SILICON_POLICIES="${DOVE_BUILD}/policies/dove-osx-silicon.json"
DOVE_UNIFIED_WINDOWS_POLICIES="${DOVE_BUILD}/policies/dove-windows.json"

DOVE_POLICIES="${DOVE_UNUSED}/policies/dove.json"

DOVE_LINUX_FLATPAK_POLICIES="${DOVE_LINUX_FLATPAK_DIR}/policies/policies.json"
DOVE_LINUX_POLICIES="${DOVE_LINUX_DIR}/policies/policies.json"
DOVE_WINDOWS_POLICIES="${DOVE_WINDOWS_DIR}/distribution/policies.json"

DOVE_OSX_INTEL_POLICIES_JSON="${DOVE_UNUSED}/macos-intel/policies.json"
DOVE_OSX_INTEL_POLICIES_PLIST="${DOVE_OSX_INTEL_DIR}/org.mozilla.thunderbird.plist"
DOVE_OSX_POLICIES_JSON="${DOVE_UNUSED}/macos/policies.json"
DOVE_OSX_POLICIES_PLIST="${DOVE_OSX_DIR}/macos/org.mozilla.thunderbird.plist"

# GNU/LINUX
if [ "${DOVE_LINUX}" == 1 ]; then
    echo_green_text 'Building Dove for Linux...'
    mkdir -vp "${DOVE_LINUX_DIR}/defaults/pref" || error_fn
    echo
    mkdir -vp "${DOVE_LINUX_DIR}/etc/profile.d" || error_fn
    echo
    mkdir -vp "${DOVE_LINUX_DIR}/policies" || error_fn
    echo

    # Copy license
    cp -vf "${DOVE_LICENSE}" "${DOVE_LINUX_DIR}/" || error_fn
    echo

    # Copy README
    cp -vf "${DOVE_README}" "${DOVE_LINUX_DIR}/" || error_fn
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
    grep -vE 'FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|NO-LINUX|NO-NON-FLATPAK-LINUX|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${DOVE_USER_PREF_CFG}" > "${DOVE_LINUX_USER_PREF_CFG}" || error_fn
    echo
    echo "Created ${DOVE_LINUX_USER_PREF_CFG}"

    # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [NO-LINUX], [NO-NON-FLATPAK-LINUX], [NO-MAIL], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|NO-LINUX|NO-MAIL|NO-NON-FLATPAK-LINUX|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_UNIFIED_PREFS}" > "${DOVE_TEMP}/linux-temp1.js" || error_fn
    echo
    echo "Created ${DOVE_TEMP}/linux-temp1.js"

    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|NO-LINUX|NO-MAIL|NO-NON-FLATPAK-LINUX|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_EXTENDED_UNIFIED_PREFS}" > "${DOVE_TEMP}/linux-temp2.js" || error_fn
    echo
    echo "Created ${DOVE_TEMP}/linux-temp2.js"

    # Remove lines containing [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [NO-LINUX], [NO-NON-FLATPAK-LINUX], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|NO-LINUX|NO-NON-FLATPAK-LINUX|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${DOVE_UNIFIED_PREFS}" > "${DOVE_TEMP}/linux-temp3.js" || error_fn
    echo
    echo "Created ${DOVE_TEMP}/linux-temp3.js"

    cat "${DOVE_TEMP}/linux-temp1.js" "${DOVE_TEMP}/linux-temp2.js" "${DOVE_TEMP}/linux-temp3.js" > "${DOVE_LINUX_PREFS}" || error_fn
    echo

    python3 "${DOVE_BUILD}/convert.py" "${DOVE_LINUX_PREFS}" "${DOVE_LINUX_CFG}" || error_fn
    echo

    # Update the version
    "${DOVE_SED}" -i "s|{DOVE_VERSION}|${DOVE_VERSION}|" "${DOVE_LINUX_CFG}" || error_fn
    echo
    "${DOVE_SED}" -i "s|{DOVE_VERSION}|${DOVE_VERSION}|" "${DOVE_LINUX_PREFS}" || error_fn
    echo
    "${DOVE_SED}" -i "s|{DOVE_VERSION}|${DOVE_VERSION}|" "${DOVE_LINUX_USER_PREF_CFG}" || error_fn
    echo
    "${DOVE_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${DOVE_LINUX_CFG}" || error_fn
    echo
    "${DOVE_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${DOVE_LINUX_PREFS}" || error_fn
    echo
    "${DOVE_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${DOVE_LINUX_USER_PREF_CFG}" || error_fn
    echo
fi

# GNU/LINUX (FLATPAK)
if [ "${DOVE_LINUX_FLATPAK}" == 1 ]; then
    echo_green_text 'Building Dove for Linux (Flatpak)...'
    mkdir -vp "${DOVE_LINUX_FLATPAK_DIR}/defaults/pref" || error_fn
    echo
    mkdir -vp "${DOVE_LINUX_FLATPAK_DIR}/policies" || error_fn
    echo

    # Copy license
    cp -vf "${DOVE_LICENSE}" "${DOVE_LINUX_FLATPAK_DIR}/" || error_fn
    echo

    # Copy README
    cp -vf "${DOVE_README}" "${DOVE_LINUX_FLATPAK_DIR}/" || error_fn
    echo

    # Copy Thunderbird's autoconfiguration files
    rm -vrf "${DOVE_LINUX_FLATPAK_DIR}/assets/autoconfig/*" || error_fn
    echo
    mkdir -vp "${DOVE_LINUX_FLATPAK_DIR}/assets/autoconfig/v1.1" || error_fn
    echo
    cp -vrf "${DOVE_AUTOCONFIG_OUTPUT}" "${DOVE_LINUX_FLATPAK_DIR}/assets/" || error_fn
    echo

    # Remove lines containing [INTEL-OSX-ONLY], [NO-FLATPAK-LINUX], [NO-LINUX], [LINUX-NON-FLATPAK-ONLY], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'INTEL-OSX-ONLY|NO-FLATPAK-LINUX|NO-LINUX|NON-FLATPAK-LINUX-ONLY|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${DOVE_USER_PREF_CFG}" > "${DOVE_LINUX_FLATPAK_USER_PREF_CFG}" || error_fn
    echo
    echo "Created ${DOVE_LINUX_FLATPAK_USER_PREF_CFG}"

    # Remove lines containing [ANDROID-ONLY], [INTEL-OSX-ONLY], [NO-FLATPAK-LINUX], [NO-LINUX], [NO-MAIL], [LINUX-NON-FLATPAK-ONLY], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'ANDROID-ONLY|INTEL-OSX-ONLY|NO-FLATPAK-LINUX|NO-LINUX|NO-MAIL|NON-FLATPAK-LINUX-ONLY|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_UNIFIED_PREFS}" > "${DOVE_TEMP}/linux-flatpak-temp1.js" || error_fn
    echo
    echo "Created ${DOVE_TEMP}/linux-flatpak-temp1.js"

    grep -vE 'ANDROID-ONLY|INTEL-OSX-ONLY|NO-FLATPAK-LINUX|NO-LINUX|NO-MAIL|NON-FLATPAK-LINUX-ONLY|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_EXTENDED_UNIFIED_PREFS}" > "${DOVE_TEMP}/linux-flatpak-temp2.js" || error_fn
    echo
    echo "Created ${DOVE_TEMP}/linux-flatpak-temp2.js"

    # Remove lines containing [INTEL-OSX-ONLY], [NO-FLATPAK-LINUX], [NO-LINUX], [LINUX-NON-FLATPAK-ONLY], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'INTEL-OSX-ONLY|NO-FLATPAK-LINUX|NO-LINUX|NON-FLATPAK-LINUX-ONLY|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${DOVE_UNIFIED_PREFS}" > "${DOVE_TEMP}/linux-flatpak-temp3.js" || error_fn
    echo
    echo "Created ${DOVE_TEMP}/linux-flatpak-temp3.js"

    cat "${DOVE_TEMP}/linux-flatpak-temp1.js" "${DOVE_TEMP}/linux-flatpak-temp2.js" "${DOVE_TEMP}/linux-flatpak-temp3.js" > "${DOVE_LINUX_FLATPAK_PREFS}" || error_fn
    echo

    python3 "${DOVE_BUILD}/convert.py" "${DOVE_LINUX_FLATPAK_PREFS}" "${DOVE_LINUX_FLATPAK_CFG}" || error_fn
    echo

    # Update the version
    "${DOVE_SED}" -i "s|{DOVE_VERSION}|${DOVE_VERSION}|" "${DOVE_LINUX_FLATPAK_CFG}" || error_fn
    echo
    "${DOVE_SED}" -i "s|{DOVE_VERSION}|${DOVE_VERSION}|" "${DOVE_LINUX_FLATPAK_PREFS}" || error_fn
    echo
    "${DOVE_SED}" -i "s|{DOVE_VERSION}|${DOVE_VERSION}|" "${DOVE_LINUX_FLATPAK_USER_PREF_CFG}" || error_fn
    echo
    "${DOVE_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${DOVE_LINUX_FLATPAK_CFG}" || error_fn
    echo
    "${DOVE_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${DOVE_LINUX_FLATPAK_PREFS}" || error_fn
    echo
    "${DOVE_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${DOVE_LINUX_FLATPAK_USER_PREF_CFG}" || error_fn
    echo
fi

# OS X
if [ "${DOVE_OSX}" == 1 ]; then
    echo_green_text 'Building Dove for OS X...'
    mkdir -vp "${DOVE_OSX_DIR}/defaults/pref" || error_fn
    echo
    mkdir -vp "${DOVE_OSX_DIR}/macos" || error_fn
    echo

    # Copy license
    cp -vf "${DOVE_LICENSE}" "${DOVE_OSX_DIR}/" || error_fn
    echo

    # Copy README
    cp -vf "${DOVE_README}" "${DOVE_OSX_DIR}/" || error_fn
    echo

    # Copy Thunderbird's autoconfiguration files
    rm -vrf "${DOVE_OSX_DIR}/assets/autoconfig/*" || error_fn
    echo
    mkdir -vp "${DOVE_OSX_DIR}/assets/autoconfig/v1.1" || error_fn
    echo
    cp -vrf "${DOVE_AUTOCONFIG_OUTPUT}" "${DOVE_OSX_DIR}/assets/" || error_fn
    echo

    # Remove lines containing [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-OSX], [NO-SILICON-OSX], [LINUX-NON-FLATPAK-ONLY], and [WINDOWS-ONLY]
    grep -vE 'FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-OSX|NO-SILICON-OSX|NON-FLATPAK-LINUX-ONLY|WINDOWS-ONLY' "${DOVE_BOOTSTRAP}" > "${DOVE_OSX_BOOTSTRAP}" || error_fn
    echo
    echo "Created ${DOVE_OSX_BOOTSTRAP}"

    # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-MAIL], [NO-OSX], [NO-SILICON-OSX], [LINUX-NON-FLATPAK-ONLY], and [WINDOWS-ONLY]
    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-MAIL|NO-OSX|NO-SILICON-OSX|NON-FLATPAK-LINUX-ONLY|WINDOWS-ONLY' "${PHOENIX_UNIFIED_PREFS}" > "${DOVE_TEMP}/osx-temp1.js" || error_fn
    echo
    echo "Created ${DOVE_TEMP}/osx-temp1.js"

    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-MAIL|NO-OSX|NO-SILICON-OSX|NON-FLATPAK-LINUX-ONLY|WINDOWS-ONLY' "${PHOENIX_EXTENDED_UNIFIED_PREFS}" > "${DOVE_TEMP}/osx-temp2.js" || error_fn
    echo
    echo "Created ${DOVE_TEMP}/osx-temp2.js"

    # Remove lines containing [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-OSX], [NO-SILICON-OSX], [LINUX-NON-FLATPAK-ONLY], and [WINDOWS-ONLY]
    grep -vE 'FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-OSX|NO-SILICON-OSX|NON-FLATPAK-LINUX-ONLY|WINDOWS-ONLY' "${DOVE_UNIFIED_PREFS}" > "${DOVE_TEMP}/osx-temp3.js" || error_fn
    echo
    echo "Created ${DOVE_TEMP}/osx-temp3.js"

    cat "${DOVE_TEMP}/osx-temp1.js" "${DOVE_TEMP}/osx-temp2.js" "${DOVE_TEMP}/osx-temp3.js" > "${DOVE_OSX_PREFS}" || error_fn
    echo

    python3 "${DOVE_BUILD}/convert.py" "${DOVE_OSX_PREFS}" "${DOVE_TEMP}/dove-osx-tmp.cfg" || error_fn
    echo

    # Add "user" prefs
    cat "${DOVE_TEMP}/dove-osx-tmp.cfg" "${DOVE_USER_PREF_CFG}" > "${DOVE_OSX_CFG}" || error_fn
    echo

    # Update the version
    "${DOVE_SED}" -i "s|{DOVE_VERSION}|${DOVE_VERSION}|" "${DOVE_OSX_BOOTSTRAP}" || error_fn
    echo
    "${DOVE_SED}" -i "s|{DOVE_VERSION}|${DOVE_VERSION}|" "${DOVE_OSX_CFG}" || error_fn
    echo
    "${DOVE_SED}" -i "s|{DOVE_VERSION}|${DOVE_VERSION}|" "${DOVE_OSX_PREFS}" || error_fn
    echo
    "${DOVE_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${DOVE_OSX_BOOTSTRAP}" || error_fn
    echo
    "${DOVE_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${DOVE_OSX_CFG}" || error_fn
    echo
    "${DOVE_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${DOVE_OSX_PREFS}" || error_fn
    echo
fi

# OS X (INTEL)
if [ "${DOVE_OSX_INTEL}" == 1 ]; then
    echo_green_text 'Building Dove for OS X (Intel)...'
    mkdir -vp "${DOVE_OSX_INTEL_DIR}/defaults/pref" || error_fn
    echo

    # Copy license
    cp -vf "${DOVE_LICENSE}" "${DOVE_OSX_INTEL_DIR}/" || error_fn
    echo

    # Copy README
    cp -vf "${DOVE_README}" "${DOVE_OSX_INTEL_DIR}/" || error_fn
    echo

    # Copy Thunderbird's autoconfiguration files
    rm -vrf "${DOVE_OSX_INTEL_DIR}/assets/autoconfig/*" || error_fn
    echo
    mkdir -vp "${DOVE_OSX_INTEL_DIR}/assets/autoconfig/v1.1" || error_fn
    echo
    cp -vrf "${DOVE_AUTOCONFIG_OUTPUT}" "${DOVE_OSX_INTEL_DIR}/assets/" || error_fn
    echo

    # Remove lines containing [FLATPAK-LINUX-ONLY], [LINUX-ONLY], [NO-INTEL-OSX], [NO-OSX], [LINUX-NON-FLATPAK-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'FLATPAK-LINUX-ONLY|LINUX-ONLY|NO-INTEL-OSX|NO-OSX|NON-FLATPAK-LINUX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${DOVE_BOOTSTRAP}" > "${DOVE_OSX_INTEL_BOOTSTRAP}" || error_fn
    echo
    echo "Created ${DOVE_OSX_INTEL_BOOTSTRAP}"

    # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [LINUX-ONLY], [NO-INTEL-OSX], [NO-MAIL], [NO-OSX], [LINUX-NON-FLATPAK-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|LINUX-ONLY|NO-INTEL-OSX|NO-MAIL|NO-OSX|NON-FLATPAK-LINUX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_UNIFIED_PREFS}" > "${DOVE_TEMP}/osx-intel-temp1.js" || error_fn
    echo
    echo "Created ${DOVE_TEMP}/osx-intel-temp1.js"

    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|LINUX-ONLY|NO-INTEL-OSX|NO-MAIL|NO-OSX|NON-FLATPAK-LINUX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_EXTENDED_UNIFIED_PREFS}" > "${DOVE_TEMP}/osx-intel-temp2.js" || error_fn
    echo
    echo "Created ${DOVE_TEMP}/osx-intel-temp2.js"

    # Remove lines containing [FLATPAK-LINUX-ONLY], [LINUX-ONLY], [NO-INTEL-OSX], [NO-OSX], [LINUX-NON-FLATPAK-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'FLATPAK-LINUX-ONLY|LINUX-ONLY|NO-INTEL-OSX|NO-OSX|NON-FLATPAK-LINUX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${DOVE_UNIFIED_PREFS}" > "${DOVE_TEMP}/osx-intel-temp3.js" || error_fn
    echo
    echo "Created ${DOVE_TEMP}/osx-intel-temp3.js"

    cat "${DOVE_TEMP}/osx-intel-temp1.js" "${DOVE_TEMP}/osx-intel-temp2.js" "${DOVE_TEMP}/osx-intel-temp3.js" > "${DOVE_OSX_INTEL_PREFS}" || error_fn
    echo

    python3 "${DOVE_BUILD}/convert.py" "${DOVE_OSX_INTEL_PREFS}" "${DOVE_TEMP}/dove-osx-intel-tmp.cfg" || error_fn
    echo

    # Add "user" prefs
    cat "${DOVE_TEMP}/dove-osx-tmp.cfg" "${DOVE_USER_PREF_CFG}" > "${DOVE_OSX_INTEL_CFG}" || error_fn
    echo

    # Update the version
    "${DOVE_SED}" -i "s|{DOVE_VERSION}|${DOVE_VERSION}|" "${DOVE_OSX_INTEL_BOOTSTRAP}" || error_fn
    echo
    "${DOVE_SED}" -i "s|{DOVE_VERSION}|${DOVE_VERSION}|" "${DOVE_OSX_INTEL_CFG}" || error_fn
    echo
    "${DOVE_SED}" -i "s|{DOVE_VERSION}|${DOVE_VERSION}|" "${DOVE_OSX_INTEL_PREFS}" || error_fn
    echo
    "${DOVE_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${DOVE_OSX_INTEL_BOOTSTRAP}" || error_fn
    echo
    "${DOVE_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${DOVE_OSX_INTEL_CFG}" || error_fn
    echo
    "${DOVE_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${DOVE_OSX_INTEL_PREFS}" || error_fn
    echo
fi

# WINDOWS
if [ "${DOVE_WINDOWS}" == 1 ]; then
    echo_green_text 'Building Dove for Windows...'
    mkdir -vp "${DOVE_WINDOWS_DIR}/defaults/pref" || error_fn
    echo
    mkdir -vp "${DOVE_WINDOWS_DIR}/distribution" || error_fn
    echo

    # Copy license
    cp -vf "${DOVE_LICENSE}" "${DOVE_WINDOWS_DIR}/" || error_fn
    echo

    # Copy README
    cp -vf "${DOVE_README}" "${DOVE_WINDOWS_DIR}/" || error_fn
    echo

    # Copy Thunderbird's autoconfiguration files
    rm -vrf "${DOVE_WINDOWS_DIR}/assets/autoconfig/*" || error_fn
    echo
    mkdir -vp "${DOVE_WINDOWS_DIR}/assets/autoconfig/v1.1" || error_fn
    echo
    cp -vrf "${DOVE_AUTOCONFIG_OUTPUT}" "${DOVE_WINDOWS_DIR}/assets/" || error_fn
    echo

    # Remove lines containing [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-WINDOWS], [LINUX-NON-FLATPAK-ONLY], [OSX-ONLY], and [SILICON-OSX-ONLY]
    grep -vE 'FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-WINDOWS|NON-FLATPAK-LINUX-ONLY|OSX-ONLY|SILICON-OSX-ONLY' "${DOVE_BOOTSTRAP}" > "${DOVE_WINDOWS_BOOTSTRAP}" || error_fn
    echo
    echo "Created ${DOVE_WINDOWS_BOOTSTRAP}"

    # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-MAIL], [NO-WINDOWS], [LINUX-NON-FLATPAK-ONLY], [OSX-ONLY], and [SILICON-OSX-ONLY]
    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-MAIL|NO-WINDOWS|NON-FLATPAK-LINUX-ONLY|OSX-ONLY|SILICON-OSX-ONLY' "${PHOENIX_UNIFIED_PREFS}" > "${DOVE_TEMP}/windows-temp1.js" || error_fn
    echo
    echo "Created ${DOVE_TEMP}/windows-temp1.js"

    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-MAIL|NO-WINDOWS|NON-FLATPAK-LINUX-ONLY|OSX-ONLY|SILICON-OSX-ONLY' "${PHOENIX_EXTENDED_UNIFIED_PREFS}" > "${DOVE_TEMP}/windows-temp2.js" || error_fn
    echo
    echo "Created ${DOVE_TEMP}/windows-temp2.js"

    # Remove lines containing [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-WINDOWS], [LINUX-NON-FLATPAK-ONLY], [OSX-ONLY], and [SILICON-OSX-ONLY]
    grep -vE 'FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-WINDOWS|NON-FLATPAK-LINUX-ONLY|OSX-ONLY|SILICON-OSX-ONLY' "${DOVE_UNIFIED_PREFS}" > "${DOVE_TEMP}/windows-temp3.js" || error_fn
    echo
    echo "Created ${DOVE_TEMP}/windows-temp3.js"

    cat "${DOVE_TEMP}/windows-temp1.js" "${DOVE_TEMP}/windows-temp2.js" "${DOVE_TEMP}/windows-temp3.js" > "${DOVE_WINDOWS_PREFS}" || error_fn
    echo

    python3 "${DOVE_BUILD}/convert.py" "${DOVE_WINDOWS_PREFS}" "${DOVE_TEMP}/dove-windows-tmp.cfg" || error_fn
    echo

    # Add "user" prefs
    cat "${DOVE_TEMP}/dove-windows-tmp.cfg" "${DOVE_USER_PREF_CFG}" > "${DOVE_WINDOWS_CFG}" || error_fn
    echo

    # Update the version
    "${DOVE_SED}" -i "s|{DOVE_VERSION}|${DOVE_VERSION}|" "${DOVE_WINDOWS_BOOTSTRAP}" || error_fn
    echo
    "${DOVE_SED}" -i "s|{DOVE_VERSION}|${DOVE_VERSION}|" "${DOVE_WINDOWS_CFG}" || error_fn
    echo
    "${DOVE_SED}" -i "s|{DOVE_VERSION}|${DOVE_VERSION}|" "${DOVE_WINDOWS_PREFS}" || error_fn
    echo
    "${DOVE_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${DOVE_WINDOWS_BOOTSTRAP}" || error_fn
    echo
    "${DOVE_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${DOVE_WINDOWS_CFG}" || error_fn
    echo
    "${DOVE_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${DOVE_WINDOWS_PREFS}" || error_fn
    echo
fi

# POLICIES
jq -s '.[0] * .[1]' "${PHOENIX_UNIFIED_POLICIES}" "${PHOENIX_BLOCKLIST_POLICIES}" > "${DOVE_TEMP}/policies/temp1.json" || error_fn
echo
jq -s '.[0] * .[1]' "${DOVE_TEMP}/policies/temp1.json" "${PHOENIX_COOKIES_POLICIES}" > "${DOVE_TEMP}/policies/temp2.json" || error_fn
echo
jq -s '.[0] * .[1]' "${DOVE_TEMP}/policies/temp2.json" "${DOVE_UNIFIED_POLICIES}" > "${DOVE_POLICIES}" || error_fn
echo

# (This is used by both Linux and Flatpak)
if [ "${DOVE_LINUX}" == 1 ] || [ "${DOVE_LINUX_FLATPAK}" == 1 ]; then
    jq -s '.[0] * .[1]' "${DOVE_POLICIES}" "${PHOENIX_UNIFIED_LINUX_POLICIES}" > "${DOVE_TEMP}/policies/temp3.json" || error_fn
    echo
fi

if [ "${DOVE_LINUX}" == 1 ]; then
    echo_green_text 'Building Dove policies for Linux...'

    jq -s '.[0] * .[1]' "${DOVE_TEMP}/policies/temp3.json" "${PHOENIX_UNIFIED_LINUX_NONFLATPAK_POLICIES}" > "${DOVE_TEMP}/policies/temp4.json" || error_fn
    echo
    jq -s '.[0] * .[1]' "${DOVE_TEMP}/policies/temp4.json" "${DOVE_UNIFIED_LINUX_NONFLATPAK_POLICIES}" > "${DOVE_LINUX_POLICIES}" || error_fn
    echo
fi

if [ "${DOVE_LINUX_FLATPAK}" == 1 ]; then
    echo_green_text 'Building Dove policies for Linux (Flatpak)...'

    jq -s '.[0] * .[1]' "${DOVE_TEMP}/policies/temp3.json" "${PHOENIX_UNIFIED_LINUX_FLATPAK_POLICIES}" > "${DOVE_TEMP}/policies/temp5.json" || error_fn
    echo
    jq -s '.[0] * .[1]' "${DOVE_TEMP}/policies/temp5.json" "${DOVE_UNIFIED_LINUX_FLATPAK_POLICIES}" > "${DOVE_LINUX_FLATPAK_POLICIES}" || error_fn
    echo
fi

# (This is used by both OS X and OS X Intel)
if [ "${DOVE_OSX}" == 1 ] || [ "${DOVE_OSX_INTEL}" == 1 ]; then
    jq -s '.[0] * .[1]' "${DOVE_POLICIES}" "${PHOENIX_UNIFIED_OSX_POLICIES}" > "${DOVE_TEMP}/policies/temp6.json" || error_fn
    echo
fi

if [ "${DOVE_OSX}" == 1 ]; then
    echo_green_text 'Building Dove policies for OS X...'

    jq -s '.[0] * .[1]' "${DOVE_TEMP}/policies/temp6.json" "${PHOENIX_UNIFIED_OSX_SILICON_POLICIES}" > "${DOVE_TEMP}/policies/temp7.json" || error_fn
    echo
    jq -s '.[0] * .[1]' "${DOVE_TEMP}/policies/temp7.json" "${DOVE_UNIFIED_OSX_SILICON_POLICIES}" > "${DOVE_OSX_POLICIES_JSON}" || error_fn
    echo
    python3 "${DOVE_BUILD}/convert_json_to_plist.py" "${DOVE_OSX_POLICIES_JSON}" "${DOVE_OSX_POLICIES_PLIST}" || error_fn
    echo
fi

if [ "${DOVE_OSX_INTEL}" == 1 ]; then
    echo_green_text 'Building Dove policies for OS X (Intel)..'

    jq -s '.[0] * .[1]' "${DOVE_TEMP}/policies/temp6.json" "${PHOENIX_UNIFIED_OSX_INTEL_POLICIES}" > "${DOVE_TEMP}/policies/temp8.json" || error_fn
    echo
    jq -s '.[0] * .[1]' "${DOVE_TEMP}/policies/temp8.json" "${DOVE_UNIFIED_OSX_INTEL_POLICIES}" > "${DOVE_OSX_INTEL_POLICIES_JSON}" || error_fn
    echo
    python3 "${DOVE_BUILD}/convert_json_to_plist.py" "${DOVE_OSX_INTEL_POLICIES_JSON}" "${DOVE_OSX_INTEL_POLICIES_PLIST}" || error_fn
    echo
fi

if [ "${DOVE_WINDOWS}" == 1 ]; then
    echo_green_text 'Building Dove policies for Windows...'

    jq -s '.[0] * .[1]' "${DOVE_POLICIES}" "${PHOENIX_UNIFIED_WINDOWS_POLICIES}" > "${DOVE_TEMP}/policies/temp9.json" || error_fn
    echo
    jq -s '.[0] * .[1]' "${DOVE_TEMP}/policies/temp9.json" "${DOVE_UNIFIED_WINDOWS_POLICIES}" > "${DOVE_WINDOWS_POLICIES}" || error_fn
    echo
fi

rm -rf "${DOVE_TEMP}/" || error_fn
echo
