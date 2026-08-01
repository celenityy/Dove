#!/bin/bash

set -euo pipefail

# Set-up our environment
if [[ -z "${DOVE_CI+x}" ]]; then
  export DOVE_CI=1
fi
source $(dirname $0)/env.sh

# Include utilities
source "${DOVE_UTILS}"

# Include version info
source "${DOVE_VERSIONS}"

if [[ -z "${DOVE_FROM_AR_DOWN+x}" ]]; then
  echo_red_text 'ERROR: Do not call ci-download-artifacts-dove.sh directly. Instead, use ci-download-artifacts.sh.' >&1
  exit 1
fi

if [[ -z "${DOVE_CI_ID+x}" ]]; then
  echo_red_text 'ERROR: Missing CI ID! Please set DOVE_CI_ID.'
  exit 1
fi

# Set verbosity
if [[ "${DOVE_VERBOSE}" == 1 ]]; then
  set -x
else
  set +x
fi

readonly down_artifact="$1"

# Set-up target parameters
DOVE_AR_DOWN_LINUX_ARCHIVE=0
DOVE_AR_DOWN_LINUX_FLATPAK_ARCHIVE=0
DOVE_AR_DOWN_OSX_ARCHIVE=0
DOVE_AR_DOWN_OSX_INTEL_ARCHIVE=0
DOVE_AR_DOWN_WINDOWS_ARCHIVE=0

if [[ "${down_artifact}" == 'linux-archive' ]]; then
  # dove-{DOVE_VERSION}-linux.tar.xz
  DOVE_AR_DOWN_LINUX_ARCHIVE=1
elif [[ "${down_artifact}" == 'linux-flatpak-archive' ]]; then
  # dove-{DOVE_VERSION}-linux-flatpak.tar.xz
  DOVE_AR_DOWN_LINUX_FLATPAK_ARCHIVE=1
elif [[ "${down_artifact}" == 'osx-archive' ]]; then
  # dove-{DOVE_VERSION}-osx.tar.xz
  DOVE_AR_DOWN_OSX_ARCHIVE=1
elif [[ "${down_artifact}" == 'osx-intel-archive' ]]; then
  # dove-{DOVE_VERSION}-osx-intel.tar.xz
  DOVE_AR_DOWN_OSX_INTEL_ARCHIVE=1
elif [[ "${down_artifact}" == 'windows-archive' ]]; then
  # dove-{DOVE_VERSION}-windows.zip
  DOVE_AR_DOWN_WINDOWS_ARCHIVE=1
elif [[ "${down_artifact}" == 'all' ]]; then
  # If no argument is specified (or argument is set to "all"), just download everything
  DOVE_AR_DOWN_LINUX_ARCHIVE=1
  DOVE_AR_DOWN_LINUX_FLATPAK_ARCHIVE=1
  DOVE_AR_DOWN_OSX_ARCHIVE=1
  DOVE_AR_DOWN_OSX_INTEL_ARCHIVE=1
  DOVE_AR_DOWN_WINDOWS_ARCHIVE=1
else
  echo_red_text "ERROR: Invalid target: ${down_artifact}\n You must enter one of the following:"
  echo 'All:                      all (Default)'
  echo 'Linux archive:            linux-archive'
  echo 'Linux (Flatpak) archive:  linux-flatpak-archive'
  echo 'OS X archive:             osx-archive'
  echo 'OS X (Intel) archive:     osx-intel-archive'
  echo 'Windows archive:          windows-archive'
  exit 1
fi
readonly DOVE_AR_DOWN_LINUX_ARCHIVE
readonly DOVE_AR_DOWN_LINUX_FLATPAK_ARCHIVE
readonly DOVE_AR_DOWN_OSX_ARCHIVE
readonly DOVE_AR_DOWN_OSX_INTEL_ARCHIVE
readonly DOVE_AR_DOWN_WINDOWS_ARCHIVE

# Constants

# Base artifacts URL
readonly DOVE_CEL_ARTIFACTS_URL='https://artifacts.celenity.dev/dove'

# Function to download and verify the SHA512sum of an artifact
function download_artifact() {
  local readonly pipeline_id="$1"
  local readonly target="$2"
  local readonly output_dir="$3"

  if [[ "${target}" == 'windows' ]]; then
    local readonly target_archive_ext='zip'
  else
    local readonly target_archive_ext='tar.xz'
  fi

  local readonly target_file="dove-${DOVE_VERSION}-${target}.${target_archive_ext}"

  local readonly target_expected_sha512sum="${target_file}-sha512sum.txt"
  local readonly target_expected_sha512sum_url="${DOVE_CEL_ARTIFACTS_URL}/${pipeline_id}/${target_expected_sha512sum}"
  local readonly target_file_url="${DOVE_CEL_ARTIFACTS_URL}/${pipeline_id}/${target_file}"
  local readonly output_file="${output_dir}/${target_file}"
  local readonly output_expected_sha512sum="${output_dir}/${target_expected_sha512sum}"

  # Download the artifact
  "${DOVE_MKDIR}" -p "${output_dir}"
  echo_red_text "Downloading ${target_file} from ${target_file_url}..."
  "${DOVE_CURL}" ${DOVE_CURL_FLAGS} --location "${target_file_url}" --output "${output_file}"
  echo_green_text "SUCCESS: Downloaded ${target_file}"

  # Check the SHA512sum
  echo_red_text "Validating SHA512sum for ${target_file}.."
  "${DOVE_CURL}" ${DOVE_CURL_FLAGS} --location "${target_expected_sha512sum_url}" --output "${output_expected_sha512sum}"
  local readonly expected_sha512sum=$("${DOVE_CAT}" "${output_expected_sha512sum}" | "${DOVE_XARGS}")
  local readonly local_sha512sum=$("${DOVE_SHA512SUM}" "${output_file}" | "${DOVE_AWK}" '{print $1}')
  if [[ "${local_sha512sum}" != "${expected_sha512sum}" ]]; then
    echo_red_text 'ERROR: Checksum validation failed.'
    echo "Expected SHA512sum: ${expected_sha512sum}"
    echo "Actual SHA512sum:   ${local_sha512sum}"

    # If checksum validation fails, also just clean-up the files
    "${DOVE_RM}" -f "${output_file}"
    "${DOVE_RM}" -f "${output_expected_sha512sum}"
    exit 1
  fi
  echo_green_text "SUCCESS: Checksum validated for ${target_file}"
  echo "SHA512sum: ${local_sha512sum}"
}

# dove-{DOVE_VERSION}-linux.tar.xz
if [[ "${DOVE_AR_DOWN_LINUX_ARCHIVE}" == 1 ]]; then
  download_artifact "${DOVE_CI_ID}" 'linux' "${DOVE_ARTIFACTS}"
fi

# dove-{DOVE_VERSION}-linux-flatpak.tar.xz
if [[ "${DOVE_AR_DOWN_LINUX_FLATPAK_ARCHIVE}" == 1 ]]; then
  download_artifact "${DOVE_CI_ID}" 'linux-flatpak' "${DOVE_ARTIFACTS}"
fi

# dove-{DOVE_VERSION}-osx.tar.xz
if [[ "${DOVE_AR_DOWN_OSX_ARCHIVE}" == 1 ]]; then
  download_artifact "${DOVE_CI_ID}" 'osx' "${DOVE_ARTIFACTS}"
fi

# dove-{DOVE_VERSION}-osx-intel.tar.xz
if [[ "${DOVE_AR_DOWN_OSX_INTEL_ARCHIVE}" == 1 ]]; then
  download_artifact "${DOVE_CI_ID}" 'osx-intel' "${DOVE_ARTIFACTS}"
fi

# dove-{DOVE_VERSION}-windows.zip
if [[ "${DOVE_AR_DOWN_WINDOWS_ARCHIVE}" == 1 ]]; then
  download_artifact "${DOVE_CI_ID}" 'windows' "${DOVE_ARTIFACTS}"
fi
