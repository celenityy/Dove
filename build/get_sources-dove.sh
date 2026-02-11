#!/bin/bash

set -euo pipefail

# Functions
function echo_red_text() {
	echo -e "\033[31m$1\033[0m"
}

if [[ -z "${DOVE_FROM_SOURCES+x}" ]]; then
    echo_red_text "ERROR: Do not call get_sources-dove.sh directly. Instead, use get_sources.sh." >&1
    exit 1
fi

# Set-up our environment
bash -x $(dirname $0)/env.sh
source $(dirname $0)/env.sh

# Include version info
source "${DOVE_VERSIONS}"

function clone_repo() {
    url="$1"
    path="$2"
    revision="$3"

    if [[ "${url}" == "" ]]; then
        echo "URL missing for clone"
        exit 1
    fi

    if [[ "${path}" == "" ]]; then
        echo "Path is required for cloning '${url}'"
        exit 1
    fi

    if [[ "${revision}" == "" ]]; then
        echo "Revision is required for cloning '${url}'"
        exit 1
    fi

    if [[ -f "${path}" ]]; then
        echo "'${path}' exists and is not a directory"
        exit 1
    fi

    if [[ -d "${path}" ]]; then
        echo "'${path}' already exists"
        read -p "Do you want to re-clone this repository? [y/N] " -n 1 -r
        echo
        if [[ "${REPLY}" =~ ^[Yy]$ ]]; then
            echo "Removing ${path}..."
            rm -rf "${path}"
        else
            return 0
        fi
    fi

    echo "Cloning ${url}::${revision}"
    git clone --revision="${revision}" --depth=1 "${url}" "${path}"
}

function download() {
    local url="$1"
    local filepath="$2"

    if [[ "${url}" == "" ]]; then
        echo "URL is required (file: '${filepath}')"
        exit 1
    fi

    if [ -f "${filepath}" ]; then
        echo "${filepath} already exists."
        read -p "Do you want to re-download? [y/N] " -n 1 -r
        echo
        if [[ "${REPLY}" =~ ^[Yy]$ ]]; then
            echo "Removing ${filepath}..."
            rm -f "${filepath}"
        else
            return 0
        fi
    fi

    mkdir -vp "$(dirname "${filepath}")"

    echo "Downloading ${url}"
    curl ${DOVE_CURL_FLAGS} -sSL "${url}" -o "${filepath}"
}

# Extract zip removing top level directory
function extract_rmtoplevel() {
    local archive_path="$1"
    local to_name="$2"
    local extract_to="${DOVE_EXTERNAL}/${to_name}"

    if ! [[ -f "${archive_path}" ]]; then
        echo "Archive '${archive_path}' does not exist!"
    fi

    # Create temporary directory for extraction
    local temp_dir=$(mktemp -d)

    # Extract based on file extension
    case "${archive_path}" in
        *.zip)
            unzip -q "${archive_path}" -d "${temp_dir}"
            ;;
        *.tar.gz)
            "${DOVE_TAR}" xzf "${archive_path}" -C "${temp_dir}"
            ;;
        *.tar.xz)
            "${DOVE_TAR}" xJf "${archive_path}" -C "${temp_dir}"
            ;;
        *.tar.zst)
            "${DOVE_TAR}" --zstd -xvf "${archive_path}" -C "${temp_dir}"
            ;;
        *)
            echo "Unsupported archive format: ${archive_path}"
            rm -rf "${temp_dir}"
            exit 1
            ;;
    esac

    local top_dir=$(ls "${temp_dir}")
    local to_parent=$(dirname "${extract_to}")

    rm -rf "${extract_to}"
    mkdir -vp "${to_parent}"
    mv "${temp_dir}/${top_dir}" "${to_parent}/${to_name}"

    rm -rf "${temp_dir}"
}

function download_and_extract() {
    local repo_name="$1"
    local url="$2"

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
        echo "Source archive for ${repo_name} does not exist."
        exit 1
    fi

    echo "Extracting ${repo_archive}"
    extract_rmtoplevel "${repo_archive}" "${repo_name}"
    echo
}

# Clone Phoenix
echo "Cloning Phoenix..."
clone_repo "https://gitlab.com/celenityy/Phoenix.git" "${DOVE_PHOENIX}" "${PHOENIX_COMMIT}"

# Clone Thunderbird Autoconfiguration Database (ISPDB)
echo "Cloning Thunderbird Autoconfiguration Database (ISPDB)..."
clone_repo "https://github.com/thunderbird/autoconfig.git" "${DOVE_AUTOCONFIG}" "${AUTOCONFIG_COMMIT}"
