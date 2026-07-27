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

if [[ -z "${DOVE_FROM_PUSH+x}" ]]; then
  echo_red_text 'ERROR: Do not call ci-push-dove.sh directly. Instead, use ci-push.sh.' >&1
  exit 1
fi

# Verify secrets
verify_file_with_env "${DOVE_CEL_RELEASES_S3_ACCESS_KEY_FILE}" 'DOVE_CEL_RELEASES_S3_ACCESS_KEY_FILE' || exit 1
verify_file_with_env "${DOVE_CEL_RELEASES_S3_BUCKET_NAME_FILE}" 'DOVE_CEL_RELEASES_S3_BUCKET_NAME_FILE' || exit 1
verify_file_with_env "${DOVE_CEL_RELEASES_S3_ENDPOINT_FILE}" 'DOVE_CEL_RELEASES_S3_ENDPOINT_FILE' || exit 1
verify_file_with_env "${DOVE_CEL_RELEASES_S3_SECRET_KEY_FILE}" 'DOVE_CEL_RELEASES_S3_SECRET_KEY_FILE' || exit 1

# Include version info
source "${DOVE_VERSIONS}"

# Constants

# Base releases URL
readonly DOVE_CEL_RELEASES_URL='https://releases.celenity.dev'
readonly DOVE_RELEASES_BASE_URL="${DOVE_CEL_RELEASES_URL}/dove/releases/${DOVE_VERSION}"

# Forgejo (Codeberg)
readonly DOVE_FORGEJO_API_URL='https://codeberg.org/api'
readonly DOVE_FORGEJO_BRANCH='pages'
readonly DOVE_FORGEJO_GENERIC_PACKAGES_URL="${DOVE_FORGEJO_API_URL}/packages/celenity/generic"
readonly DOVE_FORGEJO_PACKAGE_NAME='dove'
readonly DOVE_FORGEJO_REPO='celenity/Dove'
readonly DOVE_FORGEJO_USER='homelander'

# GitHub
readonly DOVE_GITHUB_API_URL='https://api.github.com'
readonly DOVE_GITHUB_BRANCH='pages'
readonly DOVE_GITHUB_REPO='celenityy/Dove'

# GitLab
readonly DOVE_GITLAB_API_URL='https://gitlab.com/api/v4'
readonly DOVE_GITLAB_BRANCH='pages'
readonly DOVE_GITLAB_PACKAGE_NAME='dove'
readonly DOVE_GITLAB_PROJECT_ID='66829593'
readonly DOVE_GITLAB_GENERIC_PACKAGES_URL="${DOVE_GITLAB_API_URL}/projects/${DOVE_GITLAB_PROJECT_ID}/packages/generic"

# Create release notes
function create_release_notes() {
  # Ensure our changelog (for release-specific changes) exists
  local readonly DOVE_CHANGELOG_FILE="${DOVE_ROOT}/changelog.md"
  verify_file "${DOVE_CHANGELOG_FILE}" || exit 1

  # Ensure our release template exists
  local readonly DOVE_RELEASE_TEMPLATE="${DOVE_TEMPLATES}/release-notes.md"
  verify_file "${DOVE_RELEASE_TEMPLATE}" || exit 1

  local readonly DOVE_RELEASE_NOTES="${DOVE_ARTIFACTS}/dove-${DOVE_VERSION}-release-notes.md"
  local readonly DOVE_RELEASE_NOTES_TEMP="${DOVE_TEMP}/dove-${DOVE_VERSION}-release-notes-temp.md"
  "${DOVE_RM}" -f "${DOVE_RELEASE_NOTES}" "${DOVE_RELEASE_NOTES_TEMP}"

  "${DOVE_MKDIR}" -p "${DOVE_ARTIFACTS}" "${DOVE_TEMP}"
  "${DOVE_CP}" -f "${DOVE_RELEASE_TEMPLATE}" "${DOVE_RELEASE_NOTES_TEMP}"

  # Set our version
  "${DOVE_SED}" -i "s|{DOVE_VERSION}|${DOVE_VERSION}|g" "${DOVE_RELEASE_NOTES_TEMP}"

  # Set the previous (current) version
  "${DOVE_CURL}" ${DOVE_CURL_FLAGS} --location "${DOVE_CEL_RELEASES_URL}/dove/releases/latest_release.txt" --output "${DOVE_TEMP}/previous_release.txt"
  local readonly DOVE_PREVIOUS_VERSION=$("${DOVE_CAT}" "${DOVE_TEMP}/previous_release.txt" | "${DOVE_XARGS}")
  "${DOVE_SED}" -i "s|{DOVE_PREVIOUS_VERSION}|${DOVE_PREVIOUS_VERSION}|g" "${DOVE_RELEASE_NOTES_TEMP}"

  # Set our SHA512sums

  # dove-{DOVE_VERSION}-linux.tar.xz
  local readonly DOVE_LINUX_ARCHIVE_SHA512SUM=$("${DOVE_SHA512SUM}" "${DOVE_ARTIFACTS}/dove-${DOVE_VERSION}-linux.tar.xz" | "${DOVE_AWK}" '{print $1}')
  "${DOVE_SED}" -i "s|{DOVE_LINUX_ARCHIVE_SHA512SUM}|${DOVE_LINUX_ARCHIVE_SHA512SUM}|g" "${DOVE_RELEASE_NOTES_TEMP}"

  # dove-{DOVE_VERSION}-linux-flatpak.tar.xz
  local readonly DOVE_LINUX_FLATPAK_ARCHIVE_SHA512SUM=$("${DOVE_SHA512SUM}" "${DOVE_ARTIFACTS}/dove-${DOVE_VERSION}-linux-flatpak.tar.xz" | "${DOVE_AWK}" '{print $1}')
  "${DOVE_SED}" -i "s|{DOVE_LINUX_FLATPAK_ARCHIVE_SHA512SUM}|${DOVE_LINUX_FLATPAK_ARCHIVE_SHA512SUM}|g" "${DOVE_RELEASE_NOTES_TEMP}"

  # dove-{DOVE_VERSION}-osx.tar.xz
  local readonly DOVE_OSX_ARCHIVE_SHA512SUM=$("${DOVE_SHA512SUM}" "${DOVE_ARTIFACTS}/dove-${DOVE_VERSION}-osx.tar.xz" | "${DOVE_AWK}" '{print $1}')
  "${DOVE_SED}" -i "s|{DOVE_OSX_ARCHIVE_SHA512SUM}|${DOVE_OSX_ARCHIVE_SHA512SUM}|g" "${DOVE_RELEASE_NOTES_TEMP}"

  # dove-{DOVE_VERSION}-osx-intel.tar.xz
  local readonly DOVE_OSX_INTEL_ARCHIVE_SHA512SUM=$("${DOVE_SHA512SUM}" "${DOVE_ARTIFACTS}/dove-${DOVE_VERSION}-osx-intel.tar.xz" | "${DOVE_AWK}" '{print $1}')
  "${DOVE_SED}" -i "s|{DOVE_OSX_INTEL_ARCHIVE_SHA512SUM}|${DOVE_OSX_INTEL_ARCHIVE_SHA512SUM}|g" "${DOVE_RELEASE_NOTES_TEMP}"

  # dove-{DOVE_VERSION}-windows.zip
  local readonly DOVE_WINDOWS_ARCHIVE_SHA512SUM=$("${DOVE_SHA512SUM}" "${DOVE_ARTIFACTS}/dove-${DOVE_VERSION}-windows.zip" | "${DOVE_AWK}" '{print $1}')
  "${DOVE_SED}" -i "s|{DOVE_WINDOWS_ARCHIVE_SHA512SUM}|${DOVE_WINDOWS_ARCHIVE_SHA512SUM}|g" "${DOVE_RELEASE_NOTES_TEMP}"

  # Add release-specific changes
  local readonly DOVE_CHANGELOG=$("${DOVE_CAT}" "${DOVE_CHANGELOG_FILE}")
  {
    echo "# Dove ${DOVE_VERSION}"
    echo '____'
    echo ''
    echo '## Changes'
    echo ''
    "${DOVE_CAT}" "${DOVE_ROOT}/changelog.md"
    echo ''
    "${DOVE_CAT}" "${DOVE_RELEASE_NOTES_TEMP}"
  } >> "${DOVE_RELEASE_NOTES}"

  "${DOVE_RM}" -f "${DOVE_RELEASE_NOTES_TEMP}"

  echo_green_text "SUCCESS: Created release notes for Dove: ${DOVE_VERSION}"
}

# Upload a release to Forgejo (Codeberg)'s package registry
function upload_to_forgejo_package_registry() {
  function print_usage() {
    echo "Usage: upload_to_forgejo_package_registry '/path/to/release'"
  }

  if [[ -z "${1+x}" ]]; then
    echo_red_text 'ERROR: Please specify the path to a file that should be uploaded to the Forgejo package registry'
    print_usage
    exit 1
  fi

  # Ensure we have an API token...
  if [[ -z "${DOVE_FORGEJO_CI_API_TOKEN+x}" ]]; then
    echo_red_text 'ERROR: Missing Forgejo CI API Token! Please set DOVE_FORGEJO_CI_API_TOKEN.'
    exit 1
  fi

  local readonly upload_file="$1"
  local readonly upload_file_name="$("${DOVE_BASENAME}" "${upload_file}")"

  # Ensure our file to upload is valid
  verify_file "${upload_file}" || exit 1

  "${DOVE_CURL}" ${DOVE_CURL_FLAGS} --no-verbose --user "${DOVE_FORGEJO_USER}:${DOVE_FORGEJO_CI_API_TOKEN}" \
    --upload-file "${upload_file}" \
    "${DOVE_FORGEJO_GENERIC_PACKAGES_URL}/${DOVE_FORGEJO_PACKAGE_NAME}/${DOVE_VERSION}/${upload_file_name}"
}

# Upload a release to GitLab's package registry
function upload_to_gitlab_package_registry() {
  function print_usage() {
    echo "Usage: upload_to_gitlab_package_registry '/path/to/release'"
  }

  if [[ -z "${1+x}" ]]; then
    echo_red_text 'ERROR: Please specify the path to a file that should be uploaded to the GitLab package registry'
    print_usage
    exit 1
  fi

  # Ensure we have an API token...
  if [[ -z "${DOVE_GITLAB_CI_API_TOKEN+x}" ]]; then
    echo_red_text 'ERROR: Missing GitLab CI API Token! Please set DOVE_GITLAB_CI_API_TOKEN.'
    exit 1
  fi

  local readonly upload_file="$1"
  local readonly upload_file_name="$("${DOVE_BASENAME}" "${upload_file}")"

  # Ensure our file to upload is valid
  verify_file "${upload_file}" || exit 1

  "${DOVE_CURL}" ${DOVE_CURL_FLAGS} --no-verbose --header "PRIVATE-TOKEN: ${DOVE_GITLAB_CI_API_TOKEN}" \
    --upload-file "${upload_file}" \
    "${DOVE_GITLAB_GENERIC_PACKAGES_URL}/${DOVE_GITLAB_PACKAGE_NAME}/${DOVE_VERSION}/${upload_file_name}"
}

# Add an asset to a Forgejo (Codeberg) release
function add_asset_to_forgejo_release() {
  function print_usage() {
    echo "Usage: add_asset_to_forgejo_release 'release_id' 'https://totally.real.url/asset'"
  }

  if [[ -z "${1+x}" ]]; then
    echo_red_text 'ERROR: Please specify the ID of the release we should attach the asset to!'
    print_usage
    exit 1
  fi

  if [[ -z "${2+x}" ]]; then
    echo_red_text 'ERROR: Please specify the external URL of an asset to attach!'
    print_usage
    exit 1
  fi

  # Ensure we have an API token...
  if [[ -z "${DOVE_FORGEJO_CI_API_TOKEN+x}" ]]; then
    echo_red_text 'ERROR: Missing Forgejo CI API Token! Please set DOVE_FORGEJO_CI_API_TOKEN.'
    exit 1
  fi

  local readonly release_id="$1"
  local readonly asset_url="$2"
  local readonly asset=$("${DOVE_BASENAME}" "${asset_url}")

  "${DOVE_CURL}" ${DOVE_CURL_FLAGS} --no-verbose --header 'accept: application/json' \
    --header "Authorization: token ${DOVE_FORGEJO_CI_API_TOKEN}" \
    -F "external_url=${asset_url}" \
    --request POST \
    "${DOVE_FORGEJO_API_URL}/v1/repos/${DOVE_FORGEJO_REPO}/releases/${release_id}/assets?name=$(printf '%s' "${asset}" | "${DOVE_JQ}" -sRr @uri)"

  echo_green_text "SUCCESS: Added ${asset} to release: ${DOVE_VERSION}"
}

# Publish a release to Forgejo (Codeberg)
function publish_to_forgejo() {
  local readonly DOVE_RELEASE_NOTES="${DOVE_TEMP}/dove-${DOVE_VERSION}-release-notes.md"

  if [[ ! -f "${DOVE_RELEASE_NOTES}" ]]; then
    echo_red_text "ERROR: Missing release notes! (${DOVE_RELEASE_NOTES})"
    exit 1
  fi

  # Ensure we have an API token...
  if [[ -z "${DOVE_FORGEJO_CI_API_TOKEN+x}" ]]; then
    echo_red_text 'ERROR: Missing Forgejo CI API Token! Please set DOVE_FORGEJO_CI_API_TOKEN.'
    exit 1
  fi

  local readonly dove_release_desc=$("${DOVE_CAT}" "${DOVE_RELEASE_NOTES}")

  local readonly dove_codeberg_release_data="$(
    "${DOVE_JQ}" -Rs --arg name "${DOVE_VERSION}" --arg ref "${DOVE_FORGEJO_BRANCH}" --arg tag "${DOVE_VERSION}" '{
      name: $name,
      tag_name: $tag,
      target_commitish: $ref,
      draft: false,
      prerelease: false,
      body: .
      }' <<< "${dove_release_desc}"
  )"

  local readonly dove_codeberg_release=$("${DOVE_CURL}" ${DOVE_CURL_FLAGS} --no-verbose --header 'Content-Type: application/json' \
    --header 'accept: application/json' \
    --header "Authorization: token ${DOVE_FORGEJO_CI_API_TOKEN}" \
    --data "${dove_codeberg_release_data}" \
    --request POST \
    "${DOVE_FORGEJO_API_URL}/v1/repos/${DOVE_FORGEJO_REPO}/releases")

  # Get our release ID
  local readonly dove_codeberg_release_id=$(echo "${dove_codeberg_release}" | "${DOVE_JQ}" -r '.id')

  # Attach our assets

  # dove-{DOVE_VERSION}-linux.tar.xz
  add_asset_to_forgejo_release "${dove_codeberg_release_id}" "${DOVE_RELEASES_BASE_URL}/linux/dove-${DOVE_VERSION}-linux.tar.xz"
  add_asset_to_forgejo_release "${dove_codeberg_release_id}" "${DOVE_RELEASES_BASE_URL}/linux/dove-${DOVE_VERSION}-linux.tar.xz-sha512sum.txt"

  # dove-{DOVE_VERSION}-linux-flatpak.tar.xz
  add_asset_to_forgejo_release "${dove_codeberg_release_id}" "${DOVE_RELEASES_BASE_URL}/linux-flatpak/dove-${DOVE_VERSION}-linux-flatpak.tar.xz"
  add_asset_to_forgejo_release "${dove_codeberg_release_id}" "${DOVE_RELEASES_BASE_URL}/linux-flatpak/dove-${DOVE_VERSION}-linux-flatpak.tar.xz-sha512sum.txt"

  # dove-{DOVE_VERSION}-osx.tar.xz
  add_asset_to_forgejo_release "${dove_codeberg_release_id}" "${DOVE_RELEASES_BASE_URL}/osx/dove-${DOVE_VERSION}-osx.tar.xz"
  add_asset_to_forgejo_release "${dove_codeberg_release_id}" "${DOVE_RELEASES_BASE_URL}/osx/dove-${DOVE_VERSION}-osx.tar.xz-sha512sum.txt"

  # dove-{DOVE_VERSION}-osx-intel.tar.xz
  add_asset_to_forgejo_release "${dove_codeberg_release_id}" "${DOVE_RELEASES_BASE_URL}/osx-intel/dove-${DOVE_VERSION}-osx-intel.tar.xz"
  add_asset_to_forgejo_release "${dove_codeberg_release_id}" "${DOVE_RELEASES_BASE_URL}/osx-intel/dove-${DOVE_VERSION}-osx-intel.tar.xz-sha512sum.txt"

  # dove-{DOVE_VERSION}-windows.zip
  add_asset_to_forgejo_release "${dove_codeberg_release_id}" "${DOVE_RELEASES_BASE_URL}/windows/dove-${DOVE_VERSION}-windows.zip"
  add_asset_to_forgejo_release "${dove_codeberg_release_id}" "${DOVE_RELEASES_BASE_URL}/windows/dove-${DOVE_VERSION}-windows.zip-sha512sum.txt"

  # We're done! :)
  echo_green_text "SUCCESS: Published Dove: ${DOVE_VERSION} to Forgejo"
}

# Publish a release to GitHub
function publish_to_github() {
  local readonly DOVE_RELEASE_NOTES="${DOVE_TEMP}/dove-${DOVE_VERSION}-release-notes.md"

  if [[ ! -f "${DOVE_RELEASE_NOTES}" ]]; then
    echo_red_text "ERROR: Missing release notes! (${DOVE_RELEASE_NOTES})"
    exit 1
  fi

  # Ensure we have an API token...
  if [[ -z "${DOVE_GITHUB_CI_API_TOKEN+x}" ]]; then
    echo_red_text 'ERROR: Missing GitHub CI API Token! Please set DOVE_GITHUB_CI_API_TOKEN.'
    exit 1
  fi

  local readonly dove_release_desc=$("${DOVE_CAT}" "${DOVE_RELEASE_NOTES}")

  local readonly dove_github_release_data="$(
    "${DOVE_JQ}" -Rs --arg name "${DOVE_VERSION}" --arg ref "${DOVE_GITHUB_BRANCH}" --arg tag "${DOVE_VERSION}" '{
      name: $name,
      tag_name: $tag,
      target_commitish: $ref,
      draft: false,
      prerelease: false,
      body: .
      }' <<< "${dove_release_desc}"
  )"

  "${DOVE_CURL}" ${DOVE_CURL_FLAGS} --no-verbose --header 'Content-Type: application/json' \
    --header 'Accept: application/vnd.github+json' \
    --header "Authorization: Bearer ${DOVE_GITHUB_CI_API_TOKEN}" \
    --header "X-GitHub-Api-Version: 2026-03-10" \
    --data "${dove_github_release_data}" \
    --request POST \
    "${DOVE_GITHUB_API_URL}/repos/${DOVE_GITHUB_REPO}/releases"

  # We're done! :)
  echo_green_text "SUCCESS: Published Dove: ${DOVE_VERSION} to GitHub"
}

# Publish a release to GitLab
function publish_to_gitlab() {
  local readonly DOVE_RELEASE_NOTES="${DOVE_TEMP}/dove-${DOVE_VERSION}-release-notes.md"

  if [[ ! -f "${DOVE_RELEASE_NOTES}" ]]; then
    echo_red_text "ERROR: Missing release notes! (${DOVE_RELEASE_NOTES})"
    exit 1
  fi

  # Ensure we have an API token...
  if [[ -z "${DOVE_GITLAB_CI_API_TOKEN+x}" ]]; then
    echo_red_text 'ERROR: Missing GitLab CI API Token! Please set DOVE_GITLAB_CI_API_TOKEN.'
    exit 1
  fi

  local readonly dove_release_desc=$("${DOVE_CAT}" "${DOVE_RELEASE_NOTES}")

  # Attach our assets

  # dove-{DOVE_VERSION}-linux.tar.xz
  local readonly DOVE_LINUX_ARCHIVE_NAME="dove-${DOVE_VERSION}-linux.tar.xz"
  local readonly DOVE_LINUX_ARCHIVE_URL="${DOVE_RELEASES_BASE_URL}/linux/${DOVE_LINUX_ARCHIVE_NAME}"
  local readonly DOVE_LINUX_ARCHIVE_SHA512SUM_NAME="${DOVE_LINUX_ARCHIVE_NAME}-sha512sum.txt"
  local readonly DOVE_LINUX_ARCHIVE_SHA512SUM_URL="${DOVE_LINUX_ARCHIVE_URL}-sha512sum.txt"
  upload_to_gitlab_package_registry "${DOVE_ARTIFACTS}/${DOVE_LINUX_ARCHIVE_NAME}"
  upload_to_gitlab_package_registry "${DOVE_ARTIFACTS}/${DOVE_LINUX_ARCHIVE_SHA512SUM_NAME}"

  # dove-{DOVE_VERSION}-linux-flatpak.tar.xz
  local readonly DOVE_LINUX_FLATPAK_ARCHIVE_NAME="dove-${DOVE_VERSION}-linux-flatpak.tar.xz"
  local readonly DOVE_LINUX_FLATPAK_ARCHIVE_URL="${DOVE_RELEASES_BASE_URL}/linux-flatpak/${DOVE_LINUX_FLATPAK_ARCHIVE_NAME}"
  local readonly DOVE_LINUX_FLATPAK_ARCHIVE_SHA512SUM_NAME="${DOVE_LINUX_FLATPAK_ARCHIVE_NAME}-sha512sum.txt"
  local readonly DOVE_LINUX_FLATPAK_ARCHIVE_SHA512SUM_URL="${DOVE_LINUX_FLATPAK_ARCHIVE_URL}-sha512sum.txt"
  upload_to_gitlab_package_registry "${DOVE_ARTIFACTS}/${DOVE_LINUX_FLATPAK_ARCHIVE_NAME}"
  upload_to_gitlab_package_registry "${DOVE_ARTIFACTS}/${DOVE_LINUX_FLATPAK_ARCHIVE_SHA512SUM_NAME}"

  # dove-{DOVE_VERSION}-osx.tar.xz
  local readonly DOVE_OSX_ARCHIVE_NAME="dove-${DOVE_VERSION}-osx.tar.xz"
  local readonly DOVE_OSX_ARCHIVE_URL="${DOVE_RELEASES_BASE_URL}/osx/${DOVE_OSX_ARCHIVE_NAME}"
  local readonly DOVE_OSX_ARCHIVE_SHA512SUM_NAME="${DOVE_OSX_ARCHIVE_NAME}-sha512sum.txt"
  local readonly DOVE_OSX_ARCHIVE_SHA512SUM_URL="${DOVE_OSX_ARCHIVE_URL}-sha512sum.txt"
  upload_to_gitlab_package_registry "${DOVE_ARTIFACTS}/${DOVE_OSX_ARCHIVE_NAME}"
  upload_to_gitlab_package_registry "${DOVE_ARTIFACTS}/${DOVE_OSX_ARCHIVE_SHA512SUM_NAME}"

  # dove-{DOVE_VERSION}-osx-intel.tar.xz
  local readonly DOVE_OSX_INTEL_ARCHIVE_NAME="dove-${DOVE_VERSION}-osx-intel.tar.xz"
  local readonly DOVE_OSX_INTEL_ARCHIVE_URL="${DOVE_RELEASES_BASE_URL}/osx-intel/${DOVE_OSX_INTEL_ARCHIVE_NAME}"
  local readonly DOVE_OSX_INTEL_ARCHIVE_SHA512SUM_NAME="${DOVE_OSX_INTEL_ARCHIVE_NAME}-sha512sum.txt"
  local readonly DOVE_OSX_INTEL_ARCHIVE_SHA512SUM_URL="${DOVE_OSX_INTEL_ARCHIVE_URL}-sha512sum.txt"
  upload_to_gitlab_package_registry "${DOVE_ARTIFACTS}/${DOVE_OSX_INTEL_ARCHIVE_NAME}"
  upload_to_gitlab_package_registry "${DOVE_ARTIFACTS}/${DOVE_OSX_INTEL_ARCHIVE_SHA512SUM_NAME}"

  # dove-{DOVE_VERSION}-windows.zip
  local readonly DOVE_WINDOWS_ARCHIVE_NAME="dove-${DOVE_VERSION}-windows.zip"
  local readonly DOVE_WINDOWS_ARCHIVE_URL="${DOVE_RELEASES_BASE_URL}/windows/${DOVE_WINDOWS_ARCHIVE_NAME}"
  local readonly DOVE_WINDOWS_ARCHIVE_SHA512SUM_NAME="${DOVE_WINDOWS_ARCHIVE_NAME}-sha512sum.txt"
  local readonly DOVE_WINDOWS_ARCHIVE_SHA512SUM_URL="${DOVE_WINDOWS_ARCHIVE_URL}-sha512sum.txt"
  upload_to_gitlab_package_registry "${DOVE_ARTIFACTS}/${DOVE_WINDOWS_ARCHIVE_NAME}"
  upload_to_gitlab_package_registry "${DOVE_ARTIFACTS}/${DOVE_WINDOWS_ARCHIVE_SHA512SUM_NAME}"

  local readonly dove_gitlab_release_data="$(
    "${DOVE_JQ}" -Rs --arg name "${DOVE_VERSION}" --arg ref "${DOVE_GITLAB_BRANCH}" --arg tag "${DOVE_VERSION}" --arg version "${DOVE_VERSION}" \
    --arg linux_archive_name "${DOVE_LINUX_ARCHIVE_NAME}" \
    --arg linux_archive_url "${DOVE_LINUX_ARCHIVE_URL}" \
    --arg linux_archive_sha512sum_name "${DOVE_LINUX_ARCHIVE_SHA512SUM_NAME}" \
    --arg linux_archive_sha512sum_url "${DOVE_LINUX_ARCHIVE_SHA512SUM_URL}" \
    --arg linux_flatpak_archive_name "${DOVE_LINUX_FLATPAK_ARCHIVE_NAME}" \
    --arg linux_flatpak_archive_url "${DOVE_LINUX_FLATPAK_ARCHIVE_URL}" \
    --arg linux_flatpak_archive_sha512sum_name "${DOVE_LINUX_FLATPAK_ARCHIVE_SHA512SUM_NAME}" \
    --arg linux_flatpak_archive_sha512sum_url "${DOVE_LINUX_FLATPAK_ARCHIVE_SHA512SUM_URL}" \
    --arg osx_archive_name "${DOVE_OSX_ARCHIVE_NAME}" \
    --arg osx_archive_url "${DOVE_OSX_ARCHIVE_URL}" \
    --arg osx_archive_sha512sum_name "${DOVE_OSX_ARCHIVE_SHA512SUM_NAME}" \
    --arg osx_archive_sha512sum_url "${DOVE_OSX_ARCHIVE_SHA512SUM_URL}" \
    --arg osx_intel_archive_name "${DOVE_OSX_INTEL_ARCHIVE_NAME}" \
    --arg osx_intel_archive_url "${DOVE_OSX_INTEL_ARCHIVE_URL}" \
    --arg osx_intel_archive_sha512sum_name "${DOVE_OSX_INTEL_ARCHIVE_SHA512SUM_NAME}" \
    --arg osx_intel_archive_sha512sum_url "${DOVE_OSX_INTEL_ARCHIVE_SHA512SUM_URL}" \
    --arg windows_archive_name "${DOVE_WINDOWS_ARCHIVE_NAME}" \
    --arg windows_archive_url "${DOVE_WINDOWS_ARCHIVE_URL}" \
    --arg windows_archive_sha512sum_name "${DOVE_WINDOWS_ARCHIVE_SHA512SUM_NAME}" \
    --arg windows_archive_sha512sum_url "${DOVE_WINDOWS_ARCHIVE_SHA512SUM_URL}" \
    '{
      name: $name,
      ref: $ref,
      tag_name: $tag,
      assets: {
        links: [
          {
            name: $linux_archive_name,
            url: $linux_archive_url,
            link_type: "package"
          },
          {
            name: $linux_archive_sha512sum_name,
            url: $linux_archive_sha512sum_url,
            link_type: "package"
          },
          {
            name: $linux_flatpak_archive_name,
            url: $linux_flatpak_archive_url,
            link_type: "package"
          },
          {
            name: $linux_flatpak_archive_sha512sum_name,
            url: $linux_flatpak_archive_sha512sum_url,
            link_type: "package"
          },
          {
            name: $osx_archive_name,
            url: $osx_archive_url,
            link_type: "package"
          },
          {
            name: $osx_archive_sha512sum_name,
            url: $osx_archive_sha512sum_url,
            link_type: "package"
          },
          {
            name: $osx_intel_archive_name,
            url: $osx_intel_archive_url,
            link_type: "package"
          },
          {
            name: $osx_intel_archive_sha512sum_name,
            url: $osx_intel_archive_sha512sum_url,
            link_type: "package"
          },
          {
            name: $windows_archive_name,
            url: $windows_archive_url,
            link_type: "package"
          },
          {
            name: $windows_archive_sha512sum_name,
            url: $windows_archive_sha512sum_url,
            link_type: "package"
          }
        ]
      },
      description: .
      }' <<< "${dove_release_desc}"
  )"

  "${DOVE_CURL}" ${DOVE_CURL_FLAGS} --no-verbose --header 'Content-Type: application/json' \
    --header "PRIVATE-TOKEN: ${DOVE_GITLAB_CI_API_TOKEN}" \
    --data "${dove_gitlab_release_data}" \
    --request POST \
    "${DOVE_GITLAB_API_URL}/projects/${DOVE_GITLAB_PROJECT_ID}/releases"

  # We're done! :)
  echo_green_text "SUCCESS: Published Dove: ${DOVE_VERSION} to GitLab"
}

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
    *.js)
      local readonly mime_type='text/javascript'
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

  local readonly s3_access_key=$("${DOVE_CAT}" "${DOVE_CEL_RELEASES_S3_ACCESS_KEY_FILE}" | "${DOVE_XARGS}")
  local readonly s3_bucket_name=$("${DOVE_CAT}" "${DOVE_CEL_RELEASES_S3_BUCKET_NAME_FILE}" | "${DOVE_XARGS}")
  local readonly s3_endpoint=$("${DOVE_CAT}" "${DOVE_CEL_RELEASES_S3_ENDPOINT_FILE}" | "${DOVE_XARGS}")
  local readonly s3_secret_key=$("${DOVE_CAT}" "${DOVE_CEL_RELEASES_S3_SECRET_KEY_FILE}" | "${DOVE_XARGS}")

  if [[ "${s3_path}" == 'root' ]]; then
    local readonly s3_target_path="s3://${s3_bucket_name}"
  else
    local readonly s3_target_path="s3://${s3_bucket_name}/${s3_full_path}"
  fi

  echo_red_text "Pushing ${push_file} to S3..."
  source "${DOVE_PYENV}"
  "${DOVE_S3CMD}" ${DOVE_S3CMD_FLAGS} --mime-type="${mime_type}" put "${push_file}" "${s3_target_path}" \
    --access_key="${s3_access_key}" \
    --secret_key="${s3_secret_key}" \
    --host="${s3_endpoint}" \
    --host-bucket="${s3_endpoint}"
  echo_green_text "SUCCESS: Pushed ${push_file} to S3"
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

# Push Dove for a desired platform
function _push_dove() {
  function print_usage() {
    echo "Usage: _push_dove 'platform'"
  }

  if [[ -z "${1+x}" ]]; then
    echo_red_text 'ERROR: Please specify the platform you wou would like to push Dove for'
    print_usage
    exit 1
  fi

  local readonly dove_platform="$1"

  # Set our archive type
  if [[ "${dove_platform}" == 'windows' ]]; then
    local readonly dove_archive_type='zip'
  else
    local readonly dove_archive_type='tar.xz'
  fi

  push_and_add_sha512sum "${DOVE_ARTIFACTS}/dove-${DOVE_VERSION}-${dove_platform}.${dove_archive_type}" "dove/releases/${DOVE_VERSION}/${dove_platform}"

  # Ensure the latest version can always be downloaded from https://releases.celenity.dev/dove/releases/latest/{dove_platform}/dove-latest-{dove_platform}.${dove_archive_type}
  ## (Ex. for convenience/packaging)
  "${DOVE_CP}" -f "${DOVE_ARTIFACTS}/dove-${DOVE_VERSION}-${dove_platform}.${dove_archive_type}" "${DOVE_ARTIFACTS}/dove-latest-${dove_platform}.${dove_archive_type}"
  push_and_add_sha512sum "${DOVE_ARTIFACTS}/dove-latest-${dove_platform}.${dove_archive_type}" "dove/releases/latest/${dove_platform}"
}

# Push Dove to S3 storage
function push_dove() {
  # Linux
  _push_dove 'linux'

  # Linux (Flatpak)
  _push_dove 'linux-flatpak'

  # OS X
  _push_dove 'osx'

  # OS X (Intel)
  _push_dove 'osx-intel'

  # Windows
  _push_dove 'windows'

  # Update the current Dove version
  "${DOVE_MKDIR}" -p "${DOVE_TEMP}"
  "${DOVE_TOUCH}" "${DOVE_TEMP}/latest_release.txt"
  echo -n "${DOVE_VERSION}" > "${DOVE_TEMP}/latest_release.txt"
  push_and_add_sha512sum "${DOVE_TEMP}/latest_release.txt" 'dove/releases'

  # Add release notes
  push_and_add_sha512sum "${DOVE_ARTIFACTS}/dove-${DOVE_VERSION}-release-notes.md" "dove/releases/${DOVE_VERSION}"

  echo_green_text "SUCCESS: Pushed Dove: ${DOVE_VERSION} to ${DOVE_CEL_RELEASES_URL}"
}

# First, create our release notes
create_release_notes

# Push Dove to S3
push_dove

# Create a Forgejo (Codeberg) release
publish_to_forgejo

# Create a GitLab release
publish_to_gitlab

# Create a GitHub release
publish_to_github
