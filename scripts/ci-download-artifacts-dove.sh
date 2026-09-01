#!/bin/bash

set -euo pipefail

# Set-up our environment
source $(dirname $0)/env.sh || exit 1

# Include utilities
source "${DOVE_UTILS}" || exit 1

# Set verbosity
set_verbosity

# Include download utilities
source "${DOVE_DOWNLOAD_UTILS}" || exit 1

# Include version info
source "${DOVE_VERSIONS}" || exit 1

if [[ -z "${DOVE_FROM_AR_DOWN+x}" ]]; then
  echo_red_text "ERROR: Do not call 'ci-download-artifacts-dove.sh' directly. Instead, use 'ci-download-artifacts.sh'." >&1
  exit 1
fi

if [[ "${DOVE_CI}" != 1 ]]; then
  echo_red_text "ERROR: '$0' should only be called from CI!"
  exit 1
fi

if [[ -z "${DOVE_CI_ID+x}" ]] || [[ "${DOVE_CI_ID}" == "" ]]; then
  echo_red_text "ERROR: Missing CI ID! Please set 'DOVE_CI_ID'."
  exit 1
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
  function print_usage() {
    echo "Usage: download_artifact 'pipeline_id' 'artifact_name' 'path/to/download/artifact/to'"
  }

  if [[ -z "${1+x}" ]]; then
    echo_red_text 'ERROR: Please provide the pipeline ID to download the artifact from!'
    print_usage
    exit 1
  fi

  if [[ -z "${2+x}" ]]; then
    echo_red_text 'ERROR: Please provide the name of the artifact to download!'
    print_usage
    exit 1
  fi

  if [[ -z "${3+x}" ]]; then
    echo_red_text 'ERROR: Please provide the path to download the artifact to!'
    print_usage
    exit 1
  fi

  # Ensure we have cat
  verify_exec "${DOVE_CAT}" 'DOVE_CAT' || exit 1

  # Ensure we have GNU awk
  verify_exec "${DOVE_AWK}" 'DOVE_AWK' || exit 1

  # Ensure we have rm
  verify_exec "${DOVE_RM}" 'DOVE_RM' || exit 1

  # Ensure we have shasum
  verify_exec "${DOVE_SHASUM}" 'DOVE_SHASUM' || exit 1

  # Ensure we have xargs
  verify_exec "${DOVE_XARGS}" 'DOVE_XARGS' || exit 1

  # Ensure we have `DOVE_VERSION`
  if [[ -z "${DOVE_VERSION+x}" ]] || [[ "${DOVE_VERSION}" == "" ]]; then
    echo_red_text "ERROR: 'DOVE_VERSION' is missing!"
    exit 1
  fi

  # Ensure we have `DOVE_CEL_ARTIFACTS_URL`
  if [[ -z "${DOVE_CEL_ARTIFACTS_URL+x}" ]] || [[ "${DOVE_CEL_ARTIFACTS_URL}" == "" ]]; then
    echo_red_text "ERROR: 'DOVE_CEL_ARTIFACTS_URL' is missing!"
    exit 1
  fi

  local -r pipeline_id="$1"
  local -r target="$2"
  local -r output_dir="$3"

  if [[ "${target}" == 'windows' ]]; then
    local -r target_archive_ext='zip'
  else
    local -r target_archive_ext='tar.xz'
  fi

  local -r target_file="dove-${DOVE_VERSION}-${target}.${target_archive_ext}"

  local -r target_expected_sha512sum="${target_file}-sha512sum.txt"
  local -r target_expected_sha512sum_url="${DOVE_CEL_ARTIFACTS_URL}/${pipeline_id}/${target_expected_sha512sum}"
  local -r target_file_url="${DOVE_CEL_ARTIFACTS_URL}/${pipeline_id}/${target_file}"
  local -r output_file="${output_dir}/${target_file}"
  local -r output_expected_sha512sum="${output_dir}/${target_expected_sha512sum}"

  # Download the artifact
  download "${target_file_url}" "${output_file}"

  # Check the SHA512sum
  echo_red_text "Validating SHA512sum for file: '${target_file}'..."
  download "${target_expected_sha512sum_url}" "${output_expected_sha512sum}"
  local -r expected_sha512sum=$("${DOVE_CAT}" "${output_expected_sha512sum}" | "${DOVE_XARGS}")
  local -r local_sha512sum=$("${DOVE_SHASUM}" -a 512 "${output_file}" | "${DOVE_AWK}" '{print $1}')
  if [[ "${local_sha512sum}" != "${expected_sha512sum}" ]]; then
    echo_red_text "ERROR: Checksum validation for file failed: '${target_file}'!"
    echo "Expected SHA512sum: '${expected_sha512sum}'"
    echo "Actual SHA512sum:   '${local_sha512sum}'"

    # If checksum validation fails, also just clean-up the files
    "${DOVE_RM}" -f "${output_file}"
    "${DOVE_RM}" -f "${output_expected_sha512sum}"
    exit 1
  fi
  echo_green_text "SUCCESS: Validated checksum for file: '${target_file}'!"
  echo "SHA512sum: '${local_sha512sum}'"
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
