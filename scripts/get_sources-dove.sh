#!/bin/bash

set -euo pipefail

# Set-up our environment
source $(dirname $0)/env.sh

# Include utilities
source "${DOVE_UTILS}"

if [[ -z "${DOVE_FROM_SOURCES+x}" ]]; then
  echo_red_text "ERROR: Do not call get_sources-dove.sh directly. Instead, use get_sources.sh." >&1
  exit 1
fi

# Set verbosity
if [[ "${DOVE_VERBOSE}" == 1 ]]; then
  set -x
else
  set +x
fi

readonly target="$1"
readonly mode="$2"

# Set-up target parameters
DOVE_GET_SOURCE_AUTOCONFIG=0
DOVE_GET_SOURCE_LXML=0
DOVE_GET_SOURCE_PHOENIX=0
DOVE_GET_SOURCE_PYTHON=0
DOVE_GET_SOURCE_S3CMD=0
DOVE_GET_SOURCE_UV=0

if [[ "${target}" == 'autoconfig' ]]; then
  # Get Thunderbird's Autoconfiguration Database (ISPDB)
  DOVE_GET_SOURCE_AUTOCONFIG=1
elif [[ "${target}" == 'lxml' ]]; then
  # Get lxml
  DOVE_GET_SOURCE_LXML=1
elif [[ "${target}" == 'phoenix' ]]; then
  # Get Phoenix
  DOVE_GET_SOURCE_PHOENIX=1
elif [[ "${target}" == 'python' ]]; then
  #  Get Python
  DOVE_GET_SOURCE_PYTHON=1
elif [[ "${target}" == 's3cmd' ]]; then
  # Get s3cmd
  DOVE_GET_SOURCE_S3CMD=1
elif [[ "${target}" == 'uv' ]]; then
  # Get + set-up uv
  DOVE_GET_SOURCE_UV=1
elif [[ "${target}" == 'all' ]]; then
  # If no argument is specified (or argument is set to "all"), just get everything, except s3cmd
  ## (We don't need to bother getting s3cmd here since it's only used in certain scenarios)
  DOVE_GET_SOURCE_AUTOCONFIG=1
  DOVE_GET_SOURCE_LXML=1
  DOVE_GET_SOURCE_PHOENIX=1
  DOVE_GET_SOURCE_PYTHON=1
  DOVE_GET_SOURCE_UV=1
else
  echo_red_text "ERROR: Invalid target: ${target}\n You must enter one of the following:"
  echo 'All:                                      all (Default)'
  echo 'lxml:                                     lxml'
  echo 'Phoenix:                                  phoenix'
  echo 'Python:                                   python'
  echo 's3cmd:                                    s3cmd'
  echo 'Thunderbird Autoconfiguration Database:   autoconfig'
  echo 'uv:                                       uv'
  exit 1
fi
readonly DOVE_GET_SOURCE_AUTOCONFIG
readonly DOVE_GET_SOURCE_LXML
readonly DOVE_GET_SOURCE_PHOENIX
readonly DOVE_GET_SOURCE_PYTHON
readonly DOVE_GET_SOURCE_S3CMD
readonly DOVE_GET_SOURCE_UV

# If the 'checksum-update' argument is specified, in addition to downloading the dependencies as usual,
## we're also updating their checksums
DOVE_GET_SOURCE_CHECKSUM_UPDATE=0
if [[ "${mode}" == 'checksum-update' ]]; then
  DOVE_GET_SOURCE_CHECKSUM_UPDATE=1
elif [[ "${mode}" != 'download' ]]; then
  echo_red_text "ERROR: Invalid mode: ${mode}\n You must enter one of the following:"
  echo 'Download:                     download (Default)'
  echo 'Download + update checksums:  checksum-update'
  exit 1
fi
readonly DOVE_GET_SOURCE_CHECKSUM_UPDATE

# Include version info
source "${DOVE_VERSIONS}"

# Back-up (and remove) a file if it exists
function backup_file() {
  local readonly file="$1"
  local readonly file_name="$("${DOVE_BASENAME}" "${file}")"
  local readonly backup_file="${DOVE_EXTERNAL}/temp/backup/${file_name}"

  if [[ -f "${file}" ]]; then
    "${DOVE_RM}" -f "${backup_file}"
    "${DOVE_MKDIR}" -p "$("${DOVE_DIRNAME}" "${backup_file}")"
    "${DOVE_CP}" -f "${file}" "${backup_file}"
    "${DOVE_RM}" -f "${file}"
  fi
}

# Back-up (and remove) a directory if it exists
function backup_dir() {
  local readonly dir="$1"
  local readonly dir_name="$("${DOVE_BASENAME}" "${dir}")"
  local readonly backup_dir="${DOVE_EXTERNAL}/temp/backup/${dir_name}"

  if [[ -d "${dir}" ]]; then
    "${DOVE_RM}" -rf "${backup_dir}"
    "${DOVE_MKDIR}" -p "$("${DOVE_DIRNAME}" "${backup_dir}")"
    "${DOVE_CP}" -rf "${dir}/" "${backup_dir}"
    "${DOVE_RM}" -rf "${dir}"
  fi
}

# Restore a backed-up file
function restore_file() {
  local readonly file="$1"
  local readonly file_name="$("${DOVE_BASENAME}" "${file}")"
  local readonly backed_up_file="${DOVE_EXTERNAL}/temp/backup/${file_name}"

  if [[ -f "${backed_up_file}" ]]; then
    "${DOVE_RM}" -f "${file}"
    "${DOVE_MKDIR}" -p "$("${DOVE_DIRNAME}" "${file}")"
    "${DOVE_CP}" -f "${backed_up_file}" "${file}"
    "${DOVE_RM}" -f "${backed_up_file}"
  fi
}

# Restore a backed-up directory
function restore_dir() {
  local readonly dir="$1"
  local readonly dir_name="$("${DOVE_BASENAME}" "${dir}")"
  local readonly backed_up_dir="${DOVE_EXTERNAL}/temp/backup/${dir_name}"

  if [[ -d "${backed_up_dir}" ]]; then
    "${DOVE_RM}" -rf "${dir}"
    "${DOVE_MKDIR}" -p "$("${DOVE_DIRNAME}" "${dir}")"
    "${DOVE_CP}" -rf "${backed_up_dir}/" "${dir}"
    "${DOVE_RM}" -rf "${backed_up_dir}"
  fi
}

# Function to automate updating checksums of dependencies
function update_checksum() {
  local readonly old_checksum="$1"
  local readonly new_checksum="$2"
  local readonly file="$3"
  local readonly checksum_type="$4"

  if [[ "${checksum_type}" == 'md5sum' ]]; then
    local readonly checksum_type_pretty='MD5sum'
  elif [[ "${checksum_type}" == 'sha1sum' ]]; then
    local readonly checksum_type_pretty='SHA1sum'
  elif [[ "${checksum_type}" == 'sha256sum' ]]; then
    local readonly checksum_type_pretty='SHA256sum'
  elif [[ "${checksum_type}" == 'sha512sum' ]]; then
    local readonly checksum_type_pretty='SHA512sum'
  else
    echo_red_text 'ERROR: Unknown checksum type.'
    exit 1
  fi

  if [[ "${old_checksum}" == "${new_checksum}" ]]; then
    echo_red_text 'Checksums match. Skipping...'
    echo "Old checksum: ${old_checksum}"
    echo "New checksum: ${new_checksum}"
  else
    echo_red_text "Updating ${checksum_type_pretty} for ${file}..."
    "${DOVE_SED}" -i "s|'${old_checksum}'|'${new_checksum}'|" "${DOVE_VERSIONS}"
    echo_green_text "SUCCESS: Updated ${checksum_type_pretty} for ${file}"
  fi
}

function validate_checksum() {
  local readonly expected_checksum="$1"
  local readonly file="$2"
  local readonly checksum_type="$3"

  if [[ "${checksum_type}" == 'md5sum' ]]; then
    local readonly checksum_type_pretty='MD5sum'
    local readonly local_checksum=$("${DOVE_MD5SUM}" "${file}" | "${DOVE_AWK}" '{print $1}')
  elif [[ "${checksum_type}" == 'sha1sum' ]]; then
    local readonly checksum_type_pretty='SHA1sum'
    local readonly local_checksum=$("${DOVE_SHA1SUM}" "${file}" | "${DOVE_AWK}" '{print $1}')
  elif [[ "${checksum_type}" == 'sha256sum' ]]; then
    local readonly checksum_type_pretty='SHA256sum'
    local readonly local_checksum=$("${DOVE_SHA256SUM}" "${file}" | "${DOVE_AWK}" '{print $1}')
  elif [[ "${checksum_type}" == 'sha512sum' ]]; then
    local readonly checksum_type_pretty='SHA512sum'
    local readonly local_checksum=$("${DOVE_SHA512SUM}" "${file}" | "${DOVE_AWK}" '{print $1}')
  else
    echo_red_text 'ERROR: Unknown checksum type.'
    return 1
  fi

  if [[ "${DOVE_GET_SOURCE_CHECKSUM_UPDATE}" == 1 ]]; then
    update_checksum "${expected_checksum}" "${local_checksum}" "${file}" "${checksum_type}"
  elif [[ "${local_checksum}" != "${expected_checksum}" ]]; then
    echo_red_text 'ERROR: Checksum validation failed.'
    echo "Expected ${checksum_type_pretty}:   ${expected_checksum}"
    echo "Actual ${checksum_type_pretty}:     ${local_checksum}"

    # If checksum validation fails, also just remove the file
    "${DOVE_RM}" -f "${file}"

    return 1
  else
    echo_green_text 'SUCCESS: Checksum validated.'
    echo "${checksum_type_pretty}: ${local_checksum}"
  fi
}

function clone_repo() {
  local readonly url="$1"
  local readonly path="$2"
  local readonly revision="$3"

  if [[ "${url}" == "" ]]; then
    echo_red_text "ERROR: URL missing for clone"
    exit 1
  fi

  if [[ "${path}" == "" ]]; then
    echo_red_text "ERROR: Path is required for cloning '${url}'"
    exit 1
  fi

  if [[ "${revision}" == "" ]]; then
    echo_red_text "ERROR: Revision is required for cloning '${url}'"
    exit 1
  fi

  if [[ -f "${path}" ]]; then
    echo_red_text "ERROR: '${path}' exists and is not a directory"
    exit 1
  fi

  if [[ -d "${path}" ]]; then
    echo_red_text "'${path}' already exists"
    read -p "Do you want to re-clone this repository? [y/N] " -n 1 -r
    echo
    if [[ "${REPLY}" =~ ^[Yy]$ ]]; then
      echo_red_text "Removing ${path}..."
      "${DOVE_RM}" -rf "${path}"
    else
      return 0
    fi
  fi

  echo_red_text "Cloning ${url}::${revision}..."
  "${DOVE_GIT}" clone --revision="${revision}" --depth=1 "${url}" "${path}"
}

function download() {
  local readonly url="$1"
  local readonly file_in="$2"
  local readonly file_name=$("${DOVE_BASENAME}" "${file_in}")
  local readonly expected_sha512sum="$3"

  # By default, we want to exit upon an error
  if [[ -z "${DOVE_DOWNLOAD_EXIT+x}" ]]; then
    DOVE_DOWNLOAD_EXIT=1
  fi

  # By default, we want to perform post-download actions for sources
  ## (this includes things like ex. installing a dependency or creating/setting-up an environment)
  ## This isn't desired in some cases, like if we're updating checksums, or a user just cancels the download
  unset DOVE_PERFORM_POST_DOWNLOAD
  if [[ "${DOVE_GET_SOURCE_CHECKSUM_UPDATE}" == 1 ]]; then
    ## If we're just updating a checksum, we should never perform post-download actions
    DOVE_PERFORM_POST_DOWNLOAD=0
  else
    DOVE_PERFORM_POST_DOWNLOAD=1
  fi

  if [[ "${url}" == "" ]]; then
    echo_red_text "ERROR: URL is required (file: '${file_in}')"
    DOVE_PERFORM_POST_DOWNLOAD=0
    if [[ "${DOVE_DOWNLOAD_EXIT}" != 1 ]]; then
      unset DOVE_DOWNLOAD_EXIT
      return 1
    else
      exit 1
    fi
  fi

  # If we're doing a checksum update, we download the file to a separate temporary directory, instead of our standard one
  if [[ "${DOVE_GET_SOURCE_CHECKSUM_UPDATE}" == 1 ]]; then
    "${DOVE_RM}" -rf "${DOVE_EXTERNAL}/temp/chksm"
    local readonly file="${DOVE_EXTERNAL}/temp/chksm/${file_name}"
  else
    local readonly file="${file_in}"
  fi

  if [[ -f "${file}" ]]; then
    echo_red_text "${file} already exists."
    read -p "Do you want to re-download? [y/N] " -n 1 -r
    echo
    if [[ "${REPLY}" =~ ^[Yy]$ ]]; then
      # Back-up (in case something goes wrong - ex. checksum validation fails) and remove our file
      echo_red_text "Removing ${file}..."
      backup_file "${file}"
    else
      unset DOVE_DOWNLOAD_EXIT
      DOVE_PERFORM_POST_DOWNLOAD=0
      return 0
    fi
  fi

  # By default, we know nothing has failed...
  local DOVE_CHECKSUM_FAILED=0
  local DOVE_DOWNLOAD_FAILED=0

  if [[ ! -d "$("${DOVE_DIRNAME}" "${file}")" ]]; then
    "${DOVE_MKDIR}" -vp "$("${DOVE_DIRNAME}" "${file}")"
    local readonly CREATED_DIR_FOR_DL=1
  else
    local readonly CREATED_DIR_FOR_DL=0
  fi

  echo_red_text "Downloading ${url}..."
  "${DOVE_CURL}" ${DOVE_CURL_FLAGS} --location "${url}" --output "${file}" || local DOVE_DOWNLOAD_FAILED=1

  # Verify (or update) SHA512sum
  validate_checksum "${expected_sha512sum}" "${file}" 'sha512sum' || local DOVE_CHECKSUM_FAILED=1

  # If we're just updating the checksum, we're done, so go ahead and exit
  if [[ "${DOVE_GET_SOURCE_CHECKSUM_UPDATE}" == 1 ]]; then
    if [[ "${DOVE_DOWNLOAD_FAILED}" == 1 ]]; then
      echo_red_text 'ERROR: Download failed! Exiting...'
      exit 1
    elif [[ "${DOVE_CHECKSUM_FAILED}" == 1 ]]; then
      echo_red_text 'ERROR: Failed to update checksum! Exiting...'
      exit 1
    else
      return 0
    fi
  fi

  # If the download (or checksum validation) failed, restore our back-up
  if [[ "${DOVE_CHECKSUM_FAILED}" == 1 ]] || [[ "${DOVE_DOWNLOAD_FAILED}" == 1 ]]; then
    if [[ -f "${DOVE_EXTERNAL}/temp/backup/${file_name}" ]]; then
      restore_file "${file}"
    fi
  fi

  # Clean-up
  "${DOVE_RM}" -f "${DOVE_EXTERNAL}/temp/backup/${file_name}"
  "${DOVE_RM}" -rf "${DOVE_EXTERNAL}/temp/chksm"

  # If the download (or checksum validation) failed, exit
  if [[ "${DOVE_CHECKSUM_FAILED}" == 1 ]] || [[ "${DOVE_DOWNLOAD_FAILED}" == 1 ]]; then
    # If a directory was created just for this download, remove it
    if [[ "${CREATED_DIR_FOR_DL}" == 1 ]]; then
      "${DOVE_RM}" -rf "$("${DOVE_DIRNAME}" "${file}")"
    fi
    if [[ "${DOVE_DOWNLOAD_EXIT}" != 1 ]]; then
      unset DOVE_DOWNLOAD_EXIT
      return 1
    else
      echo_red_text 'ERROR: Download failed! Exiting...'
      exit 1
    fi
  fi
}

# Extract archives
function extract() {
  local readonly archive_path="$1"
  local readonly target_path="$2"
  local readonly temp_repo_name="$3"

  if [[ ! -f "${archive_path}" ]]; then
    echo_red_text "ERROR: Archive '${archive_path}' does not exist!"
  fi

  # If our temporary directory for extraction already exists, delete it
  if [[ -d "${DOVE_EXTERNAL}/temp/${temp_repo_name}" ]]; then
    "${DOVE_RM}" -rf "${DOVE_EXTERNAL}/temp/${temp_repo_name}"
  fi

  # Create temporary directory for extraction
  "${DOVE_MKDIR}" -p "${DOVE_EXTERNAL}/temp/${temp_repo_name}"

  # Extract based on file extension
  case "${archive_path}" in
    *.zip)
      "${DOVE_UNZIP}" -q "${archive_path}" -d "${DOVE_EXTERNAL}/temp/${temp_repo_name}"
      ;;
    *.tar.gz)
      "${DOVE_TAR}" xzf "${archive_path}" -C "${DOVE_EXTERNAL}/temp/${temp_repo_name}"
      ;;
    *.tar.xz)
      "${DOVE_TAR}" xJf "${archive_path}" -C "${DOVE_EXTERNAL}/temp/${temp_repo_name}"
      ;;
    *.tar.zst)
      "${DOVE_TAR}" --zstd -xvf "${archive_path}" -C "${DOVE_EXTERNAL}/temp/${temp_repo_name}"
      ;;
    *)
      echo_red_text "ERROR: Unsupported archive format: ${archive_path}"
      "${DOVE_RM}" -rf "${DOVE_EXTERNAL}/temp/${temp_repo_name}"
      exit 1
      ;;
  esac

  local readonly top_input_dir=$("${DOVE_LS}" "${DOVE_EXTERNAL}/temp/${temp_repo_name}")
  "${DOVE_CP}" -rf "${DOVE_EXTERNAL}/temp/${temp_repo_name}/${top_input_dir}/" "${target_path}"
  "${DOVE_RM}" -rf "${DOVE_EXTERNAL}/temp/${temp_repo_name}"
}

function download_and_extract() {
  local readonly repo_name="$1"
  local readonly url="$2"
  local readonly path="$3"
  local readonly expected_sha512sum="$4"

  # By default, we want to perform post-download actions for sources
  ## (this includes things like ex. installing a dependency or creating/setting-up an environment)
  ## This isn't desired in some cases, like if we're updating checksums, or a user just cancels the download
  unset DOVE_PERFORM_POST_DOWNLOAD
  if [[ "${DOVE_GET_SOURCE_CHECKSUM_UPDATE}" == 1 ]]; then
    ## If we're just updating a checksum, we should never perform post-download actions
    DOVE_PERFORM_POST_DOWNLOAD=0
  else
    DOVE_PERFORM_POST_DOWNLOAD=1
  fi

  if [[ -d "${path}" ]] && [[ "${DOVE_GET_SOURCE_CHECKSUM_UPDATE}" != 1 ]]; then
    echo_red_text "'${path}' already exists"
    read -p "Do you want to re-download? [y/N] " -n 1 -r
    echo
    if [[ "${REPLY}" =~ ^[Yy]$ ]]; then
      # Back-up (in case something goes wrong - ex. checksum validation fails) and remove our directory
      echo_red_text "Removing ${path}..."
      backup_dir "${path}"
    else
      DOVE_PERFORM_POST_DOWNLOAD=0
      return 0
    fi
  fi

  if [[ "${url}" =~ \.tar\.xz$ ]]; then
    local readonly extension=".tar.xz"
  elif [[ "${url}" =~ \.tar\.gz$ ]]; then
    local readonly extension=".tar.gz"
  elif [[ "${url}" =~ \.tar\.zst$ ]]; then
    local readonly extension=".tar.zst"
  else
    local readonly extension=".zip"
  fi

  # Tell `download` to return instead of exit upon an error
  DOVE_DOWNLOAD_EXIT=0

  # By default, we know the download hasn't failed...
  local DOVE_DOWNLOAD_FAILED=0

  local readonly repo_archive="${DOVE_DOWNLOADS}/${repo_name}${extension}"
  download "${url}" "${repo_archive}" "${expected_sha512sum}" || local DOVE_DOWNLOAD_FAILED=1

  # If we're just updating the checksum, we're done, so go ahead and exit
  if [[ "${DOVE_GET_SOURCE_CHECKSUM_UPDATE}" == 1 ]]; then
    if [[ "${DOVE_DOWNLOAD_FAILED}" == 1 ]]; then
      echo_red_text 'ERROR: Download failed! Exiting...'
      exit 1
    else
      return 0
    fi
  fi

  # If the download failed, restore our back-up (if possible) and exit
  if [[ "${DOVE_DOWNLOAD_FAILED}" == 1 ]]; then
    restore_dir "${path}"
    if [[ "${repo_name}" == 'uv' ]]; then
      DOVE_PERFORM_POST_DOWNLOAD=0
      return 1
    else
      echo_red_text 'ERROR: Download failed! Exiting...'
      exit 1
    fi
  fi

  echo_red_text "Extracting ${repo_archive}..."
  extract "${repo_archive}" "${path}" "${repo_name}"

  # Clean-up
  "${DOVE_RM}" -rf "${DOVE_EXTERNAL}/temp/backup/${repo_name}"
}

# Get Thunderbird's Autoconfiguration Database (ISPDB)
function get_autoconfig() {
  echo_red_text 'Downloading Thunderbird Autoconfiguration Database (ISPDB)...'
  download_and_extract 'autoconfig' "https://github.com/thunderbird/autoconfig/archive/${DOVE_AUTOCONFIG_COMMIT}.tar.gz" "${DOVE_AUTOCONFIG}" "${DOVE_AUTOCONFIG_SHA512SUM}"
  if [[ "${DOVE_PERFORM_POST_DOWNLOAD}" == 1 ]]; then
    echo_green_text "SUCCESS: Set-up Thunderbird Autoconfiguration Database (ISPDB) at ${DOVE_AUTOCONFIG}"
  fi
}

# Get lxml
function get_lxml() {
  # If all we're doing is updating the checksum, we don't care if the environment is prepared
  if [[ "${DOVE_GET_SOURCE_CHECKSUM_UPDATE}" != 1 ]]; then
    if  [[ ! -d "${DOVE_UV_DIR}" ]] || [[ ! -f "${DOVE_PYENV}" ]]; then
      echo_red_text "ERROR: You tried to download lxml, but you don't have a Python environment set-up yet."
      exit 1
    fi
  fi

  echo_red_text "Downloading lxml..."
  download_and_extract 'lxml' "https://github.com/lxml/lxml/archive/${DOVE_LXML_COMMIT}.tar.gz" "${DOVE_LXML}" "${DOVE_LXML_SHA512SUM}"

  if [[ "${DOVE_PERFORM_POST_DOWNLOAD}" == 1 ]]; then
    source "${DOVE_PYENV}"
    echo_red_text 'Installing lxml...'
    "${DOVE_UV}" pip install --no-editable --strict "${DOVE_LXML}"
    echo_green_text 'SUCCESS: Set-up lxml'
  fi
}

# Get Phoenix
function get_phoenix() {
  echo_red_text 'Downloading Phoenix...'
  download_and_extract 'phoenix' "https://gitlab.com/celenityy/Phoenix/-/archive/${DOVE_PHOENIX_COMMIT}/Phoenix-${DOVE_PHOENIX_COMMIT}.tar.gz" "${DOVE_PHOENIX}" "${DOVE_PHOENIX_SHA512SUM}"
  if [[ "${DOVE_PERFORM_POST_DOWNLOAD}" == 1 ]]; then
    echo_green_text "SUCCESS: Set-up Phoenix at ${DOVE_PHOENIX}"
  fi
}

# Get Python
function get_python() {
  # If all we're doing is updating the checksum, we don't care about existing installations
  if [[ "${DOVE_GET_SOURCE_CHECKSUM_UPDATE}" != 1 ]]; then
    if [[ ! -x "${DOVE_UV}" ]]; then
      echo_red_text "ERROR: You tried to download Python, but you're missing uv!"
      exit 1
    fi

    if [[ -d "${DOVE_PYENV_DIR}" ]]; then
      echo_red_text "The Python environment is already set-up at ${DOVE_PYENV_DIR}"
      read -p "Do you want to re-create it? [y/N] " -n 1 -r
      echo
      if [[ "${REPLY}" =~ ^[Yy]$ ]]; then
        # Back-up (in case something goes wrong - ex. checksum validation fails) and remove our directory
        backup_dir "${DOVE_PYENV_DIR}"
      fi
    fi

    if [[ -d "${DOVE_PYTHON_DIR}" ]]; then
      echo_red_text "Found existing installation at ${DOVE_PYTHON_DIR}"
      echo 'Continuing will remove this installation and related data'
      read -p "Do you still want to continue? [y/N] " -n 1 -r
      echo
      if [[ "${REPLY}" =~ ^[Yy]$ ]]; then
        # Back-up (in case something goes wrong - ex. checksum validation fails) and remove our directories
        backup_dir "${DOVE_PYENV_DIR}"
        backup_dir "${DOVE_PYTHON_DIR}"
        backup_dir "${DOVE_UV_CACHE}"
        backup_dir "${DOVE_UV_LOCAL}/python-cache"
        backup_dir "${DOVE_UV_PYTHON}"
      else
        return 0
      fi
    fi
  fi

  if [[ "${DOVE_GET_SOURCE_CHECKSUM_UPDATE}" == 1 ]]; then
    echo_red_text 'Downloading Python (Linux - ARM64)...'
    download "https://github.com/astral-sh/python-build-standalone/releases/download/${DOVE_PYTHON_GIT_RELEASE}/cpython-${DOVE_PYTHON_VERSION}+${DOVE_PYTHON_GIT_RELEASE}-aarch64-unknown-linux-gnu-install_only_stripped.tar.gz" "${DOVE_PYTHON_DIR}/${DOVE_PYTHON_GIT_RELEASE}/cpython-${DOVE_PYTHON_VERSION}+${DOVE_PYTHON_GIT_RELEASE}-aarch64-unknown-linux-gnu-install_only_stripped.tar.gz" "${DOVE_PYTHON_SHA512SUM_LINUX_ARM64}"

    echo_red_text 'Downloading Python (Linux - x86_64)...'
    download "https://github.com/astral-sh/python-build-standalone/releases/download/${DOVE_PYTHON_GIT_RELEASE}/cpython-${DOVE_PYTHON_VERSION}+${DOVE_PYTHON_GIT_RELEASE}-x86_64-unknown-linux-gnu-install_only_stripped.tar.gz" "${DOVE_PYTHON_DIR}/${DOVE_PYTHON_GIT_RELEASE}/cpython-${DOVE_PYTHON_VERSION}+${DOVE_PYTHON_GIT_RELEASE}-x86_64-unknown-linux-gnu-install_only_stripped.tar.gz" "${DOVE_PYTHON_SHA512SUM_LINUX_X86_64}"

    echo_red_text 'Downloading Python (OS X - ARM64)...'
    download "https://github.com/astral-sh/python-build-standalone/releases/download/${DOVE_PYTHON_GIT_RELEASE}/cpython-${DOVE_PYTHON_VERSION}+${DOVE_PYTHON_GIT_RELEASE}-aarch64-apple-darwin-install_only_stripped.tar.gz" "${DOVE_PYTHON_DIR}/${DOVE_PYTHON_GIT_RELEASE}/cpython-${DOVE_PYTHON_VERSION}+${DOVE_PYTHON_GIT_RELEASE}-aarch64-apple-darwin-install_only_stripped.tar.gz" "${DOVE_PYTHON_SHA512SUM_OSX_ARM64}"

    echo_red_text 'Downloading Python (OS X - x86_64)...'
    download "https://github.com/astral-sh/python-build-standalone/releases/download/${DOVE_PYTHON_GIT_RELEASE}/cpython-${DOVE_PYTHON_VERSION}+${DOVE_PYTHON_GIT_RELEASE}-x86_64-apple-darwin-install_only_stripped.tar.gz" "${DOVE_PYTHON_DIR}/${DOVE_PYTHON_GIT_RELEASE}/cpython-${DOVE_PYTHON_VERSION}+${DOVE_PYTHON_GIT_RELEASE}-x86_64-apple-darwin-install_only_stripped.tar.gz" "${DOVE_PYTHON_SHA512SUM_OSX_X86_64}"
  else
    # Set our platform
    if [[ "${DOVE_PLATFORM}" == 'darwin' ]]; then
      local readonly DOVE_PYTHON_PLATFORM='apple-darwin'
    else
      local readonly DOVE_PYTHON_PLATFORM='unknown-linux-gnu'
    fi

    # Set our platform architecture
    if [[ "${DOVE_PLATFORM_ARCH}" == 'arm64' ]]; then
      local readonly DOVE_PYTHON_ARCH='aarch64'
    else
      local readonly DOVE_PYTHON_ARCH='x86_64'
    fi

    # Set our checksum to verify
    if [[ "${DOVE_PLATFORM_ARCH}" == 'arm64' ]]; then
      if [[ "${DOVE_PLATFORM}" == 'darwin' ]]; then
        local readonly DOVE_PYTHON_SHA512SUM="${DOVE_PYTHON_SHA512SUM_OSX_ARM64}"
      else
        local readonly DOVE_PYTHON_SHA512SUM="${DOVE_PYTHON_SHA512SUM_LINUX_ARM64}"
      fi
    else
      if [[ "${DOVE_PLATFORM}" == 'darwin' ]]; then
        local readonly DOVE_PYTHON_SHA512SUM="${DOVE_PYTHON_SHA512SUM_OSX_X86_64}"
      else
        local readonly DOVE_PYTHON_SHA512SUM="${DOVE_PYTHON_SHA512SUM_LINUX_X86_64}"
      fi
    fi

    # Tell `download` to return instead of exit upon an error
    DOVE_DOWNLOAD_EXIT=0

    # By default, we know nothing has failed...
    local DOVE_DOWNLOAD_FAILED=0
    local DOVE_PYENV_FAILED=0
    local DOVE_PYTHON_INSTALL_FAILED=0

    echo_red_text 'Downloading Python...'
    download "https://github.com/astral-sh/python-build-standalone/releases/download/${DOVE_PYTHON_GIT_RELEASE}/cpython-${DOVE_PYTHON_VERSION}+${DOVE_PYTHON_GIT_RELEASE}-${DOVE_PYTHON_ARCH}-${DOVE_PYTHON_PLATFORM}-install_only_stripped.tar.gz" "${DOVE_PYTHON_DIR}/${DOVE_PYTHON_GIT_RELEASE}/cpython-${DOVE_PYTHON_VERSION}+${DOVE_PYTHON_GIT_RELEASE}-${DOVE_PYTHON_ARCH}-${DOVE_PYTHON_PLATFORM}-install_only_stripped.tar.gz" "${DOVE_PYTHON_SHA512SUM}" || local DOVE_DOWNLOAD_FAILED=1

    # If the download failed, restore our back-ups, clean-up, and exit
    if [[ "${DOVE_DOWNLOAD_FAILED}" == 1 ]]; then
      restore_dir "${DOVE_PYENV_DIR}"
      restore_dir "${DOVE_PYTHON_DIR}"
      restore_dir "${DOVE_UV_CACHE}"
      restore_dir "${DOVE_UV_PYTHON}"
      restore_dir "${DOVE_UV_LOCAL}/python-cache"
      "${DOVE_RM}" -rf "${DOVE_EXTERNAL}/temp"
      exit 1
    elif [[ "${DOVE_PERFORM_POST_DOWNLOAD}" == 1 ]]; then
      echo_green_text "SUCCESS: Downloaded Python to ${DOVE_PYTHON_DIR}/${DOVE_PYTHON_GIT_RELEASE}/cpython-${DOVE_PYTHON_VERSION}+${DOVE_PYTHON_GIT_RELEASE}-${DOVE_PYTHON_ARCH}-${DOVE_PYTHON_PLATFORM}-install_only_stripped.tar.gz"

      echo_red_text 'Installing Python...'
      "${DOVE_UV}" python install "${DOVE_PYTHON_VERSION}" || local DOVE_PYTHON_INSTALL_FAILED=1

      # If the install failed, restore our back-ups, clean-up, and exit
      if [[ "${DOVE_PYTHON_INSTALL_FAILED}" == 1 ]]; then
        restore_dir "${DOVE_PYENV_DIR}"
        restore_dir "${DOVE_PYTHON_DIR}"
        restore_dir "${DOVE_UV_CACHE}"
        restore_dir "${DOVE_UV_PYTHON}"
        restore_dir "${DOVE_UV_LOCAL}/python-cache"
        "${DOVE_RM}" -rf "${DOVE_EXTERNAL}/temp"
        exit 1
      fi

      echo_red_text 'Creating Python environment...'
      "${DOVE_UV}" venv "${DOVE_PYENV_DIR}" || local DOVE_PYENV_FAILED=1

      # If the Python env set-up failed, restore our back-up, clean-up, and exit
      if [[ "${DOVE_PYENV_FAILED}" == 1 ]]; then
        echo_red_text 'ERROR: Download failed! Exiting...'
        restore_dir "${DOVE_PYENV_DIR}"
        "${DOVE_RM}" -rf "${DOVE_EXTERNAL}/temp"
        exit 1
      else
        echo_green_text "SUCCESS: Set-up Python environment at ${DOVE_PYENV_DIR}"
      fi
    fi
  fi
}

# Get s3cmd
function get_s3cmd() {
  # If all we're doing is updating the checksum, we don't care if the environment is prepared
  if [[ "${DOVE_GET_SOURCE_CHECKSUM_UPDATE}" != 1 ]]; then
    if  [[ ! -d "${DOVE_UV_DIR}" ]] || [[ ! -f "${DOVE_PYENV}" ]]; then
      echo_red_text "ERROR: You tried to download s3cmd, but you don't have a Python environment set-up yet."
      exit 1
    fi

    if [[ -d "${DOVE_PYENV_DIR}/bin/s3cmd" ]]; then
      echo_red_text "s3cmd is already installed at ${DOVE_PYENV_DIR}/bin/s3cmd"
      read -p "Do you want to re-download it? [y/N] " -n 1 -r
      echo
      if [[ "${REPLY}" =~ ^[Nn]$ ]]; then
        return 0
      else
        source "${DOVE_PYENV}"
        "${DOVE_UV}" pip uninstall s3cmd
      fi
    fi
  fi

  echo_red_text "Downloading s3cmd..."
  download_and_extract 's3cmd' "https://github.com/s3tools/s3cmd/archive/${DOVE_S3CMD_COMMIT}.tar.gz" "${DOVE_S3CMD_DIR}" "${DOVE_S3CMD_SHA512SUM}"

  if [[ "${DOVE_PERFORM_POST_DOWNLOAD}" == 1 ]]; then
    source "${DOVE_PYENV}"
    echo_red_text 'Installing s3cmd...'
    "${DOVE_UV}" pip install --no-editable --strict "${DOVE_S3CMD_DIR}"
    echo_green_text "SUCCESS: Set-up s3cmd at ${DOVE_S3CMD}"
  fi
}

# Get + set-up uv
function get_uv() {
  # If all we're doing is updating the checksum, we don't care about existing installations
  if [[ "${DOVE_GET_SOURCE_CHECKSUM_UPDATE}" != 1 ]] && [[ -d "${DOVE_UV_DIR}" ]]; then
    echo_red_text "Found existing installation at ${DOVE_UV_DIR}"
    echo 'Continuing will remove this installation and related data'
    read -p "Do you still want to continue? [y/N] " -n 1 -r
    echo
    if [[ "${REPLY}" =~ ^[Yy]$ ]]; then
      # Back-up (in case something goes wrong - ex. checksum validation fails) and remove our directories
      backup_dir "${DOVE_UV_DIR}"
      backup_dir "${DOVE_UV_LOCAL}"
    else
      return 0
    fi
  fi

  if [[ "${DOVE_GET_SOURCE_CHECKSUM_UPDATE}" == 1 ]]; then
    echo_red_text 'Downloading uv (Linux - ARM64)...'
    download "https://github.com/astral-sh/uv/releases/download/${DOVE_UV_VERSION}/uv-aarch64-unknown-linux-gnu.tar.gz" "${DOVE_EXTERNAL}/temp/uv-checksum-update-linux-arm64.tar.gz" "${DOVE_UV_SHA512SUM_LINUX_ARM64}"

    echo_red_text 'Downloading uv (Linux - x86_64)...'
    download "https://github.com/astral-sh/uv/releases/download/${DOVE_UV_VERSION}/uv-x86_64-unknown-linux-gnu.tar.gz" "${DOVE_EXTERNAL}/temp/uv-checksum-update-linux-x86_64.tar.gz" "${DOVE_UV_SHA512SUM_LINUX_X86_64}"

    echo_red_text 'Downloading uv (OS X - ARM64)...'
    download "https://github.com/astral-sh/uv/releases/download/${DOVE_UV_VERSION}/uv-aarch64-apple-darwin.tar.gz" "${DOVE_EXTERNAL}/temp/uv-checksum-update-osx-arm64.tar.gz" "${DOVE_UV_SHA512SUM_OSX_ARM64}"

    echo_red_text 'Downloading uv (OS X - x86_64)...'
    download "https://github.com/astral-sh/uv/releases/download/${DOVE_UV_VERSION}/uv-x86_64-apple-darwin.tar.gz" "${DOVE_EXTERNAL}/temp/uv-checksum-update-osx-x86_64.tar.gz" "${DOVE_UV_SHA512SUM_OSX_X86_64}"
  else
    # Set our platform
    if [[ "${DOVE_PLATFORM}" == 'darwin' ]]; then
      local readonly DOVE_UV_PLATFORM='apple-darwin'
    else
      local readonly DOVE_UV_PLATFORM='unknown-linux-gnu'
    fi

    # Set our platform architecture
    if [[ "${DOVE_PLATFORM_ARCH}" == 'arm64' ]]; then
      local readonly DOVE_UV_ARCH='aarch64'
    else
      local readonly DOVE_UV_ARCH='x86_64'
    fi

    # Set our checksum to verify
    if [[ "${DOVE_PLATFORM_ARCH}" == 'arm64' ]]; then
      if [[ "${DOVE_PLATFORM}" == 'darwin' ]]; then
        local readonly DOVE_UV_SHA512SUM="${DOVE_UV_SHA512SUM_OSX_ARM64}"
      else
        local readonly DOVE_UV_SHA512SUM="${DOVE_UV_SHA512SUM_LINUX_ARM64}"
      fi
    else
      if [[ "${DOVE_PLATFORM}" == 'darwin' ]]; then
        local readonly DOVE_UV_SHA512SUM="${DOVE_UV_SHA512SUM_OSX_X86_64}"
      else
        local readonly DOVE_UV_SHA512SUM="${DOVE_UV_SHA512SUM_LINUX_X86_64}"
      fi
    fi

    # Tell `download` to return instead of exit upon an error
    DOVE_DOWNLOAD_EXIT=0

    # By default, we know the download hasn't failed...
    local DOVE_DOWNLOAD_FAILED=0

    echo_red_text 'Downloading uv...'
    download_and_extract 'uv' "https://github.com/astral-sh/uv/releases/download/${DOVE_UV_VERSION}/uv-${DOVE_UV_ARCH}-${DOVE_UV_PLATFORM}.tar.gz" "${DOVE_UV_DIR}" "${DOVE_UV_SHA512SUM}" || local DOVE_DOWNLOAD_FAILED=1

    # If the download failed, restore our back-up, clean-up, and exit
    if [[ "${DOVE_DOWNLOAD_FAILED}" == 1 ]]; then
      echo_red_text 'ERROR: Download failed! Exiting...'
      restore_dir "${DOVE_UV_DIR}"
      restore_dir "${DOVE_UV_LOCAL}"
      "${DOVE_RM}" -rf "${DOVE_EXTERNAL}/temp"
      exit 1
    elif [[ "${DOVE_PERFORM_POST_DOWNLOAD}" == 1 ]]; then
      echo_green_text "SUCCESS: Set-up uv at ${DOVE_UV}"
    fi
  fi
}

# Clean-up
"${DOVE_RM}" -rf "${DOVE_DOWNLOADS}"
"${DOVE_RM}" -rf "${DOVE_EXTERNAL}/temp"

if [[ "${DOVE_GET_SOURCE_AUTOCONFIG}" == 1 ]]; then
  get_autoconfig
fi

# These need to run before we get lxml and s3cmd
if [[ "${DOVE_GET_SOURCE_UV}" == 1 ]]; then
  get_uv
fi

if [[ "${DOVE_GET_SOURCE_PYTHON}" == 1 ]]; then
  get_python
fi

if [[ "${DOVE_GET_SOURCE_LXML}" == 1 ]]; then
  get_lxml
fi

if [[ "${DOVE_GET_SOURCE_PHOENIX}" == 1 ]]; then
  get_phoenix
fi

if [[ "${DOVE_GET_SOURCE_S3CMD}" == 1 ]]; then
  get_s3cmd
fi
