#!/bin/bash

# Dove environment variables

set -euo pipefail

# Set `DOVE_ROOT`
function set_root() {
  # If `DOVE_ROOT` is already set to a valid directory, we're done
  if [[ -n "${DOVE_ROOT+x}" ]] && [[ -d "${DOVE_ROOT}" ]]; then
    readonly DOVE_ROOT
    return 0
  fi

  # Find dirname
  if [[ -n "${DOVE_DIRNAME+x}" ]] && [[ -x "${DOVE_DIRNAME}" ]]; then
    local -r dirname="${DOVE_DIRNAME}"
  elif [[ -x '/bin/dirname' ]]; then
    local -r dirname='/bin/dirname'
  elif [[ -x '/usr/bin/dirname' ]]; then
    local -r dirname='/usr/bin/dirname'
  else
    if ! command -v dirname > /dev/null 2>&1; then
      echo "ERROR: Missing dirname!" >&2
      exit 1
    fi
    # It isn't a known location, so we sadly have to just fall-back to the PATH
    local -r dirname="$(dirname)"
  fi

  local -r root_txt="$("${dirname}" $0)/root.txt"

  if [[ ! -f "${root_txt}" ]]; then
    readonly DOVE_ROOT=$(cd "$("${dirname}" "${BASH_SOURCE[0]}")/.." && pwd)
    if [[ -d "${DOVE_ROOT}" ]]; then
      echo -n "${DOVE_ROOT}" > "${root_txt}" || exit 1
    else
      echo "ERROR: Unable to find a valid root directory: '${DOVE_ROOT}'!"
      exit 1
    fi
  else
    # Find cat
    if [[ -n "${DOVE_CAT+x}" ]] && [[ -x "${DOVE_CAT}" ]]; then
      local -r cat="${DOVE_CAT}"
    elif [[ -x '/bin/cat' ]]; then
      local -r cat='/bin/cat'
    elif [[ -x '/usr/bin/cat' ]]; then
      local -r cat='/usr/bin/cat'
    else
      if ! command -v cat > /dev/null 2>&1; then
        echo "ERROR: Missing cat!" >&2
        exit 1
      fi
      # It isn't a known location, so we sadly have to just fall-back to the PATH
      local -r cat="$(cat)"
    fi

    # Find xargs
    if [[ -n "${DOVE_XARGS+x}" ]] && [[ -x "${DOVE_XARGS}" ]]; then
      local -r xargs="${DOVE_XARGS}"
    elif [[ -x '/bin/xargs' ]]; then
      local -r xargs='/bin/xargs'
    elif [[ -x '/usr/bin/xargs' ]]; then
      local -r xargs='/usr/bin/xargs'
    else
      if ! command -v xargs > /dev/null 2>&1; then
        echo "ERROR: Missing xargs!" >&2
        exit 1
      fi
      # It isn't a known location, so we sadly have to just fall-back to the PATH
      local -r xargs="$(xargs)"
    fi

    readonly DOVE_ROOT=$("${cat}" "${root_txt}" | "${xargs}")

    if [[ ! -d "${DOVE_ROOT}" ]]; then
      echo "ERROR: Unable to find a valid root directory: '${DOVE_ROOT}'!"
      exit 1
    fi
  fi
}

# Add an executable to Dove's PATH
## If the executable is not valid, a warning is displayed instead
function add_to_path() {
  function print_usage() {
    echo "Usage: add_to_path '/path/to/PATH' '/path/to/executable' 'executable_env_var' 'executable'"
  }

  if [[ -z "${1+x}" ]]; then
    echo_red_text "ERROR: Please specify the PATH's path!"
    print_usage
    exit 1
  fi

  if [[ -z "${2+x}" ]]; then
    echo_red_text 'ERROR: Please specify the path to an executable!'
    print_usage
    exit 1
  fi

  if [[ -z "${3+x}" ]]; then
    echo_red_text "ERROR: Please specify the executable's environment variable!"
    print_usage
    exit 1
  fi

  if [[ -z "${4+x}" ]]; then
    echo_red_text 'ERROR: Please specify the executable name!'
    print_usage
    exit 1
  fi

  # Ensure we have ln
  verify_exec "${DOVE_LN}" 'DOVE_LN' || exit 1

  # Ensure we have mkdir
  verify_exec "${DOVE_MKDIR}" 'DOVE_MKDIR' || exit 1

  # Ensure we have rm
  verify_exec "${DOVE_RM}" 'DOVE_RM' || exit 1

  local -r path="$1"
  local -r exec="$2"
  local -r exec_env="$3"
  local -r exec_name="$4"

  # Create our PATH directory if necessary
  if [[ ! -d "${path}" ]]; then
    "${DOVE_MKDIR}" -p "${path}"
  fi

  if verify_env "${exec}" "${exec_env}"; then
    # If our target already exists on the path, remove it
    if [[ -f "${path}/${exec_name}" ]]; then
      "${DOVE_RM}" -f "${path}/${exec_name}"
    fi
    "${DOVE_LN}" -sf "${exec}" "${path}/${exec_name}"
    echo_green_text "Added '${exec_name}' to PATH (from '${exec_env}')!"
  else
    echo_red_text "WARNING: Unable to add '${exec_name}' to PATH!"
    echo "Please ensure that '${exec_env}' is set to a valid location."
  fi
}

# Add an executable to Dove's full PATH
function add_to_full_path() {
  function print_usage() {
    echo "Usage: add_to_full_path '/path/to/executable' 'executable_env_var' 'executable'"
  }

  if [[ -z "${1+x}" ]]; then
    echo_red_text 'ERROR: Please specify the path to an executable!'
    print_usage
    exit 1
  fi

  if [[ -z "${2+x}" ]]; then
    echo_red_text "ERROR: Please specify the executable's environment variable!"
    print_usage
    exit 1
  fi

  if [[ -z "${3+x}" ]]; then
    echo_red_text 'ERROR: Please specify the executable name!'
    print_usage
    exit 1
  fi

  # Ensure we have `DOVE_PATH`
  verify_env "${DOVE_PATH}" 'DOVE_PATH' || exit 1

  local -r exec="$1"
  local -r exec_env="$2"
  local -r exec_name="$3"

  add_to_path "${DOVE_PATH}" "${exec}" "${exec_env}" "${exec_name}"
}

# Add an executable to Dove's lint PATH
function add_to_lint_path() {
  function print_usage() {
    echo "Usage: add_to_lint_path '/path/to/executable' 'executable_env_var' 'executable'"
  }

  if [[ -z "${1+x}" ]]; then
    echo_red_text 'ERROR: Please specify the path to an executable!'
    print_usage
    exit 1
  fi

  if [[ -z "${2+x}" ]]; then
    echo_red_text "ERROR: Please specify the executable's environment variable!"
    print_usage
    exit 1
  fi

  if [[ -z "${3+x}" ]]; then
    echo_red_text 'ERROR: Please specify the executable name!'
    print_usage
    exit 1
  fi

  # Ensure we have `DOVE_LINT_PATH`
  verify_env "${DOVE_LINT_PATH}" 'DOVE_LINT_PATH' || exit 1

  local -r exec="$1"
  local -r exec_env="$2"
  local -r exec_name="$3"

  add_to_path "${DOVE_LINT_PATH}" "${exec}" "${exec_env}" "${exec_name}"
}

# Set-up the full Dove PATH
function setup_path() {
  # Ensure we have `DOVE_CI`
  verify_env "${DOVE_CI}" 'DOVE_CI' || exit 1

  # Ensure we have `DOVE_PLATFORM`
  verify_env "${DOVE_PLATFORM}" 'DOVE_PLATFORM' || exit 1

  add_to_full_path "${DOVE_AWK}" 'DOVE_AWK' 'awk'
  add_to_full_path "${DOVE_AWK}" 'DOVE_AWK' 'gawk'
  add_to_full_path "${DOVE_BASENAME}" 'DOVE_BASENAME' 'basename'
  add_to_full_path "${DOVE_BASH}" 'DOVE_BASH' 'bash'
  add_to_full_path "${DOVE_CAT}" 'DOVE_CAT' 'cat'
  add_to_full_path "${DOVE_CHMOD}" 'DOVE_CHMOD' 'chmod'
  add_to_full_path "${DOVE_CLANG}" 'DOVE_CLANG' 'clang'
  add_to_full_path "${DOVE_CP}" 'DOVE_CP' 'cp'
  add_to_full_path "${DOVE_CURL}" 'DOVE_CURL' 'curl'
  add_to_full_path "${DOVE_DATE}" 'DOVE_DATE' 'date'
  add_to_full_path "${DOVE_DATE}" 'DOVE_DATE' 'gdate'
  add_to_full_path "${DOVE_DIRNAME}" 'DOVE_DIRNAME' 'dirname'
  add_to_full_path "${DOVE_ECHO}" 'DOVE_ECHO' 'echo'
  add_to_full_path "${DOVE_FIND}" 'DOVE_FIND' 'find'
  add_to_full_path "${DOVE_GIT}" 'DOVE_GIT' 'git'
  add_to_full_path "${DOVE_GREP}" 'DOVE_GREP' 'grep'
  add_to_full_path "${DOVE_GZIP}" 'DOVE_GZIP' 'gzip'
  add_to_full_path "${DOVE_HEAD}" 'DOVE_HEAD' 'head'
  add_to_full_path "${DOVE_JQ}" 'DOVE_JQ' 'jq'
  add_to_full_path "${DOVE_LN}" 'DOVE_LN' 'ln'
  add_to_full_path "${DOVE_LS}" 'DOVE_LS' 'ls'
  add_to_full_path "${DOVE_MD5SUM}" 'DOVE_MD5SUM' 'md5sum'
  add_to_full_path "${DOVE_MKDIR}" 'DOVE_MKDIR' 'mkdir'
  add_to_full_path "${DOVE_PYTHON}" 'DOVE_PYTHON' 'python'
  add_to_full_path "${DOVE_PYTHON}" 'DOVE_PYTHON' 'python3'
  add_to_full_path "${DOVE_PYTHON}" 'DOVE_PYTHON' 'python3.14'
  add_to_full_path "${DOVE_RM}" 'DOVE_RM' 'rm'
  add_to_full_path "${DOVE_S3CMD}" 'DOVE_S3CMD' 's3cmd'
  add_to_full_path "${DOVE_SED}" 'DOVE_SED' 'gsed'
  add_to_full_path "${DOVE_SED}" 'DOVE_SED' 'sed'
  add_to_full_path "${DOVE_SH}" 'DOVE_SH' 'sh'
  add_to_full_path "${DOVE_SHASUM}" 'DOVE_SHASUM' 'shasum'
  add_to_full_path "${DOVE_TAR}" 'DOVE_TAR' 'gtar'
  add_to_full_path "${DOVE_TAR}" 'DOVE_TAR' 'tar'
  add_to_full_path "${DOVE_TEE}" 'DOVE_TEE' 'tee'
  add_to_full_path "${DOVE_TOUCH}" 'DOVE_TOUCH' 'touch'
  add_to_full_path "${DOVE_UNAME}" 'DOVE_UNAME' 'uname'
  add_to_full_path "${DOVE_UNZIP}" 'DOVE_UNZIP' 'unzip'
  add_to_full_path "${DOVE_UV}" 'DOVE_UV' 'uv'
  add_to_full_path "${DOVE_XARGS}" 'DOVE_XARGS' 'xargs'
  add_to_full_path "${DOVE_XML2_CONFIG}" 'DOVE_XML2_CONFIG' 'xml2-config'
  add_to_full_path "${DOVE_XSLT_CONFIG}" 'DOVE_XSLT_CONFIG' 'xslt-config'
  add_to_full_path "${DOVE_XZ}" 'DOVE_XZ' 'xz'
  add_to_full_path "${DOVE_ZIP}" 'DOVE_ZIP' 'zip'

  # OS X-specific
  if [[ "${DOVE_PLATFORM}" == 'darwin' ]]; then
    add_to_full_path "${DOVE_DOT_CLEAN}" 'DOVE_DOT_CLEAN' 'dot_clean'
    add_to_full_path "${DOVE_XCRUN}" 'DOVE_XCRUN' 'xcrun'
  else
    add_to_full_path "${DOVE_ASSEMBLER}" 'DOVE_ASSEMBLER' 'as'
    add_to_full_path "${DOVE_CC}" 'DOVE_CC' 'cc'
    add_to_full_path "${DOVE_LD}" 'DOVE_LD' 'ld'
  fi

  PATH="${DOVE_PATH}"
  export PATH
}

# Set-up a minimal PATH for linting
function setup_lint_path() {
  add_to_lint_path "${DOVE_BASH}" 'DOVE_BASH' 'bash'
  add_to_lint_path "${DOVE_GIT}" 'DOVE_GIT' 'git'
  add_to_lint_path "${DOVE_LS}" 'DOVE_LS' 'ls'
  add_to_lint_path "${DOVE_SH}" 'DOVE_SH' 'sh'
  add_to_lint_path "${DOVE_SHELLCHECK}" 'DOVE_SHELLCHECK' 'shellcheck'
  add_to_lint_path "${DOVE_SHFMT}" 'DOVE_SHFMT' 'shfmt'

  readonly PATH="${DOVE_LINT_PATH}"
  export PATH
}

# For CI, ensure external environment variables are set
function setup_ci() {
  # Ensure our CI type is set
  if [[ -z "${DOVE_CI_TYPE+x}" ]] || [[ "${DOVE_CI_TYPE}" == "" ]] ||
    [[ "${DOVE_CI_TYPE}" == "null" ]]; then
    echo "ERROR: Missing CI type! Please set 'DOVE_CI_TYPE'."
    exit 1
  fi

  # Ensure our branches are set
  if [[ -z "${DOVE_DEV_BRANCH+x}" ]] || [[ "${DOVE_DEV_BRANCH}" == "" ]] ||
    [[ "${DOVE_DEV_BRANCH}" == "null" ]]; then
    echo "ERROR: Missing developer branch! Please set 'DOVE_DEV_BRANCH'."
    exit 1
  fi

  if [[ -z "${DOVE_PROD_BRANCH+x}" ]] || [[ "${DOVE_PROD_BRANCH}" == "" ]] ||
    [[ "${DOVE_PROD_BRANCH}" == "null" ]]; then
    echo "ERROR: Missing production branch! Please set 'DOVE_PROD_BRANCH'."
    exit 1
  fi
}

# Remove the legacy `env_local.sh`
function clean_env_local() {
  # Ensure we have rm
  verify_exec "${DOVE_RM}" 'DOVE_RM' || exit 1

  if [[ -f "$(dirname $0)/env_local.sh" ]]; then
    "${DOVE_RM}" -f "$(dirname $0)/env_local.sh"
  fi
}

# Set-up our environment
function set_env() {
  if [[ -z "${DOVE_SET_ENVS+x}" ]] || [[ "${DOVE_SET_ENVS}" != 1 ]]; then
    # Get our root directory
    set_root || exit 1

    # Ensure we have `DOVE_ROOT`
    if [[ -z "${DOVE_ROOT+x}" ]] || [[ ! -d "${DOVE_ROOT}" ]]; then
      echo "ERROR: 'DOVE_ROOT' is missing or invalid!"
      exit 1
    fi

    # Do not use the system PATH
    unset PATH || exit 1
    hash -r || exit 1

    # Handle CI-specific logic
    if [[ -n "${DOVE_CI+x}" ]]; then
      setup_ci || exit 1
    fi

    source "${DOVE_ROOT}/scripts/env_common.sh" || exit 1

    # Include utilities
    if [[ -z "${DOVE_UTILS+x}" ]] || [[ ! -f "${DOVE_UTILS}" ]] || [[ ! -s "${DOVE_UTILS}" ]]; then
      echo "ERROR: 'DOVE_UTILS' is missing or invalid!"
      exit 1
    fi
    source "${DOVE_UTILS}" || exit 1

    # Set-up our PATH
    if [[ -n "${DOVE_LINTING+x}" ]]; then
      setup_lint_path || exit 1
    else
      setup_path || exit 1
    fi

    # Clean-up the old `env_local.sh` (if necessary)
    clean_env_local
  fi
}

# Set-up our environment
set_env
