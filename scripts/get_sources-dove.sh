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

# Function to automate updating SHA512sums of dependencies
function update_sha512sum() {
    local readonly old_sha512sum="$1"
    local readonly new_sha512sum="$2"
    local readonly file="$3"

    if [[ "${old_sha512sum}" == "${AUTOCONFIG_SHA512SUM}" ]]; then
        echo_red_text 'Updating SHA512sum for Thunderbird Autoconfiguration Database...'
        "${DOVE_SED}" -i -e "s|AUTOCONFIG_SHA512SUM='.*'|AUTOCONFIG_SHA512SUM='"${new_sha512sum}"'|g" "${DOVE_VERSIONS}"
        echo_green_text 'SUCCESS: Updated SHA512sum for Thunderbird Autoconfiguration Database'
    elif [[ "${old_sha512sum}" == "${LXML_SHA512SUM}" ]]; then
        echo_red_text 'Updating SHA512sum for lxml...'
        "${DOVE_SED}" -i -e "s|LXML_SHA512SUM='.*'|LXML_SHA512SUM='"${new_sha512sum}"'|g" "${DOVE_VERSIONS}"
        echo_green_text 'SUCCESS: Updated SHA512sum for lxml'
    elif [[ "${old_sha512sum}" == "${PHOENIX_SHA512SUM}" ]]; then
        echo_red_text 'Updating SHA512sum for Phoenix...'
        "${DOVE_SED}" -i -e "s|PHOENIX_SHA512SUM='.*'|PHOENIX_SHA512SUM='"${new_sha512sum}"'|g" "${DOVE_VERSIONS}"
        echo_green_text 'SUCCESS: Updated SHA512sum for Phoenix'
    elif [[ "${old_sha512sum}" == "${PYTHON_SHA512SUM_LINUX_ARM64}" ]]; then
        echo_red_text 'Updating SHA512sum for Python (Linux - ARM64)...'
        "${DOVE_SED}" -i -e "s|PYTHON_SHA512SUM_LINUX_ARM64='.*'|PYTHON_SHA512SUM_LINUX_ARM64='"${new_sha512sum}"'|g" "${DOVE_VERSIONS}"
        echo_green_text 'SUCCESS: Updated SHA512sum for Python (Linux - ARM64)'
    elif [[ "${old_sha512sum}" == "${PYTHON_SHA512SUM_LINUX_X86_64}" ]]; then
        echo_red_text 'Updating SHA512sum for Python (Linux - x86_64)...'
        "${DOVE_SED}" -i -e "s|PYTHON_SHA512SUM_LINUX_X86_64='.*'|PYTHON_SHA512SUM_LINUX_X86_64='"${new_sha512sum}"'|g" "${DOVE_VERSIONS}"
        echo_green_text 'SUCCESS: Updated SHA512sum for Python (Linux - x86_64)'
    elif [[ "${old_sha512sum}" == "${PYTHON_SHA512SUM_OSX_ARM64}" ]]; then
        echo_red_text 'Updating SHA512sum for Python (OS X - ARM64)...'
        "${DOVE_SED}" -i -e "s|PYTHON_SHA512SUM_OSX_ARM64='.*'|PYTHON_SHA512SUM_OSX_ARM64='"${new_sha512sum}"'|g" "${DOVE_VERSIONS}"
        echo_green_text 'SUCCESS: Updated SHA512sum for Python (OS X - ARM64)'
    elif [[ "${old_sha512sum}" == "${PYTHON_SHA512SUM_OSX_X86_64}" ]]; then
        echo_red_text 'Updating SHA512sum for Python (OS X - x86_64)...'
        "${DOVE_SED}" -i -e "s|PYTHON_SHA512SUM_OSX_X86_64='.*'|PYTHON_SHA512SUM_OSX_X86_64='"${new_sha512sum}"'|g" "${DOVE_VERSIONS}"
        echo_green_text 'SUCCESS: Updated SHA512sum for Python (OS X - x86_64)'
    elif [[ "${old_sha512sum}" == "${S3CMD_SHA512SUM}" ]]; then
        echo_red_text 'Updating SHA512sum for s3cmd...'
        "${DOVE_SED}" -i -e "s|S3CMD_SHA512SUM='.*'|S3CMD_SHA512SUM='"${new_sha512sum}"'|g" "${DOVE_VERSIONS}"
        echo_green_text 'SUCCESS: Updated SHA512sum for s3cmd'
    elif [[ "${old_sha512sum}" == "${UV_SHA512SUM_LINUX_ARM64}" ]]; then
        echo_red_text 'Updating SHA512sum for uv (Linux - ARM64)...'
        "${DOVE_SED}" -i -e "s|UV_SHA512SUM_LINUX_ARM64='.*'|UV_SHA512SUM_LINUX_ARM64='"${new_sha512sum}"'|g" "${DOVE_VERSIONS}"
        echo_green_text 'SUCCESS: Updated SHA512sum for uv (Linux - ARM64)'
    elif [[ "${old_sha512sum}" == "${UV_SHA512SUM_LINUX_X86_64}" ]]; then
        echo_red_text 'Updating SHA512sum for uv (Linux - x86_64)...'
        "${DOVE_SED}" -i -e "s|UV_SHA512SUM_LINUX_X86_64='.*'|UV_SHA512SUM_LINUX_X86_64='"${new_sha512sum}"'|g" "${DOVE_VERSIONS}"
        echo_green_text 'SUCCESS: Updated SHA512sum for uv (Linux - x86_64)'
    elif [[ "${old_sha512sum}" == "${UV_SHA512SUM_OSX_ARM64}" ]]; then
        echo_red_text 'Updating SHA512sum for uv (OS X - ARM64)...'
        "${DOVE_SED}" -i -e "s|UV_SHA512SUM_OSX_ARM64='.*'|UV_SHA512SUM_OSX_ARM64='"${new_sha512sum}"'|g" "${DOVE_VERSIONS}"
        echo_green_text 'SUCCESS: Updated SHA512sum for uv (OS X - ARM64)'
    elif [[ "${old_sha512sum}" == "${UV_SHA512SUM_OSX_X86_64}" ]]; then
        echo_red_text 'Updating SHA512sum for uv (OS X - x86_64)...'
        "${DOVE_SED}" -i -e "s|UV_SHA512SUM_OSX_X86_64='.*'|UV_SHA512SUM_OSX_X86_64='"${new_sha512sum}"'|g" "${DOVE_VERSIONS}"
        echo_green_text 'SUCCESS: Updated SHA512sum for uv (OS X - x86_64)'
    fi

    rm "${file}"
}

function validate_sha512sum() {
    local readonly expected_sha512sum="$1"
    local readonly file="$2"

    local readonly local_sha512sum=$(sha512sum "${file}" | "${DOVE_AWK}" '{print $1}')

    if [[ "${DOVE_GET_SOURCE_CHECKSUM_UPDATE}" == 1 ]]; then
        update_sha512sum "${expected_sha512sum}" "${local_sha512sum}" "${file}"
    elif [[ "${local_sha512sum}" != "${expected_sha512sum}" ]]; then
        echo_red_text 'ERROR: Checksum validation failed.'
        echo "Expected SHA512sum:   ${expected_sha512sum}"
        echo "Actual SHA512sum:     ${local_sha512sum}"

        # If checksum validation fails, also just remove the file
        rm -f "${file}"

        exit 1
    else
        echo_green_text 'SUCCESS: Checksum validated.'
        echo "SHA512sum: ${local_sha512sum}"
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
            rm -rf "${path}"
        else
            return 0
        fi
    fi

    echo_red_text "Cloning ${url}::${revision}..."
    git clone --revision="${revision}" --depth=1 "${url}" "${path}"
}

function download() {
    local readonly url="$1"
    local readonly filepath="$2"

    if [[ "${url}" == "" ]]; then
        echo_red_text "ERROR: URL is required (file: '${filepath}')"
        exit 1
    fi

    if [[ -f "${filepath}" ]]; then
        echo_red_text "${filepath} already exists."
        read -p "Do you want to re-download? [y/N] " -n 1 -r
        echo
        if [[ "${REPLY}" =~ ^[Yy]$ ]]; then
            echo_red_text "Removing ${filepath}..."
            rm -f "${filepath}"
        else
            return 0
        fi
    fi

    mkdir -vp "$(dirname "${filepath}")"

    echo_red_text "Downloading ${url}..."
    curl ${DOVE_CURL_FLAGS} -sSL "${url}" -o "${filepath}"
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
        rm -rf "${DOVE_EXTERNAL}/temp/${temp_repo_name}"
    fi

    # Create temporary directory for extraction
    mkdir -p "${DOVE_EXTERNAL}/temp/${temp_repo_name}"

    # Extract based on file extension
    case "${archive_path}" in
        *.zip)
            unzip -q "${archive_path}" -d "${DOVE_EXTERNAL}/temp/${temp_repo_name}"
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
            rm -rf "${DOVE_EXTERNAL}/temp/${temp_repo_name}"
            exit 1
            ;;
    esac

    local readonly top_input_dir=$(ls "${DOVE_EXTERNAL}/temp/${temp_repo_name}")
    cp -rf "${DOVE_EXTERNAL}/temp/${temp_repo_name}/${top_input_dir}"/ "${target_path}"
    rm -rf "${DOVE_EXTERNAL}/temp/${temp_repo_name}"
}

function download_and_extract() {
    local readonly repo_name="$1"
    local readonly url="$2"
    local readonly path="$3"
    local readonly expected_sha512sum="$4"

    if [[ -d "${path}" ]]; then
        echo_red_text "'${path}' already exists"
        read -p "Do you want to re-download? [y/N] " -n 1 -r
        echo
        if [[ "${REPLY}" =~ ^[Yy]$ ]]; then
            echo_red_text "Removing ${path}..."
            rm -rf "${path}"
        else
            return 0
        fi
    fi

    local readonly extension
    if [[ "${url}" =~ \.tar\.xz$ ]]; then
        local readonly extension=".tar.xz"
    elif [[ "${url}" =~ \.tar\.gz$ ]]; then
        local readonly extension=".tar.gz"
    elif [[ "${url}" =~ \.tar\.zst$ ]]; then
        local readonly extension=".tar.zst"
    else
        local readonly extension=".zip"
    fi

    local readonly repo_archive="${DOVE_DOWNLOADS}/${repo_name}${extension}"

    download "${url}" "${repo_archive}"

    if [[ ! -f "${repo_archive}" ]]; then
        echo_red_text "ERROR: Source archive for ${repo_name} does not exist."
        exit 1
    fi

    # Before extracting, verify SHA512sum...
    validate_sha512sum "${expected_sha512sum}" "${repo_archive}"

    if [[ "${DOVE_GET_SOURCE_CHECKSUM_UPDATE}" != 1 ]]; then
        echo_red_text "Extracting ${repo_archive}..."
        extract "${repo_archive}" "${path}" "${repo_name}"
        echo
    fi
}

# Get Thunderbird's Autoconfiguration Database (ISPDB)
function get_autoconfig() {
    echo_red_text 'Downloading Thunderbird Autoconfiguration Database (ISPDB)...'
    download_and_extract 'autoconfig' "https://github.com/thunderbird/autoconfig/archive/${AUTOCONFIG_COMMIT}.tar.gz" "${DOVE_AUTOCONFIG}" "${AUTOCONFIG_SHA512SUM}"
    if [[ "${DOVE_GET_SOURCE_CHECKSUM_UPDATE}" != 1 ]]; then
        echo_green_text "SUCCESS: Set-up Thunderbird Autoconfiguration Database (ISPDB) at ${DOVE_AUTOCONFIG}"
    fi
}

# Get lxml
function get_lxml() {
    # If all we're doing is updating the checksum, we don't care if the environment is prepared
    if [[ "${DOVE_GET_SOURCE_CHECKSUM_UPDATE}" != 1 ]]; then
        if  [[ ! -d "${DOVE_UV_DIR}" ]] || [[ ! -f "${DOVE_PYENV}" ]]; then
            echo_red_text "ERROR: You tried to download lxml, but you don't have a uv environment set-up yet."
            exit 1
        fi
    fi

    echo_red_text "Downloading lxml..."
    download_and_extract 'lxml' "https://github.com/lxml/lxml/archive/${LXML_COMMIT}.tar.gz" "${DOVE_LXML}" "${LXML_SHA512SUM}"

    if [[ "${DOVE_GET_SOURCE_CHECKSUM_UPDATE}" != 1 ]]; then
        source "${DOVE_PYENV}"
        echo_red_text 'Installing lxml...'
        "${DOVE_UV}" pip install --no-editable --strict "${DOVE_LXML}"
        echo_green_text 'SUCCESS: Set-up lxml'
    fi
}

# Get Phoenix
function get_phoenix() {
    echo_red_text 'Downloading Phoenix...'
    download_and_extract 'phoenix' "https://gitlab.com/celenityy/Phoenix/-/archive/${PHOENIX_COMMIT}/Phoenix-${PHOENIX_COMMIT}.tar.gz" "${DOVE_PHOENIX}" "${PHOENIX_SHA512SUM}"
    if [[ "${DOVE_GET_SOURCE_CHECKSUM_UPDATE}" != 1 ]]; then
        echo_green_text "SUCCESS: Set-up Phoenix at ${DOVE_PHOENIX}"
    fi
}

# Get Python
function get_python() {
    # Set our platform
    if [[ "${DOVE_PLATFORM}" == 'darwin' ]]; then
        local readonly PYTHON_PLATFORM='apple-darwin'
    else
        local readonly PYTHON_PLATFORM='unknown-linux-gnu'
    fi

    # Set our platform architecture
    if [[ "${DOVE_PLATFORM_ARCH}" == 'arm64' ]]; then
        local readonly PYTHON_ARCH='aarch64'
    else
        local readonly PYTHON_ARCH='x86_64'
    fi

    # Set our checksum to verify
    if [[ "${DOVE_PLATFORM_ARCH}" == 'arm64' ]]; then
        if [[ "${DOVE_PLATFORM}" == 'darwin' ]]; then
            local readonly PYTHON_SHA512SUM="${PYTHON_SHA512SUM_OSX_ARM64}"
        else
            local readonly PYTHON_SHA512SUM="${PYTHON_SHA512SUM_LINUX_ARM64}"
        fi
    else
        if [[ "${DOVE_PLATFORM}" == 'darwin' ]]; then
            local readonly PYTHON_SHA512SUM="${PYTHON_SHA512SUM_OSX_X86_64}"
        else
            local readonly PYTHON_SHA512SUM="${PYTHON_SHA512SUM_LINUX_X86_64}"
        fi
    fi

    if [[ "${DOVE_GET_SOURCE_CHECKSUM_UPDATE}" == 1 ]]; then
        echo_red_text 'Downloading Python (Linux - ARM64)...'
        download "https://github.com/astral-sh/python-build-standalone/releases/download/${PYTHON_GIT_RELEASE}/cpython-${PYTHON_VERSION}+${PYTHON_GIT_RELEASE}-aarch64-unknown-linux-gnu-install_only_stripped.tar.gz" "${DOVE_PYTHON_DIR}/${PYTHON_GIT_RELEASE}/cpython-${PYTHON_VERSION}+${PYTHON_GIT_RELEASE}-aarch64-unknown-linux-gnu-install_only_stripped.tar.gz"

        # "Validate" (Update) SHA512sum
        validate_sha512sum "${PYTHON_SHA512SUM_LINUX_ARM64}" "${DOVE_PYTHON_DIR}/${PYTHON_GIT_RELEASE}/cpython-${PYTHON_VERSION}+${PYTHON_GIT_RELEASE}-aarch64-unknown-linux-gnu-install_only_stripped.tar.gz"

        echo_red_text 'Downloading Python (Linux - x86_64)...'
        download "https://github.com/astral-sh/python-build-standalone/releases/download/${PYTHON_GIT_RELEASE}/cpython-${PYTHON_VERSION}+${PYTHON_GIT_RELEASE}-x86_64-unknown-linux-gnu-install_only_stripped.tar.gz" "${DOVE_PYTHON_DIR}/${PYTHON_GIT_RELEASE}/cpython-${PYTHON_VERSION}+${PYTHON_GIT_RELEASE}-x86_64-unknown-linux-gnu-install_only_stripped.tar.gz"

        # "Validate" (Update) SHA512sum
        validate_sha512sum "${PYTHON_SHA512SUM_LINUX_X86_64}" "${DOVE_PYTHON_DIR}/${PYTHON_GIT_RELEASE}/cpython-${PYTHON_VERSION}+${PYTHON_GIT_RELEASE}-x86_64-unknown-linux-gnu-install_only_stripped.tar.gz"

        echo_red_text 'Downloading Python (OS X - ARM64)...'
        download "https://github.com/astral-sh/python-build-standalone/releases/download/${PYTHON_GIT_RELEASE}/cpython-${PYTHON_VERSION}+${PYTHON_GIT_RELEASE}-aarch64-apple-darwin-install_only_stripped.tar.gz" "${DOVE_PYTHON_DIR}/${PYTHON_GIT_RELEASE}/cpython-${PYTHON_VERSION}+${PYTHON_GIT_RELEASE}-aarch64-apple-darwin-install_only_stripped.tar.gz"

        # "Validate" (Update) SHA512sum
        validate_sha512sum "${PYTHON_SHA512SUM_OSX_ARM64}" "${DOVE_PYTHON_DIR}/${PYTHON_GIT_RELEASE}/cpython-${PYTHON_VERSION}+${PYTHON_GIT_RELEASE}-aarch64-apple-darwin-install_only_stripped.tar.gz"

        echo_red_text 'Downloading Python (OS X - x86_64)...'
        download "https://github.com/astral-sh/python-build-standalone/releases/download/${PYTHON_GIT_RELEASE}/cpython-${PYTHON_VERSION}+${PYTHON_GIT_RELEASE}-x86_64-apple-darwin-install_only_stripped.tar.gz" "${DOVE_PYTHON_DIR}/${PYTHON_GIT_RELEASE}/cpython-${PYTHON_VERSION}+${PYTHON_GIT_RELEASE}-x86_64-apple-darwin-install_only_stripped.tar.gz"

        # "Validate" (Update) SHA512sum
        validate_sha512sum "${PYTHON_SHA512SUM_OSX_X86_64}" "${DOVE_PYTHON_DIR}/${PYTHON_GIT_RELEASE}/cpython-${PYTHON_VERSION}+${PYTHON_GIT_RELEASE}-x86_64-apple-darwin-install_only_stripped.tar.gz"
    else
        echo_red_text 'Downloading Python...'
        download "https://github.com/astral-sh/python-build-standalone/releases/download/${PYTHON_GIT_RELEASE}/cpython-${PYTHON_VERSION}+${PYTHON_GIT_RELEASE}-${PYTHON_ARCH}-${PYTHON_PLATFORM}-install_only_stripped.tar.gz" "${DOVE_PYTHON_DIR}/${PYTHON_GIT_RELEASE}/cpython-${PYTHON_VERSION}+${PYTHON_GIT_RELEASE}-${PYTHON_ARCH}-${PYTHON_PLATFORM}-install_only_stripped.tar.gz"

        # Validate SHA512sum
        validate_sha512sum "${PYTHON_SHA512SUM}" "${DOVE_PYTHON_DIR}/${PYTHON_GIT_RELEASE}/cpython-${PYTHON_VERSION}+${PYTHON_GIT_RELEASE}-${PYTHON_ARCH}-${PYTHON_PLATFORM}-install_only_stripped.tar.gz"

        echo_green_text "SUCCESS: Downloaded Python to ${DOVE_PYTHON_DIR}/${PYTHON_GIT_RELEASE}/cpython-${PYTHON_VERSION}+${PYTHON_GIT_RELEASE}-${PYTHON_ARCH}-${PYTHON_PLATFORM}-install_only_stripped.tar.gz"
    fi
}

# Get s3cmd
function get_s3cmd() {
    # If all we're doing is updating the checksum, we don't care if the environment is prepared
    if [[ "${DOVE_GET_SOURCE_CHECKSUM_UPDATE}" != 1 ]]; then
        if  [[ ! -d "${DOVE_UV_DIR}" ]] || [[ ! -f "${DOVE_PYENV}" ]]; then
            echo_red_text "ERROR: You tried to download s3cmd, but you don't have a uv environment set-up yet."
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
    download_and_extract 's3cmd' "https://github.com/s3tools/s3cmd/archive/${S3CMD_COMMIT}.tar.gz" "${DOVE_S3CMD_DIR}" "${S3CMD_SHA512SUM}"

    if [[ "${DOVE_GET_SOURCE_CHECKSUM_UPDATE}" != 1 ]]; then
        source "${DOVE_PYENV}"
        echo_red_text 'Installing s3cmd...'
        "${DOVE_UV}" pip install --no-editable --strict "${DOVE_S3CMD_DIR}"
        echo_green_text "SUCCESS: Set-up s3cmd at ${DOVE_S3CMD}"
    fi
}

# Get + set-up uv
function get_uv() {
    # If all we're doing is updating the checksum, we don't care if the environment is prepared
    if [[ "${DOVE_GET_SOURCE_CHECKSUM_UPDATE}" != 1 ]]; then
        if  [[ ! -d "${DOVE_PYTHON_DIR}" ]]; then
            echo_red_text "ERROR: You tried to download uv, but you don't have Python downloaded yet."
            exit 1
        fi

        if [[ -d "${DOVE_PYENV_DIR}" ]]; then
            echo_red_text "The uv environment is already set-up at ${DOVE_PYENV_DIR}"
            read -p "Do you want to re-create it? [y/N] " -n 1 -r
            echo
            if [[ "${REPLY}" =~ ^[Yy]$ ]]; then
                rm -rf "${DOVE_PYENV_DIR}" "${DOVE_UV_DIR}" "${DOVE_UV_LOCAL}"
            fi
        fi
    fi

    # Set our platform
    if [[ "${DOVE_PLATFORM}" == 'darwin' ]]; then
        local readonly UV_PLATFORM='apple-darwin'
    else
        local readonly UV_PLATFORM='unknown-linux-gnu'
    fi

    # Set our platform architecture
    if [[ "${DOVE_PLATFORM_ARCH}" == 'arm64' ]]; then
        local readonly UV_ARCH='aarch64'
    else
        local readonly UV_ARCH='x86_64'
    fi

    # Set our checksum to verify
    if [[ "${DOVE_PLATFORM_ARCH}" == 'arm64' ]]; then
        if [[ "${DOVE_PLATFORM}" == 'darwin' ]]; then
            local readonly UV_SHA512SUM="${UV_SHA512SUM_OSX_ARM64}"
        else
            local readonly UV_SHA512SUM="${UV_SHA512SUM_LINUX_ARM64}"
        fi
    else
        if [[ "${DOVE_PLATFORM}" == 'darwin' ]]; then
            local readonly UV_SHA512SUM="${UV_SHA512SUM_OSX_X86_64}"
        else
            local readonly UV_SHA512SUM="${UV_SHA512SUM_LINUX_X86_64}"
        fi
    fi

    if [[ "${DOVE_GET_SOURCE_CHECKSUM_UPDATE}" == 1 ]]; then
        echo_red_text 'Downloading uv (Linux - ARM64)...'
        download_and_extract 'uv' "https://github.com/astral-sh/uv/releases/download/${UV_VERSION}/uv-aarch64-unknown-linux-gnu.tar.gz" "${DOVE_UV_DIR}" "${UV_SHA512SUM_LINUX_ARM64}"

        echo_red_text 'Downloading uv (Linux - x86_64)...'
        download_and_extract 'uv' "https://github.com/astral-sh/uv/releases/download/${UV_VERSION}/uv-x86_64-unknown-linux-gnu.tar.gz" "${DOVE_UV_DIR}" "${UV_SHA512SUM_LINUX_X86_64}"

        echo_red_text 'Downloading uv (OS X - ARM64)...'
        download_and_extract 'uv' "https://github.com/astral-sh/uv/releases/download/${UV_VERSION}/uv-aarch64-apple-darwin.tar.gz" "${DOVE_UV_DIR}" "${UV_SHA512SUM_OSX_ARM64}"

        echo_red_text 'Downloading uv (OS X - x86_64)...'
        download_and_extract 'uv' "https://github.com/astral-sh/uv/releases/download/${UV_VERSION}/uv-x86_64-apple-darwin.tar.gz" "${DOVE_UV_DIR}" "${UV_SHA512SUM_OSX_X86_64}"
    else
        echo_red_text 'Downloading uv...'
        download_and_extract 'uv' "https://github.com/astral-sh/uv/releases/download/${UV_VERSION}/uv-${UV_ARCH}-${UV_PLATFORM}.tar.gz" "${DOVE_UV_DIR}" "${UV_SHA512SUM}"

        echo_red_text 'Installing Python...'
        "${DOVE_UV}" python install "${PYTHON_VERSION}"

        echo_red_text 'Creating uv environment...'
        "${DOVE_UV}" venv "${DOVE_PYENV_DIR}"
        echo_green_text "SUCCESS: Set-up uv environment at ${DOVE_PYENV_DIR}"
    fi
}

if [[ "${DOVE_GET_SOURCE_AUTOCONFIG}" == 1 ]]; then
    get_autoconfig
fi

# These need to run before we get lxml and s3cmd
if [[ "${DOVE_GET_SOURCE_PYTHON}" == 1 ]]; then
    get_python
fi

if [[ "${DOVE_GET_SOURCE_UV}" == 1 ]]; then
    get_uv
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
