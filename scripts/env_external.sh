# shellcheck shell=bash
# Dove external environment variables

## This is used for converting Dove-specific environment variables to ones used in external projects.

## CAUTION: Do NOT source this directly!
## Source 'env.sh' instead.

## CAUTION: Do NOT try to configure any of these environment variables directly!
## Use the Dove equivalent variables (at `env_common.sh`) instead.

# Compiler flags
## (Used by lxml)
readonly CFLAGS="${DOVE_COMPILER_FLAGS}"
readonly CPPFLAGS="${DOVE_COMPILER_FLAGS}"
readonly CXXFLAGS="${DOVE_COMPILER_FLAGS}"
readonly HOST_CFLAGS="${DOVE_COMPILER_FLAGS}"
readonly HOST_CPPFLAGS="${DOVE_COMPILER_FLAGS}"
readonly HOST_CXXFLAGS="${DOVE_COMPILER_FLAGS}"
readonly TARGET_CFLAGS="${DOVE_COMPILER_FLAGS}"
readonly TARGET_CXXFLAGS="${DOVE_COMPILER_FLAGS}"
export CFLAGS
export CPPFLAGS
export CXXFLAGS
export HOST_CFLAGS
export HOST_CPPFLAGS
export HOST_CXXFLAGS
export TARGET_CFLAGS
export TARGET_CXXFLAGS

# Phoenix
readonly PHOENIX_ANDROID=0
readonly PHOENIX_AWK="${DOVE_AWK}"
readonly PHOENIX_BASENAME="${DOVE_BASENAME}"
readonly PHOENIX_CAT="${DOVE_CAT}"
readonly PHOENIX_CHMOD="${DOVE_CHMOD}"
readonly PHOENIX_CP="${DOVE_CP}"
readonly PHOENIX_CURL="${DOVE_CURL}"
readonly PHOENIX_CURL_FLAGS="${DOVE_CURL_FLAGS}"
readonly PHOENIX_CURL_FLAGS_OVERRIDE=1
readonly PHOENIX_DATE="${DOVE_DATE}"
readonly PHOENIX_DIRNAME="${DOVE_DIRNAME}"
readonly PHOENIX_DOT_CLEAN="${DOVE_DOT_CLEAN}"
readonly PHOENIX_ECHO="${DOVE_ECHO}"
readonly PHOENIX_EXTENDED=1
readonly PHOENIX_FIND="${DOVE_FIND}"
readonly PHOENIX_GIT="${DOVE_GIT}"
readonly PHOENIX_GREP="${DOVE_GREP}"
readonly PHOENIX_GZIP="${DOVE_GZIP}"
readonly PHOENIX_HARDCODE_PLATFORM="${DOVE_HARDCODE_PLATFORM}"
readonly PHOENIX_HEAD="${DOVE_HEAD}"
readonly PHOENIX_JQ="${DOVE_JQ}"
readonly PHOENIX_LN="${DOVE_LN}"
readonly PHOENIX_LS="${DOVE_LS}"
readonly PHOENIX_MAIL=1
readonly PHOENIX_MD5SUM="${DOVE_MD5SUM}"
readonly PHOENIX_MKDIR="${DOVE_MKDIR}"
readonly PHOENIX_NIX="${DOVE_NIX}"
readonly PHOENIX_NONTLS13_CIPHERS="${DOVE_NONTLS13_CIPHERS}"
readonly PHOENIX_PYENV_DIR="${DOVE_PYENV_DIR}"
readonly PHOENIX_PYTHON="${DOVE_PYTHON}"
readonly PHOENIX_PYTHON_DIR="${DOVE_PYTHON_DIR}"
readonly PHOENIX_RM="${DOVE_RM}"
readonly PHOENIX_SED="${DOVE_SED}"
readonly PHOENIX_SHA1SUM="${DOVE_SHA1SUM}"
readonly PHOENIX_SHA256SUM="${DOVE_SHA256SUM}"
readonly PHOENIX_SHA512SUM="${DOVE_SHA512SUM}"
readonly PHOENIX_STATIC_JS="${DOVE_STATIC_JS}"
readonly PHOENIX_TAR="${DOVE_TAR}"
readonly PHOENIX_TEE="${DOVE_TEE}"
readonly PHOENIX_TLS13_CIPHERS="${DOVE_TLS13_CIPHERS}"
readonly PHOENIX_TOUCH="${DOVE_TOUCH}"
readonly PHOENIX_UNAME="${DOVE_UNAME}"
readonly PHOENIX_UNZIP="${DOVE_UNZIP}"
readonly PHOENIX_UV_CACHE="${DOVE_UV_CACHE}"
readonly PHOENIX_UV_DIR="${DOVE_UV_DIR}"
readonly PHOENIX_UV_LOCAL="${DOVE_UV_LOCAL}"
readonly PHOENIX_UV_PYTHON="${DOVE_UV_PYTHON}"
readonly PHOENIX_UV_TOOLS="${DOVE_UV_TOOLS}"
readonly PHOENIX_VERBOSE="${DOVE_VERBOSE}"
readonly PHOENIX_XARGS="${DOVE_XARGS}"
readonly PHOENIX_XZ="${DOVE_XZ}"
readonly PHOENIX_ZIP="${DOVE_ZIP}"
export PHOENIX_ANDROID
export PHOENIX_AWK
export PHOENIX_BASENAME
export PHOENIX_CAT
export PHOENIX_CHMOD
export PHOENIX_CP
export PHOENIX_CURL
export PHOENIX_CURL_FLAGS
export PHOENIX_CURL_FLAGS_OVERRIDE
export PHOENIX_DATE
export PHOENIX_DIRNAME
export PHOENIX_DOT_CLEAN
export PHOENIX_ECHO
export PHOENIX_EXTENDED
export PHOENIX_FIND
export PHOENIX_GIT
export PHOENIX_GREP
export PHOENIX_GZIP
export PHOENIX_HARDCODE_PLATFORM
export PHOENIX_HEAD
export PHOENIX_JQ
export PHOENIX_LN
export PHOENIX_LS
export PHOENIX_MAIL
export PHOENIX_MD5SUM
export PHOENIX_MKDIR
export PHOENIX_NIX
export PHOENIX_NONTLS13_CIPHERS
export PHOENIX_PYENV_DIR
export PHOENIX_PYTHON
export PHOENIX_PYTHON_DIR
export PHOENIX_RM
export PHOENIX_SED
export PHOENIX_SHA1SUM
export PHOENIX_SHA256SUM
export PHOENIX_SHA512SUM
export PHOENIX_STATIC_JS
export PHOENIX_TAR
export PHOENIX_TEE
export PHOENIX_TLS13_CIPHERS
export PHOENIX_TOUCH
export PHOENIX_UNAME
export PHOENIX_UNZIP
export PHOENIX_UV_CACHE
export PHOENIX_UV_DIR
export PHOENIX_UV_LOCAL
export PHOENIX_UV_PYTHON
export PHOENIX_UV_TOOLS
export PHOENIX_VERBOSE
export PHOENIX_XARGS
export PHOENIX_XZ
export PHOENIX_ZIP

readonly PHOENIX_EXTRA_CFG="${DOVE_TEMP}/dove-parsed.cfg"
export PHOENIX_EXTRA_CFG

readonly PHOENIX_OVERRIDES_CFG="${DOVE_ROOT}/phoenix-overrides.cfg"
export PHOENIX_OVERRIDES_CFG

readonly PHOENIX_EXTRA_POLICIES="${DOVE_ROOT}/policies/dove-core.json"
export PHOENIX_EXTRA_POLICIES

## Disable build logging, as it's redundant with our own build log
readonly PHOENIX_LOG_BUILD=0
export PHOENIX_LOG_BUILD

## We produce our own archives
readonly PHOENIX_PRODUCE_ARCHIVES=0
export PHOENIX_PRODUCE_ARCHIVES

# Python
## https://docs.python.org/3/using/cmdline.html#environment-variables

## Disable JIT
readonly PYTHON_JIT=0
readonly PYTHON_PERF_JIT_SUPPORT=0
export PYTHON_JIT
export PYTHON_PERF_JIT_SUPPORT

## Disable remote debugging
readonly PYTHON_DISABLE_REMOTE_DEBUG=1
export PYTHON_DISABLE_REMOTE_DEBUG

## Enable performance optimizations
readonly PYTHONOPTIMIZE=1
export PYTHONOPTIMIZE

# s3cmd

## Avoid installing manual pages/doc files
### https://github.com/s3tools/s3cmd/blob/master/INSTALL.md#note-to-distributions-package-maintainers
readonly S3CMD_PACKAGING='yes'
export S3CMD_PACKAGING

# uv
## https://docs.astral.sh/uv/reference/environment/

## Cache directory
readonly UV_CACHE_DIR="${DOVE_UV_LOCAL}/cache"
export UV_CACHE_DIR

## Disable cache
readonly UV_NO_CACHE=1
export UV_NO_CACHE

## Disable the system CA root store
readonly UV_SYSTEM_CERTS='false'
export UV_SYSTEM_CERTS

## Exclude development dependencies
readonly UV_NO_DEV=1
export UV_NO_DEV

## Executables directory
readonly UV_PYTHON_BIN_DIR="${DOVE_UV_LOCAL}/bin"
readonly UV_PYTHON_INSTALL_BIN=1
export UV_PYTHON_BIN_DIR
export UV_PYTHON_INSTALL_BIN

## Ignore configuration files
readonly UV_NO_CONFIG=1
readonly UV_NO_SYSTEM_CONFIG=1
export UV_NO_CONFIG
export UV_NO_SYSTEM_CONFIG

## Ignore env files
readonly UV_NO_ENV_FILE=1
export UV_NO_ENV_FILE

## Location
readonly UV_INSTALL_DIR="${DOVE_UV_DIR}"
export UV_INSTALL_DIR

## Prevent automatic downloads/updates
readonly UV_DISABLE_UPDATE=1
readonly UV_PYTHON_DOWNLOADS='manual'
export UV_DISABLE_UPDATE
export UV_PYTHON_DOWNLOADS

## Prevent modifying the system PATH
readonly INSTALLER_NO_MODIFY_PATH=1
readonly UV_NO_MODIFY_PATH=1
readonly UV_UNMANAGED_INSTALL="${DOVE_UV_DIR}"
export INSTALLER_NO_MODIFY_PATH
export UV_NO_MODIFY_PATH
export UV_UNMANAGED_INSTALL

## Prevent using the system Python
readonly UV_MANAGED_PYTHON=1
readonly UV_PYTHON_NO_REGISTRY=1
readonly UV_SYSTEM_PYTHON='false'
export UV_MANAGED_PYTHON
export UV_PYTHON_NO_REGISTRY
export UV_SYSTEM_PYTHON

## Python
readonly UV_PYTHON_CACHE_DIR="${DOVE_UV_LOCAL}/python-cache"
readonly UV_PYTHON_INSTALL_MIRROR="file://${DOVE_PYTHON_DIR}"
readonly UV_PYTHON_INSTALL_DIR="${DOVE_UV_LOCAL}/python"
export UV_PYTHON_CACHE_DIR
export UV_PYTHON_INSTALL_MIRROR
export UV_PYTHON_INSTALL_DIR

## Python environment
readonly UV_PROJECT_ENVIRONMENT="${DOVE_PYENV_DIR}"
VIRTUAL_ENV="${DOVE_PYENV_DIR}"
export UV_PROJECT_ENVIRONMENT
export VIRTUAL_ENV

## Tools directory
readonly UV_TOOL_BIN_DIR="${DOVE_UV_LOCAL}/tools/bin"
readonly UV_TOOL_DIR="${DOVE_UV_LOCAL}/tools"
export UV_TOOL_BIN_DIR
export UV_TOOL_DIR

# Include version info
source "${DOVE_VERSIONS}"

## Pin Python version
readonly UV_PYTHON_CPYTHON_BUILD="${DOVE_PYTHON_GIT_RELEASE}"
export UV_PYTHON_CPYTHON_BUILD
