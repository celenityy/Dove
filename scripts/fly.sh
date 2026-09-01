#!/bin/bash

set -euo pipefail

# Welcome to the Dove Unified build script!
# This script should be ran AFTER building Phoenix, from the ROOT of the Dove repo

# Set-up our environment
source $(dirname $0)/env.sh || exit 1

# Include utilities
source "${DOVE_UTILS}" || exit 1

# Include file utilities
source "${DOVE_FILE_UTILS}" || exit 1

# Set verbosity
set_verbosity

if [[ -z "${DOVE_FROM_BUILD+x}" ]]; then
  echo_red_text "ERROR: Do not call 'fly.sh' directly! Instead, use 'build.sh'." >&1
  exit 1
fi

# Ensure we have mkdir
verify_exec "${DOVE_MKDIR}" 'DOVE_MKDIR' || exit 1

# Ensure we have rm
verify_exec "${DOVE_RM}" 'DOVE_RM' || exit 1

readonly target="$1"

# Set-up target parameters
DOVE_LINUX=0
DOVE_LINUX_FLATPAK=0
DOVE_OSX=0
DOVE_OSX_INTEL=0
DOVE_WINDOWS=0

if [[ "${target}" == 'linux' ]]; then
  # Linux (non-Flatpak)
  DOVE_LINUX=1
elif [[ "${target}" == 'linux-flatpak' ]]; then
  # Linux (Flatpak)
  DOVE_LINUX_FLATPAK=1
elif [[ "${target}" == 'osx' ]]; then
  # OS X (Silicon)
  DOVE_OSX=1
elif [[ "${target}" == 'osx-intel' ]]; then
  # OS X (Intel)
  DOVE_OSX_INTEL=1
elif [[ "${target}" == 'windows' ]]; then
  # Windows
  DOVE_WINDOWS=1
elif [[ "${target}" == 'all' ]]; then
  # If no argument is specified (or argument is set to "all"), build everything
  DOVE_LINUX=1
  DOVE_LINUX_FLATPAK=1
  DOVE_OSX=1
  DOVE_OSX_INTEL=1
  DOVE_WINDOWS=1
else
  echo_red_text "ERROR: Invalid target: ${target}\n You must enter one of the following:"
  echo 'All:                  all (Default)'
  echo 'Linux (non-Flatpak):  linux'
  echo 'Linux (Flatpak):      linux-flatpak'
  echo 'OS X (Silicon):       osx'
  echo 'OS X (Intel):         osx-intel'
  echo 'Windows:              windows'
  exit 1
fi
readonly DOVE_LINUX
readonly DOVE_LINUX_FLATPAK
readonly DOVE_OSX
readonly DOVE_OSX_INTEL
readonly DOVE_WINDOWS

# Include version info
source "${DOVE_VERSIONS}" || exit 1

# Check if a file or directory already exists
## If the file or directory already exists, prompt the user to remove it
## If the user chooses not to remove it, we exit
## If the file or directory doesn't already exist, we just do nothing
function check_file_or_dir_exists() {
  function print_usage() {
    echo "Usage: check_file_or_dir_exists '/path/to/file_or_dir'"
  }

  if [[ -z "${1+x}" ]]; then
    echo_red_text 'ERROR: Please specify the path to a file or directory to check!'
    print_usage
    exit 1
  fi

  # Ensure we have rm
  verify_exec "${DOVE_RM}" 'DOVE_RM' || exit 1

  local -r path="$1"

  if [[ -d "${path}" ]] || [[ -f "${path}" ]]; then
    echo_red_text "Path already exists: '${path}'!"
    echo_red_text 'Continuing WILL remove this file/directory.'
    read -p "Are you sure you want to proceed? [y/N] " -n 1 -r
    echo
    if [[ "${REPLY}" =~ ^[Yy]$ ]]; then
      echo_red_text "Removing path: '${path}'..."
      if [[ -d "${path}" ]]; then
        "${DOVE_RM}" -rf "${path}"
      elif [[ -f "${path}" ]]; then
        "${DOVE_RM}" -f "${path}" "${path}-sha512sum.txt"
      fi
    else
      exit 1
    fi
  fi
}

# Prepare to build Dove
function prep_dove() {
  # Ensure we have cp
  verify_exec "${DOVE_CP}" 'DOVE_CP' || exit 1

  # Ensure we have GNU sed
  verify_exec "${DOVE_SED}" 'DOVE_SED' || exit 1

  "${DOVE_CP}" -f "${DOVE_ROOT}/dove-unified.cfg" "${DOVE_TEMP}/dove-parsed.cfg"

  # Update the versions
  "${DOVE_SED}" -i "s|{DOVE_VERSION}|${DOVE_VERSION}|g" "${DOVE_TEMP}/dove-parsed.cfg"
  "${DOVE_SED}" -i "s|{DOVE_PHOENIX_VERSION}|${DOVE_PHOENIX_VERSION}|g" "${DOVE_TEMP}/dove-parsed.cfg"
}

# Build Thunderbird's autoconfiguration database
function build_autoconfig() {
  # Ensure we have cp
  verify_exec "${DOVE_CP}" 'DOVE_CP' || exit 1

  # Ensure we have mkdir
  verify_exec "${DOVE_MKDIR}" 'DOVE_MKDIR' || exit 1

  echo_red_text 'Building the Thunderbird autoconfiguration database...'
  "${DOVE_MKDIR}" -p "${DOVE_BUILD}/autoconfig/v1.1"

  pushd "${DOVE_BUILD}/autoconfig"
  "${DOVE_CP}" "${DOVE_AUTOCONFIG}/LICENSE" "${DOVE_BUILD}/autoconfig/LICENSE.txt"
  "${DOVE_PYTHON}" "${DOVE_AUTOCONFIG}/tools/convert.py" -d "${DOVE_BUILD}/autoconfig/v1.1" -a ${DOVE_AUTOCONFIG}/ispdb/*.xml
  popd

  echo_green_text 'SUCCESS: Built the Thunderbird autoconfiguration database'
}

# Build Phoenix
function build_phoenix() {
  echo_red_text 'Building Phoenix...'

  pushd "${DOVE_PHOENIX}"
  /bin/bash -x "${DOVE_PHOENIX}/scripts/build.sh" "${target}"
  popd

  echo_green_text 'SUCCESS: Built Phoenix!'
}

# Build Dove
function build_dove() {
  function print_usage() {
    echo "Usage: build_dove 'platform'"
  }

  if [[ -z "${1+x}" ]]; then
    echo_red_text 'ERROR: Please specify the platform you would like to build Dove for!'
    print_usage
    exit 1
  fi

  # Ensure we have cp
  verify_exec "${DOVE_CP}" 'DOVE_CP' || exit 1

  # Ensure we have mkdir
  verify_exec "${DOVE_MKDIR}" 'DOVE_MKDIR' || exit 1

  local -r dove_platform="$1"
  local -r dove_output_dir="${DOVE_OUTPUTS}/${dove_platform}"

  if [[ "${dove_platform}" == 'windows' ]]; then
    local -r dove_output_archive="${DOVE_OUTPUTS}/dove-${DOVE_VERSION}-${dove_platform}.zip"
    local -r dove_output_archive_latest="${DOVE_OUTPUTS}/dove-latest-${dove_platform}.zip"
  else
    local -r dove_output_archive="${DOVE_OUTPUTS}/dove-${DOVE_VERSION}-${dove_platform}.tar.xz"
    local -r dove_output_archive_latest="${DOVE_OUTPUTS}/dove-latest-${dove_platform}.tar.xz"
  fi

  # Ensure existing outputs don't already exist
  check_file_or_dir_exists "${dove_output_dir}"
  check_file_or_dir_exists "${dove_output_archive}"
  check_file_or_dir_exists "${dove_output_archive_latest}"

  # Create our output directory
  "${DOVE_MKDIR}" -p "${dove_output_dir}/assets/autoconfig/v1.1"

  # Copy our bootstrap dove.js
  "${DOVE_MKDIR}" -p "${dove_output_dir}/defaults/pref"
  "${DOVE_CP}" "${DOVE_ROOT}/dove.js" "${dove_output_dir}/defaults/pref/dove.js"

  # Copy our parsed dove.cfg
  if [[ "${dove_platform}" == 'osx' ]]; then
    # To ensure installs continue working as expected, this must be placed in (and copied from)
    ## the `macos` directory
    local -r dove_cfg_output_dir="${dove_output_dir}/macos"
    local -r phoenix_cfg_input_path="${dove_platform}/macos"
  else
    local -r dove_cfg_output_dir="${dove_output_dir}"
    local -r phoenix_cfg_input_path="${dove_platform}"
  fi
  "${DOVE_MKDIR}" -p "${dove_cfg_output_dir}"
  "${DOVE_CP}" "${DOVE_PHOENIX}/outputs/${phoenix_cfg_input_path}/phoenix.cfg" "${dove_cfg_output_dir}/dove.cfg"

  # If necessary, copy our static dove.js
  if [[ "${DOVE_STATIC_JS}" == 1 ]]; then
    "${DOVE_CP}" "${DOVE_PHOENIX}/outputs/${dove_platform}/phoenix-static-${DOVE_PHOENIX_VERSION}-${dove_platform}.js" "${dove_output_dir}/dove-static-${DOVE_VERSION}-${dove_platform}.js"
  fi

  # Copy icon
  "${DOVE_CP}" "${DOVE_ROOT}/assets/dove.png" "${dove_output_dir}/assets/dove.png"

  # Copy license
  "${DOVE_CP}" "${DOVE_ROOT}/COPYING.txt" "${dove_output_dir}/COPYING.txt"

  # Copy README
  "${DOVE_CP}" "${DOVE_ROOT}/README.md" "${dove_output_dir}/README.md"

  # Copy generic platform files
  if [[ "${dove_platform}" == 'osx' ]] || [[ "${dove_platform}" == 'osx-intel' ]]; then
    "${DOVE_CP}" -r "${DOVE_ROOT}/osx/shared/Library" "${dove_output_dir}/"
  fi

  # Copy platform-specific files
  if [[ "${dove_platform}" == 'linux' ]]; then
    "${DOVE_CP}" -r "${DOVE_ROOT}/linux/etc" "${dove_output_dir}/"
  elif [[ "${dove_platform}" == 'osx' ]]; then
    "${DOVE_CP}" -r "${DOVE_ROOT}/osx/osx-silicon/Library/" "${dove_output_dir}/Library/"
  elif [[ "${dove_platform}" == 'osx-intel' ]]; then
    "${DOVE_CP}" -r "${DOVE_ROOT}/osx/osx-intel/Library/" "${dove_output_dir}/Library/"
  fi

  # Copy enterprise policies
  if [[ "${dove_platform}" == 'linux' ]] || [[ "${dove_platform}" == 'linux-flatpak' ]]; then
    "${DOVE_CP}" -r "${DOVE_PHOENIX}/outputs/${dove_platform}/policies" "${dove_output_dir}/"
  elif [[ "${dove_platform}" == 'osx' ]]; then
    "${DOVE_CP}" "${DOVE_PHOENIX}/outputs/${dove_platform}/macos/org.mozilla.firefox.plist" "${dove_output_dir}/macos/org.mozilla.thunderbird.plist"
  elif [[ "${dove_platform}" == 'osx-intel' ]]; then
    "${DOVE_CP}" "${DOVE_PHOENIX}/outputs/${dove_platform}/org.mozilla.firefox.plist" "${dove_output_dir}/org.mozilla.thunderbird.plist"
  elif [[ "${dove_platform}" == 'windows' ]]; then
    "${DOVE_CP}" -r "${DOVE_PHOENIX}/outputs/${dove_platform}/distribution" "${dove_output_dir}/"
  fi

  # For OS X, also copy the standard policies.json
  if [[ "${dove_platform}" == 'osx' ]] || [[ "${dove_platform}" == 'osx-intel' ]]; then
    "${DOVE_MKDIR}" -p "${dove_output_dir}/unused"
    "${DOVE_CP}" "${DOVE_PHOENIX}/outputs/${dove_platform}/unused/policies.json" "${dove_output_dir}/unused/policies.json"
  fi

  # Copy Thunderbird's autoconfiguration files
  "${DOVE_CP}" -vrf "${DOVE_BUILD}/autoconfig" "${dove_output_dir}/assets/"

  # Finally, create our platform-specific archives
  if [[ "${DOVE_PRODUCE_ARCHIVES}" == 1 ]]; then
    create_archive "${dove_output_dir}" "${dove_output_archive}"
  fi
}

# Create our temporary file directory
"${DOVE_MKDIR}" -p "${DOVE_TEMP}"

# Set-up Python environment
if [[ "${DOVE_NIX}" == 1 ]]; then
  readonly dove_py=0
else
  readonly dove_py=1
fi
if [[ "${dove_py}" == 1 ]]; then
  # Ensure Python is properly set-up
  verify_exec "${DOVE_PYTHON}" 'DOVE_PYTHON' || exit 1

  # The Python environment *should* already be created by `get_sources.sh`, but it may not be (ex. if the user provides their own Python and/or
  # doesn't use `get_sources.sh`), so if it doesn't exist then create it
  if [[ ! -f "${DOVE_PYENV}" ]]; then
    # Preferably, we want to use uv, but if uv is unavailable, we can try falling back to Python's built-in venv module
    DOVE_UV_AVAILABLE=1
    verify_exec "${DOVE_UV}" 'DOVE_UV' || DOVE_UV_AVAILABLE=0
    if [[ "${DOVE_UV_AVAILABLE}" == 1 ]]; then
      echo_red_text 'Creating Python environment with uv...'
      "${DOVE_UV}" venv "${DOVE_PYENV_DIR}"
    else
      echo_red_text 'Creating Python environment with Python...'
      "${DOVE_PYTHON}" -m venv "${DOVE_PYENV_DIR}"
    fi
    echo_green_text "Created Python environment: ${DOVE_PYENV}"
  fi
  echo_red_text 'Sourcing Python environment...'
  source "${DOVE_PYENV}"
  echo_green_text "Sourced Python environment: ${DOVE_PYENV}"
fi

# First, prepare our build environment
prep_dove

# Build Thunderbird's autoconfiguration Database
build_autoconfig

# Build Phoenix
build_phoenix

# Begin the build...
echo_red_text "Building Dove ${DOVE_VERSION}..."

# Build Dove for Linux (non-Flatpak)
if [[ "${DOVE_LINUX}" == 1 ]]; then
  build_dove 'linux'
fi

# Build Dove for Linux (Flatpak)
if [[ "${DOVE_LINUX_FLATPAK}" == 1 ]]; then
  build_dove 'linux-flatpak'
fi

# Build Dove for OS X (Silicon)
if [[ "${DOVE_OSX}" == 1 ]]; then
  build_dove 'osx'
fi

# Build Dove for OS X (Intel)
if [[ "${DOVE_OSX_INTEL}" == 1 ]]; then
  build_dove 'osx-intel'
fi

# Build Dove for Windows
if [[ "${DOVE_WINDOWS}" == 1 ]]; then
  build_dove 'windows'
fi

echo_green_text "SUCCESS: Built Dove ${DOVE_VERSION}"

# Clean-up temporary files
"${DOVE_RM}" -rf "${DOVE_TEMP}"
