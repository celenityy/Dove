# Dove external environment variables

## This is used for converting Dove-specific environment variables to ones used in external projects.

## CAUTION: Do NOT source this directly!
## Source 'env.sh' instead.

## CAUTION: Do NOT try to configure any of these environment variables directly!
## Use the Dove equivalent variables (at `env_common.sh`) instead.

# Phoenix
readonly PHOENIX_ANDROID=0
readonly PHOENIX_AWK="${DOVE_AWK}"
readonly PHOENIX_CIPHERS="${DOVE_CIPHERS}"
readonly PHOENIX_CURL_FLAGS="${DOVE_CURL_FLAGS}"
readonly PHOENIX_CURL_FLAGS_OVERRIDE=1
readonly PHOENIX_EXTENDED=1
readonly PHOENIX_MAIL=1
readonly PHOENIX_NIX="${DOVE_NIX}"
readonly PHOENIX_PYENV_DIR="${DOVE_PYENV_DIR}"
readonly PHOENIX_PYTHON="${DOVE_PYTHON}"
readonly PHOENIX_PYTHON_DIR="${DOVE_PYTHON_DIR}"
readonly PHOENIX_SED="${DOVE_SED}"
readonly PHOENIX_STATIC_JS="${DOVE_STATIC_JS}"
readonly PHOENIX_TAR="${DOVE_TAR}"
readonly PHOENIX_UV_CACHE="${DOVE_UV_CACHE}"
readonly PHOENIX_UV_DIR="${DOVE_UV_DIR}"
readonly PHOENIX_UV_LOCAL="${DOVE_UV_LOCAL}"
readonly PHOENIX_UV_PYTHON="${DOVE_UV_PYTHON}"
readonly PHOENIX_UV_TOOLS="${DOVE_UV_TOOLS}"
export PHOENIX_ANDROID
export PHOENIX_AWK
export PHOENIX_CIPHERS
export PHOENIX_CURL_FLAGS
export PHOENIX_CURL_FLAGS_OVERRIDE
export PHOENIX_EXTENDED
export PHOENIX_MAIL
export PHOENIX_NIX
export PHOENIX_PYENV_DIR
export PHOENIX_PYTHON
export PHOENIX_PYTHON_DIR
export PHOENIX_SED
export PHOENIX_STATIC_JS
export PHOENIX_TAR
export PHOENIX_UV_CACHE
export PHOENIX_UV_DIR
export PHOENIX_UV_LOCAL
export PHOENIX_UV_PYTHON
export PHOENIX_UV_TOOLS

readonly PHOENIX_EXTRA_CFG="${DOVE_TEMP}/dove-parsed.cfg"
export PHOENIX_EXTRA_CFG

readonly PHOENIX_OVERRIDES_CFG="${DOVE_ROOT}/phoenix-overrides.cfg"
export PHOENIX_OVERRIDES_CFG

readonly PHOENIX_EXTRA_POLICIES="${DOVE_ROOT}/policies/dove-core.json"
readonly PHOENIX_EXTRA_POLICIES_LINUX="${DOVE_ROOT}/policies/dove-linux.json"
readonly PHOENIX_EXTRA_POLICIES_LINUX_NONFLATPAK="${DOVE_ROOT}/policies/dove-linux-nonflatpak.json"
readonly PHOENIX_EXTRA_POLICIES_LINUX_FLATPAK="${DOVE_ROOT}/policies/dove-linux-flatpak.json"
readonly PHOENIX_EXTRA_POLICIES_OSX="${DOVE_ROOT}/policies/dove-osx.json"
readonly PHOENIX_EXTRA_POLICIES_OSX_INTEL="${DOVE_ROOT}/policies/dove-osx-intel.json"
readonly PHOENIX_EXTRA_POLICIES_OSX_SILICON="${DOVE_ROOT}/policies/dove-osx-silicon.json"
readonly PHOENIX_EXTRA_POLICIES_WINDOWS="${DOVE_ROOT}/policies/dove-windows.json"
export PHOENIX_EXTRA_POLICIES
export PHOENIX_EXTRA_POLICIES_LINUX
export PHOENIX_EXTRA_POLICIES_LINUX_NONFLATPAK
export PHOENIX_EXTRA_POLICIES_LINUX_FLATPAK
export PHOENIX_EXTRA_POLICIES_OSX
export PHOENIX_EXTRA_POLICIES_OSX_INTEL
export PHOENIX_EXTRA_POLICIES_OSX_SILICON
export PHOENIX_EXTRA_POLICIES_WINDOWS

readonly PHOENIX_LINUX_ONLY="${DOVE_LINUX_ONLY}"
readonly PHOENIX_LINUX_FLATPAK_ONLY="${DOVE_LINUX_FLATPAK_ONLY}"
readonly PHOENIX_OSX_ONLY="${DOVE_OSX_ONLY}"
readonly PHOENIX_OSX_INTEL_ONLY="${DOVE_OSX_INTEL_ONLY}"
readonly PHOENIX_WINDOWS_ONLY="${DOVE_WINDOWS_ONLY}"
export PHOENIX_LINUX_ONLY
export PHOENIX_LINUX_FLATPAK_ONLY
export PHOENIX_OSX_ONLY
export PHOENIX_OSX_INTEL_ONLY
export PHOENIX_WINDOWS_ONLY

readonly PHOENIX_LINUX="${DOVE_LINUX}"
readonly PHOENIX_LINUX_FLATPAK="${DOVE_LINUX_FLATPAK}"
readonly PHOENIX_OSX="${DOVE_OSX}"
readonly PHOENIX_OSX_INTEL="${DOVE_OSX_INTEL}"
readonly PHOENIX_WINDOWS="${DOVE_WINDOWS}"
export PHOENIX_LINUX
export PHOENIX_LINUX_FLATPAK
export PHOENIX_OSX
export PHOENIX_OSX_INTEL
export PHOENIX_WINDOWS

## Disable build logging, as it's redundant with our own build log
readonly PHOENIX_LOG_BUILD=0
export PHOENIX_LOG_BUILD

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

# UV
## https://docs.astral.sh/uv/reference/environment/

## Cache directory
export UV_CACHE_DIR="${DOVE_UV_LOCAL}/cache"

## Disable cache
export UV_NO_CACHE=1

## Disable the system CA root store
export UV_SYSTEM_CERTS='false'

## Exclude development dependencies
export UV_NO_DEV=1

## Executables directory
export UV_PYTHON_BIN_DIR="${DOVE_UV_LOCAL}/bin"
export UV_PYTHON_INSTALL_BIN=1

## Ignore configuration files
export UV_NO_CONFIG=1

## Ignore env files
export UV_NO_ENV_FILE=1

## Location
export UV_INSTALL_DIR="${DOVE_UV_DIR}"

## Prevent automatic downloads/updates
export UV_DISABLE_UPDATE=1
export UV_PYTHON_DOWNLOADS='manual'

## Prevent modifying the system PATH
export INSTALLER_NO_MODIFY_PATH=1
export UV_NO_MODIFY_PATH=1
export UV_UNMANAGED_INSTALL="${DOVE_UV_DIR}"

## Prevent using the system Python
export UV_MANAGED_PYTHON=1
export UV_PYTHON_NO_REGISTRY=1
export UV_SYSTEM_PYTHON='false'

## Python
export UV_PYTHON_CACHE_DIR="${DOVE_UV_LOCAL}/python-cache"
export UV_PYTHON_INSTALL_MIRROR="file://${DOVE_PYTHON_DIR}"
export UV_PYTHON_INSTALL_DIR="${DOVE_UV_LOCAL}/python"

## Python environment
export UV_PROJECT_ENVIRONMENT="${DOVE_PYENV_DIR}"
export VIRTUAL_ENV="${DOVE_PYENV_DIR}"

## Tools directory
export UV_TOOL_BIN_DIR="${DOVE_UV_LOCAL}/tools/bin"
export UV_TOOL_DIR="${DOVE_UV_LOCAL}/tools"

# Include version info
source "${DOVE_VERSIONS}"

## Pin Python version
export UV_PYTHON_CPYTHON_BUILD="${PYTHON_GIT_RELEASE}"
