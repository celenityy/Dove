#!/bin/bash

# Dove environment variables

set -euo pipefail

if [[ ! -f "$(dirname $0)/env_local.sh" ]]; then
  readonly ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
  readonly ENV_LOCAL="${ROOT}/scripts/env_local.sh"

  # Write env_local.sh
  echo "Writing ${ENV_LOCAL}..."
  cat > "${ENV_LOCAL}" << EOF
# shellcheck shell=bash
readonly DOVE_ROOT="${ROOT}"
export DOVE_ROOT

source "\${DOVE_ROOT}/scripts/env_common.sh"
EOF
fi

# Set-up the full Dove PATH
function setup_path() {
  "${DOVE_RM}" -rf "${DOVE_PATH}"
  "${DOVE_MKDIR}" -p "${DOVE_PATH}"

  "${DOVE_LN}" -sf "${DOVE_AWK}" "${DOVE_PATH}/awk"
  "${DOVE_LN}" -sf "${DOVE_AWK}" "${DOVE_PATH}/gawk"
  "${DOVE_LN}" -sf "${DOVE_BASENAME}" "${DOVE_PATH}/basename"
  "${DOVE_LN}" -sf "${DOVE_CAT}" "${DOVE_PATH}/cat"
  "${DOVE_LN}" -sf "${DOVE_CHMOD}" "${DOVE_PATH}/chmod"
  "${DOVE_LN}" -sf "${DOVE_CLANG}" "${DOVE_PATH}/clang"
  "${DOVE_LN}" -sf "${DOVE_CP}" "${DOVE_PATH}/cp"
  "${DOVE_LN}" -sf "${DOVE_CURL}" "${DOVE_PATH}/curl"
  "${DOVE_LN}" -sf "${DOVE_DATE}" "${DOVE_PATH}/date"
  "${DOVE_LN}" -sf "${DOVE_DATE}" "${DOVE_PATH}/gdate"
  "${DOVE_LN}" -sf "${DOVE_DIRNAME}" "${DOVE_PATH}/dirname"
  "${DOVE_LN}" -sf "${DOVE_ECHO}" "${DOVE_PATH}/echo"
  "${DOVE_LN}" -sf "${DOVE_FIND}" "${DOVE_PATH}/find"
  "${DOVE_LN}" -sf "${DOVE_GIT}" "${DOVE_PATH}/git"
  "${DOVE_LN}" -sf "${DOVE_GREP}" "${DOVE_PATH}/grep"
  "${DOVE_LN}" -sf "${DOVE_GZIP}" "${DOVE_PATH}/gzip"
  "${DOVE_LN}" -sf "${DOVE_HEAD}" "${DOVE_PATH}/head"
  "${DOVE_LN}" -sf "${DOVE_JQ}" "${DOVE_PATH}/jq"
  "${DOVE_LN}" -sf "${DOVE_LN}" "${DOVE_PATH}/ln"
  "${DOVE_LN}" -sf "${DOVE_LS}" "${DOVE_PATH}/ls"
  "${DOVE_LN}" -sf "${DOVE_MD5SUM}" "${DOVE_PATH}/md5sum"
  "${DOVE_LN}" -sf "${DOVE_MKDIR}" "${DOVE_PATH}/mkdir"
  "${DOVE_LN}" -sf "${DOVE_PYTHON}" "${DOVE_PATH}/python"
  "${DOVE_LN}" -sf "${DOVE_PYTHON}" "${DOVE_PATH}/python3"
  "${DOVE_LN}" -sf "${DOVE_PYTHON}" "${DOVE_PATH}/python3.14"
  "${DOVE_LN}" -sf "${DOVE_RM}" "${DOVE_PATH}/rm"
  "${DOVE_LN}" -sf "${DOVE_S3CMD}" "${DOVE_PATH}/s3cmd"
  "${DOVE_LN}" -sf "${DOVE_SED}" "${DOVE_PATH}/gsed"
  "${DOVE_LN}" -sf "${DOVE_SED}" "${DOVE_PATH}/sed"
  "${DOVE_LN}" -sf "${DOVE_SHA1SUM}" "${DOVE_PATH}/sha1sum"
  "${DOVE_LN}" -sf "${DOVE_SHA256SUM}" "${DOVE_PATH}/sha256sum"
  "${DOVE_LN}" -sf "${DOVE_SHA512SUM}" "${DOVE_PATH}/sha512sum"
  "${DOVE_LN}" -sf "${DOVE_TAR}" "${DOVE_PATH}/gtar"
  "${DOVE_LN}" -sf "${DOVE_TAR}" "${DOVE_PATH}/tar"
  "${DOVE_LN}" -sf "${DOVE_TEE}" "${DOVE_PATH}/tee"
  "${DOVE_LN}" -sf "${DOVE_TOUCH}" "${DOVE_PATH}/touch"
  "${DOVE_LN}" -sf "${DOVE_UNAME}" "${DOVE_PATH}/uname"
  "${DOVE_LN}" -sf "${DOVE_UNZIP}" "${DOVE_PATH}/unzip"
  "${DOVE_LN}" -sf "${DOVE_UV}" "${DOVE_PATH}/uv"
  "${DOVE_LN}" -sf "${DOVE_XARGS}" "${DOVE_PATH}/xargs"
  "${DOVE_LN}" -sf "${DOVE_XML2_CONFIG}" "${DOVE_PATH}/xml2-config"
  "${DOVE_LN}" -sf "${DOVE_XSLT_CONFIG}" "${DOVE_PATH}/xslt-config"
  "${DOVE_LN}" -sf "${DOVE_XZ}" "${DOVE_PATH}/xz"
  "${DOVE_LN}" -sf "${DOVE_ZIP}" "${DOVE_PATH}/zip"

  # OS X-specific
  if [[ "${DOVE_PLATFORM}" == 'darwin' ]]; then
    "${DOVE_LN}" -sf "${DOVE_DOT_CLEAN}" "${DOVE_PATH}/dot_clean"
    "${DOVE_LN}" -sf "${DOVE_XCRUN}" "${DOVE_PATH}/xcrun"
  else
    "${DOVE_LN}" -sf "${DOVE_ASSEMBLER}" "${DOVE_PATH}/as"
    "${DOVE_LN}" -sf "${DOVE_CC}" "${DOVE_PATH}/cc"
    "${DOVE_LN}" -sf "${DOVE_LD}" "${DOVE_PATH}/ld"
  fi

  "${DOVE_LN}" -sf '/bin/bash' "${DOVE_PATH}/bash"

  readonly PATH="${DOVE_PATH}"
  export PATH
}

# Set-up a minimal PATH for linting
function setup_lint_path() {
  "${DOVE_RM}" -rf "${DOVE_LINT_PATH}"
  "${DOVE_MKDIR}" -p "${DOVE_LINT_PATH}"

  "${DOVE_LN}" -sf "${DOVE_GIT}" "${DOVE_LINT_PATH}/git"
  "${DOVE_LN}" -sf "${DOVE_SHELLCHECK}" "${DOVE_LINT_PATH}/shellcheck"
  "${DOVE_LN}" -sf "${DOVE_SHFMT}" "${DOVE_LINT_PATH}/shfmt"

  readonly PATH="${DOVE_LINT_PATH}"
  export PATH
}

if [[ -z "${DOVE_SET_ENVS+x}" ]]; then
  source "$(dirname $0)/env_local.sh"

  # Set-up our PATH
  if [[ -z "${DOVE_LINTING+x}" ]]; then
    setup_path
  else
    setup_lint_path
  fi
fi
