#!/bin/bash

set -euo pipefail

# Ensure this is never ran with xtrace...
set +x

# Include S3 utilities
verify_file_with_env "${DOVE_S3_UTILS}" 'DOVE_S3_UTILS' || return 1
source "${DOVE_S3_UTILS}" || return 1

if [[ -z "${DOVE_FROM_AR_UP+x}" ]]; then
  echo_red_text "ERROR: Do not call 'ci-upload-artifacts-dove.sh' directly! Instead, use 'ci-upload-artifacts.sh'." >&1
  return 1
fi

# Ensure we have `DOVE_CI`
verify_env "${DOVE_CI}" 'DOVE_CI' || return 1

if [[ "${DOVE_CI}" != 1 ]]; then
  echo_red_text "ERROR: '$0' should only be called from CI!"
  return 1
fi

# Ensure we have `DOVE_CI_ID`
verify_env "${DOVE_CI_ID}" 'DOVE_CI_ID' || return 1

# Verify secrets
verify_file_with_env "${DOVE_CEL_ARTIFACTS_S3_ACCESS_KEY_FILE}" 'DOVE_CEL_ARTIFACTS_S3_ACCESS_KEY_FILE' || return 1
verify_file_with_env "${DOVE_CEL_ARTIFACTS_S3_BUCKET_NAME_FILE}" 'DOVE_CEL_ARTIFACTS_S3_BUCKET_NAME_FILE' || return 1
verify_file_with_env "${DOVE_CEL_ARTIFACTS_S3_ENDPOINT_FILE}" 'DOVE_CEL_ARTIFACTS_S3_ENDPOINT_FILE' || return 1
verify_file_with_env "${DOVE_CEL_ARTIFACTS_S3_SECRET_KEY_FILE}" 'DOVE_CEL_ARTIFACTS_S3_SECRET_KEY_FILE' || return 1

# Ensure we have `DOVE_OUTPUTS`
verify_env "${DOVE_OUTPUTS}" 'DOVE_OUTPUTS' || return 1

# Ensure we have `DOVE_VERSION`
verify_env "${DOVE_VERSION}" 'DOVE_VERSION' || return 1

verify_env "${target_artifact}" 'target_artifact' || {
  echo_red_text "ERROR: Missing target artifact!"
  return 1
}

# Set-up target parameters
DOVE_AR_UP_LINUX_ARCHIVE=0
DOVE_AR_UP_LINUX_FLATPAK_ARCHIVE=0
DOVE_AR_UP_OSX_ARCHIVE=0
DOVE_AR_UP_OSX_INTEL_ARCHIVE=0
DOVE_AR_UP_WINDOWS_ARCHIVE=0

if [[ "${target_artifact}" == 'linux-archive' ]]; then
  # dove-{DOVE_VERSION}-linux.tar.xz
  DOVE_AR_UP_LINUX_ARCHIVE=1
elif [[ "${target_artifact}" == 'linux-flatpak-archive' ]]; then
  # dove-{DOVE_VERSION}-linux-flatpak.tar.xz
  DOVE_AR_UP_LINUX_FLATPAK_ARCHIVE=1
elif [[ "${target_artifact}" == 'osx-archive' ]]; then
  # dove-{DOVE_VERSION}-osx.tar.xz
  DOVE_AR_UP_OSX_ARCHIVE=1
elif [[ "${target_artifact}" == 'osx-intel-archive' ]]; then
  # dove-{DOVE_VERSION}-osx-intel.tar.xz
  DOVE_AR_UP_OSX_INTEL_ARCHIVE=1
elif [[ "${target_artifact}" == 'windows-archive' ]]; then
  # dove-{DOVE_VERSION}-windows.zip
  DOVE_AR_UP_WINDOWS_ARCHIVE=1
elif [[ "${target_artifact}" == 'all' ]]; then
  # If no argument is specified (or argument is set to "all"), just download everything
  DOVE_AR_UP_LINUX_ARCHIVE=1
  DOVE_AR_UP_LINUX_FLATPAK_ARCHIVE=1
  DOVE_AR_UP_OSX_ARCHIVE=1
  DOVE_AR_UP_OSX_INTEL_ARCHIVE=1
  DOVE_AR_UP_WINDOWS_ARCHIVE=1
else
  echo_red_text "ERROR: Invalid target: '${target_artifact}'\n You must enter one of the following:"
  echo 'All:                      all (Default)'
  echo 'Linux archive:            linux-archive'
  echo 'Linux (Flatpak) archive:  linux-flatpak-archive'
  echo 'OS X archive:             osx-archive'
  echo 'OS X (Intel) archive:     osx-intel-archive'
  echo 'Windows archive:          windows-archive'
  return 1
fi
readonly DOVE_AR_UP_LINUX_ARCHIVE
readonly DOVE_AR_UP_LINUX_FLATPAK_ARCHIVE
readonly DOVE_AR_UP_OSX_ARCHIVE
readonly DOVE_AR_UP_OSX_INTEL_ARCHIVE
readonly DOVE_AR_UP_WINDOWS_ARCHIVE

# Constants

# Target S3 path
readonly DOVE_S3_PATH="dove/${DOVE_CI_ID}"

# Push a file with a SHA512sum to S3 storage
function push_to_s3() {
  function print_usage() {
    echo "Usage: push_to_s3 '/path/to/file' 'path/on/s3'"
  }

  if [[ -z "${1+x}" ]]; then
    echo_red_text 'ERROR: Please specify the path to a file that should be uploaded to S3 storage!'
    print_usage
    return 1
  fi

  if [[ -z "${2+x}" ]]; then
    echo_red_text 'ERROR: Please specify the target path on S3 storage for where the file should be uploaded!'
    print_usage
    return 1
  fi

  local -r push_file="$1"
  local -r s3_path="$2"

  local -r s3_access_key_file="${DOVE_CEL_ARTIFACTS_S3_ACCESS_KEY_FILE}"
  local -r s3_bucket_name_file="${DOVE_CEL_ARTIFACTS_S3_BUCKET_NAME_FILE}"
  local -r s3_endpoint_file="${DOVE_CEL_ARTIFACTS_S3_ENDPOINT_FILE}"
  local -r s3_secret_key_file="${DOVE_CEL_ARTIFACTS_S3_SECRET_KEY_FILE}"

  # Ensure our file to push is valid
  verify_file "${push_file}" || return 1

  # Create and push a SHA512sum for our file to S3 storage
  push_and_add_sha512sum "${push_file}" "${s3_path}" "${s3_access_key_file}" "${s3_bucket_name_file}" "${s3_endpoint_file}" "${s3_secret_key_file}"
}

# dove-{DOVE_VERSION}-linux.tar.xz
if [[ "${DOVE_AR_UP_LINUX_ARCHIVE}" == 1 ]]; then
  push_to_s3 "${DOVE_OUTPUTS}/dove-${DOVE_VERSION}-linux.tar.xz" "${DOVE_S3_PATH}"
fi

# dove-{DOVE_VERSION}-linux-flatpak.tar.xz
if [[ "${DOVE_AR_UP_LINUX_FLATPAK_ARCHIVE}" == 1 ]]; then
  push_to_s3 "${DOVE_OUTPUTS}/dove-${DOVE_VERSION}-linux-flatpak.tar.xz" "${DOVE_S3_PATH}"
fi

# dove-{DOVE_VERSION}-osx.tar.xz
if [[ "${DOVE_AR_UP_OSX_ARCHIVE}" == 1 ]]; then
  push_to_s3 "${DOVE_OUTPUTS}/dove-${DOVE_VERSION}-osx.tar.xz" "${DOVE_S3_PATH}"
fi

# dove-{DOVE_VERSION}-osx-intel.tar.xz
if [[ "${DOVE_AR_UP_OSX_INTEL_ARCHIVE}" == 1 ]]; then
  push_to_s3 "${DOVE_OUTPUTS}/dove-${DOVE_VERSION}-osx-intel.tar.xz" "${DOVE_S3_PATH}"
fi

# dove-{DOVE_VERSION}-windows.zip
if [[ "${DOVE_AR_UP_WINDOWS_ARCHIVE}" == 1 ]]; then
  push_to_s3 "${DOVE_OUTPUTS}/dove-${DOVE_VERSION}-windows.zip" "${DOVE_S3_PATH}"
fi
