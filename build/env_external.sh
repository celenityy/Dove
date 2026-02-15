# Dove external environment variables

## This is used for converting Dove-specific environment variables to ones used in external projects.

## CAUTION: Do NOT source this directly!
## Source 'env.sh' instead.

## CAUTION: Do NOT try to configure any of these environment variables directly!
## Use the Dove equivalent variables (at `env_common.sh`) instead.

# Phoenix
export PHOENIX_ANDROID=0
export PHOENIX_EXTRA_EXTENDED_OUTPUT_FILENAME='dove'
export PHOENIX_EXTRA_POLICIES=1
export PHOENIX_EXTRA_POLICIES_LINUX=1
export PHOENIX_EXTRA_POLICIES_LINUX_FLATPAK=1
export PHOENIX_EXTRA_POLICIES_LINUX_NONFLATPAK=1
export PHOENIX_EXTRA_POLICIES_OSX=1
export PHOENIX_EXTRA_POLICIES_OSX_INTEL=1
export PHOENIX_EXTRA_POLICIES_OSX_SILICON=1
export PHOENIX_EXTRA_POLICIES_WINDOWS=1
export PHOENIX_EXTRA_PREFS_JS=1
export PHOENIX_MAIL=1

export PHOENIX_EXTRA_PREFS_JS_FILE="${DOVE_TEMP}/dove-unified-parsed.js"
export PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR="${DOVE_TEMP}/prefs"

export PHOENIX_EXTRA_POLICIES_FILE="${DOVE_BUILD}/policies/dove-unified.json"
export PHOENIX_EXTRA_POLICIES_FILE_LINUX="${DOVE_BUILD}/policies/dove-linux.json"
export PHOENIX_EXTRA_POLICIES_FILE_LINUX_NONFLATPAK="${DOVE_BUILD}/policies/dove-linux-nonflatpak.json"
export PHOENIX_EXTRA_POLICIES_FILE_LINUX_FLATPAK="${DOVE_BUILD}/policies/dove-linux-flatpak.json"
export PHOENIX_EXTRA_POLICIES_FILE_OSX="${DOVE_BUILD}/policies/dove-osx.json"
export PHOENIX_EXTRA_POLICIES_FILE_OSX_INTEL="${DOVE_BUILD}/policies/dove-osx-intel.json"
export PHOENIX_EXTRA_POLICIES_FILE_OSX_SILICON="${DOVE_BUILD}/policies/dove-osx-silicon.json"
export PHOENIX_EXTRA_POLICIES_FILE_WINDOWS="${DOVE_BUILD}/policies/dove-windows.json"

export PHOENIX_EXTRA_POLICIES_OUTPUT_DIR_LINUX_FLATPAK="${DOVE_ROOT}/linux-flatpak/policies"
export PHOENIX_EXTRA_POLICIES_OUTPUT_DIR_LINUX_NONFLATPAK="${DOVE_ROOT}/linux/policies"
export PHOENIX_EXTRA_POLICIES_OUTPUT_DIR_OSX_INTEL="${DOVE_ROOT}/macos-intel"
export PHOENIX_EXTRA_POLICIES_OUTPUT_DIR_OSX_SILICON="${DOVE_ROOT}/macos/macos"
export PHOENIX_EXTRA_POLICIES_OUTPUT_DIR_WINDOWS="${DOVE_ROOT}/windows/distribution"

export PHOENIX_LINUX_ONLY="${DOVE_LINUX_ONLY}"
export PHOENIX_LINUX_FLATPAK_ONLY="${DOVE_LINUX_FLATPAK_ONLY}"
export PHOENIX_OSX_ONLY="${DOVE_OSX_ONLY}"
export PHOENIX_OSX_INTEL_ONLY="${DOVE_OSX_INTEL_ONLY}"
export PHOENIX_WINDOWS_ONLY="${DOVE_WINDOWS_ONLY}"

export PHOENIX_LINUX="${DOVE_LINUX}"
export PHOENIX_LINUX_FLATPAK="${DOVE_LINUX_FLATPAK}"
export PHOENIX_OSX="${DOVE_OSX}"
export PHOENIX_OSX_INTEL="${DOVE_OSX_INTEL}"
export PHOENIX_WINDOWS="${DOVE_WINDOWS}"
