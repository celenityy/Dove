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

# Include version info
source "${DOVE_VERSIONS}"

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

# Get Thunderbird's Autoconfiguration Database (ISPDB)
function get_autoconfig() {
    echo_red_text "Cloning Thunderbird Autoconfiguration Database (ISPDB)..."
    clone_repo "https://github.com/thunderbird/autoconfig.git" "${DOVE_AUTOCONFIG}" "${AUTOCONFIG_COMMIT}"
    echo_green_text "SUCCESS: Set-up Thunderbird Autoconfiguration Database (ISPDB) at ${DOVE_AUTOCONFIG}"
}

# Get lxml
function get_lxml() {
    if  [ ! -d "${DOVE_PIP_DIR}" ] || [ ! -f "${DOVE_PIP_ENV}" ]; then
        echo_red_text "ERROR: You tried to download lxml, but you don't have a pip environment set-up yet."
        exit 1
    fi

    source "${DOVE_PIP_ENV}"
    echo_red_text "Downloading lxml..."
    pip install lxml
    echo_green_text "SUCCESS: Set-up lxml at ${DOVE_PIP_DIR}"
}

# Get Phoenix
function get_phoenix() {
    echo_red_text "Cloning Phoenix..."
    clone_repo "https://gitlab.com/celenityy/Phoenix.git" "${DOVE_PHOENIX}" "${PHOENIX_COMMIT}"
    echo_green_text "SUCCESS: Set-up Phoenix at ${DOVE_PHOENIX}"
}

# Get + set-up pip
function get_pip() {
    if [[ -d "${DOVE_PIP_DIR}" ]]; then
        echo_red_text "The pip environment is already set-up at ${DOVE_PIP_DIR}"
        read -p "Do you want to re-create it? [y/N] " -n 1 -r
        echo
        if [[ "${REPLY}" =~ ^[Yy]$ ]]; then
            rm -rf "${DOVE_PIP_DIR}"
        fi
    fi

    echo_red_text "Creating pip environment..."
    python3.9 -m venv "${DOVE_PIP_DIR}"
    echo_red_text "Updating pip..."
    source "${DOVE_PIP_ENV}"
    pip install --upgrade pip
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
