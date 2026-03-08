#!/bin/bash

set -euo pipefail

# Set-up our environment
bash -x $(dirname $0)/env.sh
source $(dirname $0)/env.sh

if [[ -z "${DOVE_FROM_SOURCES+x}" ]]; then
    echo_red_text "ERROR: Do not call get_sources-dove.sh directly. Instead, use get_sources.sh." >&1
    exit 1
fi

target="$1"
mode="$2"

# Set-up target parameters
DOVE_GET_SOURCE_AUTOCONFIG=0
DOVE_GET_SOURCE_LXML=0
DOVE_GET_SOURCE_PHOENIX=0
DOVE_GET_SOURCE_PIP=0

if [ "${target}" == 'autoconfig' ]; then
    # Get Thunderbird's Autoconfiguration Database (ISPDB)
    DOVE_GET_SOURCE_AUTOCONFIG=1
elif [ "${target}" == 'lxml' ]; then
    # Get lxml
    DOVE_GET_SOURCE_LXML=1
elif [ "${target}" == 'phoenix' ]; then
    # Get Phoenix
    DOVE_GET_SOURCE_PHOENIX=1
elif [ "${target}" == 'pip' ]; then
    #  Get + set-up pip
    DOVE_GET_SOURCE_PIP=1
elif [ "${target}" == 'all' ]; then
    # If no argument is specified (or argument is set to "all"), just get everything
    DOVE_GET_SOURCE_AUTOCONFIG=1
    DOVE_GET_SOURCE_LXML=1
    DOVE_GET_SOURCE_PHOENIX=1
    DOVE_GET_SOURCE_PIP=1
else
    echo_red_text "ERROR: Invalid target: ${target}\n You must enter one of the following:"
    echo 'All: all (Default)'
    echo 'lxml: lxml'
    echo 'Phoenix: phoenix'
    echo 'pip: pip'
    echo 'Thunderbird Autoconfiguration Database: autoconfig'
    exit 1
fi

# If the 'checksum-update' argument is specified, in addition to downloading the dependencies as usual,
## we're also updating their checksums
DOVE_GET_SOURCE_CHECKSUM_UPDATE=0
if [ "${mode}" == 'checksum-update' ]; then
    DOVE_GET_SOURCE_CHECKSUM_UPDATE=1
elif [ "${mode}" != 'download' ]; then
    echo_red_text "ERROR: Invalid mode: ${mode}\n You must enter one of the following:"
    echo 'Download: download (Default)'
    echo 'Download + update checksums: checksum-update'
    exit 1
fi

# Include version info
source "${DOVE_VERSIONS}"

# Function to automate updating SHA512sums of dependencies
function update_sha512sum() {
    old_sha512sum="$1"
    new_sha512sum="$2"
    file="$3"

    if [ "${old_sha512sum}" == "${AUTOCONFIG_SHA512SUM}" ]; then
        echo_red_text 'Updating SHA512sum for Thunderbird Autoconfiguration Database...'
        "${DOVE_SED}" -i -e "s|AUTOCONFIG_SHA512SUM='.*'|AUTOCONFIG_SHA512SUM='"${new_sha512sum}"'|g" "${DOVE_VERSIONS}"
        echo_green_text 'SUCCESS: Updated SHA512sum for Thunderbird Autoconfiguration Database'
    elif [ "${old_sha512sum}" == "${LXML_SHA512SUM}" ]; then
        echo_red_text 'Updating SHA512sum for lxml...'
        "${DOVE_SED}" -i -e "s|LXML_SHA512SUM='.*'|LXML_SHA512SUM='"${new_sha512sum}"'|g" "${DOVE_VERSIONS}"
        echo_green_text 'SUCCESS: Updated SHA512sum for lxml'
    elif [ "${old_sha512sum}" == "${PHOENIX_SHA512SUM}" ]; then
        echo_red_text 'Updating SHA512sum for Phoenix...'
        "${DOVE_SED}" -i -e "s|PHOENIX_SHA512SUM='.*'|PHOENIX_SHA512SUM='"${new_sha512sum}"'|g" "${DOVE_VERSIONS}"
        echo_green_text 'SUCCESS: Updated SHA512sum for Phoenix'
    elif [ "${old_sha512sum}" == "${PIP_SHA512SUM}" ]; then
        echo_red_text 'Updating SHA512sum for pip...'
        "${DOVE_SED}" -i -e "s|PIP_SHA512SUM='.*'|PIP_SHA512SUM='"${new_sha512sum}"'|g" "${DOVE_VERSIONS}"
        echo_green_text 'SUCCESS: Updated SHA512sum for pip'
    fi

    rm "${file}"
}

function validate_sha512sum() {
    expected_sha512sum="$1"
    file="$2"

    local_sha512sum=$(sha512sum "${file}" | "${DOVE_AWK}" '{print $1}')

    if [ "${DOVE_GET_SOURCE_CHECKSUM_UPDATE}" == 1 ]; then
        update_sha512sum "${expected_sha512sum}" "${local_sha512sum}" "${file}"
    elif [ "${local_sha512sum}" != "${expected_sha512sum}" ]; then
        echo_red_text 'ERROR: Checksum validation failed.'
        echo "Expected SHA512sum: ${expected_sha512sum}"
        echo "Actual SHA512sum: ${local_sha512sum}"

        # If checksum validation fails, also just remove the file
        rm -f "${file}"

        exit 1
    else
        echo_green_text 'SUCCESS: Checksum validated.'
        echo "SHA512sum: ${local_sha512sum}"
    fi
}

function clone_repo() {
    url="$1"
    path="$2"
    revision="$3"

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
    local url="$1"
    local filepath="$2"

    if [[ "${url}" == "" ]]; then
        echo_red_text "ERROR: URL is required (file: '${filepath}')"
        exit 1
    fi

    if [ -f "${filepath}" ]; then
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
    local archive_path="$1"
    local target_path="$2"
    local temp_repo_name="$3"

    if ! [[ -f "${archive_path}" ]]; then
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

    local top_input_dir=$(ls "${DOVE_EXTERNAL}/temp/${temp_repo_name}")
    cp -rf "${DOVE_EXTERNAL}/temp/${temp_repo_name}/${top_input_dir}"/ "${target_path}"
    rm -rf "${DOVE_EXTERNAL}/temp/${temp_repo_name}"
}

function download_and_extract() {
    local repo_name="$1"
    local url="$2"
    local path="$3"
    local expected_sha512sum="$4"

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

    local extension
    if [[ "${url}" =~ \.tar\.xz$ ]]; then
        extension=".tar.xz"
    elif [[ "${url}" =~ \.tar\.gz$ ]]; then
        extension=".tar.gz"
    elif [[ "${url}" =~ \.tar\.zst$ ]]; then
        extension=".tar.zst"
    else
        extension=".zip"
    fi

    local repo_archive="${DOVE_DOWNLOADS}/${repo_name}${extension}"

    download "${url}" "${repo_archive}"

    if [ ! -f "${repo_archive}" ]; then
        echo_red_text "ERROR: Source archive for ${repo_name} does not exist."
        exit 1
    fi

    # Before extracting, verify SHA512sum...
    validate_sha512sum "${expected_sha512sum}" "${repo_archive}"

    if [ "${DOVE_GET_SOURCE_CHECKSUM_UPDATE}" != 1 ]; then
        echo_red_text "Extracting ${repo_archive}..."
        extract "${repo_archive}" "${path}" "${repo_name}"
        echo
    fi
}

# Get Thunderbird's Autoconfiguration Database (ISPDB)
function get_autoconfig() {
    echo_red_text 'Downloading Thunderbird Autoconfiguration Database (ISPDB)...'
    download_and_extract 'autoconfig' "https://github.com/thunderbird/autoconfig/archive/${AUTOCONFIG_COMMIT}.tar.gz" "${DOVE_AUTOCONFIG}" "${AUTOCONFIG_SHA512SUM}"
    echo_green_text "SUCCESS: Set-up Thunderbird Autoconfiguration Database (ISPDB) at ${DOVE_AUTOCONFIG}"
}

# Get lxml
function get_lxml() {
    if  [ ! -d "${DOVE_PIP_DIR}" ] || [ ! -f "${DOVE_PIP_ENV}" ]; then
        echo_red_text "ERROR: You tried to download lxml, but you don't have a pip environment set-up yet."
        exit 1
    fi

    echo_red_text "Downloading lxml..."
    download_and_extract 'lxml' "https://github.com/lxml/lxml/archive/${LXML_COMMIT}.tar.gz" "${DOVE_LXML}" "${LXML_SHA512SUM}"

    # For the pip install to work, we need to initialize a Git repository
    ## The Git repository isn't already created, due to our method of downloading and verifying the archive
    pushd "${DOVE_LXML}"
    git init
    popd

    source "${DOVE_PIP_ENV}"
    echo_red_text 'Installing lxml...'
    pip install "${DOVE_LXML}"
    echo_green_text 'SUCCESS: Set-up lxml'
}

# Get Phoenix
function get_phoenix() {
    echo_red_text 'Downloading Phoenix...'
    download_and_extract 'phoenix' "https://gitlab.com/celenityy/Phoenix/-/archive/${PHOENIX_COMMIT}/Phoenix-${PHOENIX_COMMIT}.tar.gz" "${DOVE_PHOENIX}" "${PHOENIX_SHA512SUM}"
    echo_green_text "SUCCESS: Set-up Phoenix at ${DOVE_PHOENIX}"
}

# Get + set-up pip
function get_pip() {
    if [[ -d "${DOVE_PIP_DIR}" ]]; then
        echo_red_text "The pip environment is already set-up at ${DOVE_PIP_DIR}"
        read -p "Do you want to re-create it? [y/N] " -n 1 -r
        echo
        if [[ "${REPLY}" =~ ^[Yy]$ ]]; then
            rm -rf "${DOVE_PIP_DIR}" "${DOVE_PIP}"
        fi
    fi

    echo_red_text 'Creating pip environment...'
    python3.9 -m venv "${DOVE_PIP_DIR}"

    echo_red_text 'Downloading pip...'
    download_and_extract 'pip' "https://github.com/pypa/pip/archive/${PIP_COMMIT}.tar.gz" "${DOVE_PIP}" "${PIP_SHA512SUM}"

    # For the pip install to work, we need to initialize a Git repository
    ## The Git repository isn't already created, due to our method of downloading and verifying the archive
    pushd "${DOVE_PIP}"
    git init
    popd

    source "${DOVE_PIP_ENV}"
    echo_red_text 'Installing pip...'
    pip install "${DOVE_PIP}"
    echo_green_text "SUCCESS: Set-up pip environment at ${DOVE_PIP_DIR}"
}

if [ "${DOVE_GET_SOURCE_AUTOCONFIG}" == 1 ]; then
    get_autoconfig
fi

# This needs to run before we get lxml
if [ "${DOVE_GET_SOURCE_PIP}" == 1 ]; then
    get_pip
fi

if [ "${DOVE_GET_SOURCE_LXML}" == 1 ]; then
    get_lxml
fi

if [ "${DOVE_GET_SOURCE_PHOENIX}" == 1 ]; then
    get_phoenix
fi
