#!/bin/bash

set -euo pipefail

# Ensure this is never ran with xtrace...
set +x

# Set-up our environment
if [[ -z "${DOVE_CI+x}" ]]; then
  export DOVE_CI=1
fi
source $(dirname $0)/env.sh

# Include utilities
source "${DOVE_UTILS}"

# Include version info
source "${DOVE_VERSIONS}"

if [[ -z "${DOVE_FROM_AR_UP+x}" ]]; then
  echo_red_text 'ERROR: Do not call ci-upload-artifacts-dove.sh directly. Instead, use ci-upload-artifacts.sh.' >&1
  exit 1
fi

if [[ -z "${CI_PIPELINE_ID+x}" ]]; then
  echo_red_text 'ERROR: Missing pipeline ID! Please set CI_PIPELINE_ID.'
  exit 1
fi

# Verify secrets
verify_file_with_env "${DOVE_CEL_ARTIFACTS_S3_ACCESS_KEY_FILE}" 'DOVE_CEL_ARTIFACTS_S3_ACCESS_KEY_FILE' || exit 1
verify_file_with_env "${DOVE_CEL_ARTIFACTS_S3_BUCKET_NAME_FILE}" 'DOVE_CEL_ARTIFACTS_S3_BUCKET_NAME_FILE' || exit 1
verify_file_with_env "${DOVE_CEL_ARTIFACTS_S3_ENDPOINT_FILE}" 'DOVE_CEL_ARTIFACTS_S3_ENDPOINT_FILE' || exit 1
verify_file_with_env "${DOVE_CEL_ARTIFACTS_S3_SECRET_KEY_FILE}" 'DOVE_CEL_ARTIFACTS_S3_SECRET_KEY_FILE' || exit 1

readonly up_artifact="$1"

# Set-up target parameters
DOVE_AR_UP_LINUX_ARCHIVE=0
DOVE_AR_UP_LINUX_FLATPAK_ARCHIVE=0
DOVE_AR_UP_OSX_ARCHIVE=0
DOVE_AR_UP_OSX_INTEL_ARCHIVE=0
DOVE_AR_UP_WINDOWS_ARCHIVE=0

if [[ "${up_artifact}" == 'linux-archive' ]]; then
  # dove-{DOVE_VERSION}-linux.tar.xz
  DOVE_AR_UP_LINUX_ARCHIVE=1
elif [[ "${up_artifact}" == 'linux-flatpak-archive' ]]; then
  # dove-{DOVE_VERSION}-linux-flatpak.tar.xz
  DOVE_AR_UP_LINUX_FLATPAK_ARCHIVE=1
elif [[ "${up_artifact}" == 'osx-archive' ]]; then
  # dove-{DOVE_VERSION}-osx.tar.xz
  DOVE_AR_UP_OSX_ARCHIVE=1
elif [[ "${up_artifact}" == 'osx-intel-archive' ]]; then
  # dove-{DOVE_VERSION}-osx-intel.tar.xz
  DOVE_AR_UP_OSX_INTEL_ARCHIVE=1
elif [[ "${up_artifact}" == 'windows-archive' ]]; then
  # dove-{DOVE_VERSION}-windows.zip
  DOVE_AR_UP_WINDOWS_ARCHIVE=1
elif [[ "${up_artifact}" == 'all' ]]; then
  # If no argument is specified (or argument is set to "all"), just download everything
  DOVE_AR_UP_LINUX_ARCHIVE=1
  DOVE_AR_UP_LINUX_FLATPAK_ARCHIVE=1
  DOVE_AR_UP_OSX_ARCHIVE=1
  DOVE_AR_UP_OSX_INTEL_ARCHIVE=1
  DOVE_AR_UP_WINDOWS_ARCHIVE=1
else
  echo_red_text "ERROR: Invalid target: ${up_artifact}\n You must enter one of the following:"
  echo 'All:                      all (Default)'
  echo 'Linux archive:            linux-archive'
  echo 'Linux (Flatpak) archive:  linux-flatpak-archive'
  echo 'OS X archive:             osx-archive'
  echo 'OS X (Intel) archive:     osx-intel-archive'
  echo 'Windows archive:          windows-archive'
  exit 1
fi
readonly DOVE_AR_UP_LINUX_ARCHIVE
readonly DOVE_AR_UP_LINUX_FLATPAK_ARCHIVE
readonly DOVE_AR_UP_OSX_ARCHIVE
readonly DOVE_AR_UP_OSX_INTEL_ARCHIVE
readonly DOVE_AR_UP_WINDOWS_ARCHIVE

# Constants

# Target project
readonly DOVE_CEL_S3_PROJECT='dove'

# Pushes a file to S3
function push_file() {
  function print_usage() {
    echo "Usage: push_file '/path/to/file' 'path/on/s3'"
  }

  if [[ -z "${1+x}" ]]; then
    echo_red_text 'ERROR: Please specify the path to a file that should be uploaded to S3 storage'
    print_usage
    exit 1
  fi

  if [[ -z "${2+x}" ]]; then
    echo_red_text 'ERROR: Please specify the target path on S3 storage for where the file should be uploaded'
    print_usage
    exit 1
  fi

  local readonly push_file="$1"
  local readonly s3_path="$2"
  local readonly s3_full_path="${s3_path}/$("${DOVE_BASENAME}" "${push_file}")"

  # Ensure our file to push is valid
  verify_file "${push_file}" || exit 1

  # Set our MIME type
  case "${push_file}" in
    *.log)
      local readonly mime_type='text/plain'
      ;;
    *.tar.xz)
      local readonly mime_type='application/x-gtar'
      ;;
    *.txt)
      local readonly mime_type='text/plain'
      ;;
    *.zip)
      local readonly mime_type='application/zip'
      ;;
    *)
      echo_red_text "ERROR: Unsupported file type: ${push_file}"
      exit 1
      ;;
  esac

  local readonly s3_access_key=$("${DOVE_CAT}" "${DOVE_CEL_ARTIFACTS_S3_ACCESS_KEY_FILE}" | "${DOVE_XARGS}")
  local readonly s3_bucket_name=$("${DOVE_CAT}" "${DOVE_CEL_ARTIFACTS_S3_BUCKET_NAME_FILE}" | "${DOVE_XARGS}")
  local readonly s3_endpoint=$("${DOVE_CAT}" "${DOVE_CEL_ARTIFACTS_S3_ENDPOINT_FILE}" | "${DOVE_XARGS}")
  local readonly s3_secret_key=$("${DOVE_CAT}" "${DOVE_CEL_ARTIFACTS_S3_SECRET_KEY_FILE}" | "${DOVE_XARGS}")

  if [[ "${s3_path}" == 'root' ]]; then
    local readonly s3_target_path="s3://${s3_bucket_name}/${DOVE_CEL_S3_PROJECT}"
  else
    local readonly s3_target_path="s3://${s3_bucket_name}/${DOVE_CEL_S3_PROJECT}/${s3_full_path}"
  fi

  echo_red_text "Uploading ${push_file} to S3..."
  source "${DOVE_PYENV}"
  "${DOVE_S3CMD}" ${DOVE_S3CMD_FLAGS} --mime-type="${mime_type}" put "${push_file}" "${s3_target_path}" \
    --access_key="${s3_access_key}" \
    --secret_key="${s3_secret_key}" \
    --host="${s3_endpoint}" \
    --host-bucket="${s3_endpoint}"
  echo_green_text "SUCCESS: Uploaded ${push_file} to S3"
}

# Creates and pushes a SHA512sum for a file to S3
function add_sha512sum() {
  function print_usage() {
    echo "Usage: add_sha512sum '/path/to/file'"
  }

  if [[ -z "${1+x}" ]]; then
    echo_red_text 'ERROR: Please specify the path to a file that a SHA512sum should be created for'
    print_usage
    exit 1
  fi

  local readonly sha512sum_file_in="$1"
  local readonly sha512sum_file_name=$("${DOVE_BASENAME}" "${sha512sum_file_in}")
  local readonly sha512sum_file_path=$("${DOVE_DIRNAME}" "${sha512sum_file_in}")

  if [[ -z "${2+x}" ]]; then
    local readonly sha512sum_s3path=$("${DOVE_BASENAME}" "${sha512sum_file_path}" | "${DOVE_AWK}" '{print tolower($0)}')
  else
    local readonly sha512sum_s3path="$2"
  fi

  # Ensure our file to create a SHA512sum for is valid
  verify_file "${sha512sum_file_in}" || exit 1

  local readonly sha512sum_file_out="${sha512sum_file_path}/${sha512sum_file_name}-sha512sum.txt"

  # If there's already a SHA512sum file, remove it
  if [[ -f "${sha512sum_file_out}" ]]; then
    "${DOVE_RM}" -f "${sha512sum_file_out}"
  fi

  local readonly local_sha512sum=$("${DOVE_SHA512SUM}" "${sha512sum_file_in}" | "${DOVE_AWK}" '{print $1}')
  echo -n "${local_sha512sum}" > "${sha512sum_file_out}"

  push_file "${sha512sum_file_out}" "${sha512sum_s3path}"
}

# Creates a SHA512sum for and pushes a file to S3
function push_and_add_sha512sum() {
  function print_usage() {
    echo "Usage: push_and_add_sha512sum '/path/to/file' 'path/on/s3'"
  }

  if [[ -z "${1+x}" ]]; then
    echo_red_text 'ERROR: Please specify the path to a file that should be uploaded to S3 storage'
    print_usage
    exit 1
  fi

  if [[ -z "${2+x}" ]]; then
    echo_red_text 'ERROR: Please specify the target path on S3 storage for where the file should be uploaded'
    print_usage
    exit 1
  fi

  local readonly file_in="$1"
  local readonly s3_path_out="$2"

  # Ensure our file to create a SHA512sum for and push is valid
  verify_file "${file_in}" || exit 1

  # Push our file to S3
  push_file "${file_in}" "${s3_path_out}"

  # Create and push a SHA512sum for our file to S3
  add_sha512sum "${file_in}" "${s3_path_out}"
}

# dove-{DOVE_VERSION}-linux.tar.xz
if [[ "${DOVE_AR_UP_LINUX_ARCHIVE}" == 1 ]]; then
  push_and_add_sha512sum "${DOVE_OUTPUTS}/dove-${DOVE_VERSION}-linux.tar.xz" "${CI_PIPELINE_ID}"
fi

# dove-{DOVE_VERSION}-linux-flatpak.tar.xz
if [[ "${DOVE_AR_UP_LINUX_FLATPAK_ARCHIVE}" == 1 ]]; then
  push_and_add_sha512sum "${DOVE_OUTPUTS}/dove-${DOVE_VERSION}-linux-flatpak.tar.xz" "${CI_PIPELINE_ID}"
fi

# dove-{DOVE_VERSION}-osx.tar.xz
if [[ "${DOVE_AR_UP_OSX_ARCHIVE}" == 1 ]]; then
  push_and_add_sha512sum "${DOVE_OUTPUTS}/dove-${DOVE_VERSION}-osx.tar.xz" "${CI_PIPELINE_ID}"
fi

# dove-{DOVE_VERSION}-osx-intel.tar.xz
if [[ "${DOVE_AR_UP_OSX_INTEL_ARCHIVE}" == 1 ]]; then
  push_and_add_sha512sum "${DOVE_OUTPUTS}/dove-${DOVE_VERSION}-osx-intel.tar.xz" "${CI_PIPELINE_ID}"
fi

# dove-{DOVE_VERSION}-windows.zip
if [[ "${DOVE_AR_UP_WINDOWS_ARCHIVE}" == 1 ]]; then
  push_and_add_sha512sum "${DOVE_OUTPUTS}/dove-${DOVE_VERSION}-windows.zip" "${CI_PIPELINE_ID}"
fi
