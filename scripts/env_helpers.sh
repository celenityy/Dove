# shellcheck shell=bash

# Set our platform/OS
function set_platform() {
  # Set platform
  unset DOVE_PLATFORM
  unset DOVE_PLATFORM_PRETTY

  # First, leverage `PHOENIX_HOST_PLATFORM`
  if [[ -n "${PHOENIX_HOST_PLATFORM+x}" ]]; then
    if [[ "${PHOENIX_HOST_PLATFORM}" == 'android' ]] || [[ "${PHOENIX_HOST_PLATFORM}" == 'linux' ]]; then
      readonly DOVE_PLATFORM='linux'
    elif [[ "${PHOENIX_HOST_PLATFORM}" == 'osx' ]] || [[ "${PHOENIX_HOST_PLATFORM}" == 'osx-intel' ]]; then
      readonly DOVE_PLATFORM='darwin'
    elif [[ "${PHOENIX_HOST_PLATFORM}" == 'windows' ]]; then
      readonly DOVE_PLATFORM='windows'
    fi
  fi

  # Check `OSTYPE`
  if [[ -z "${DOVE_PLATFORM+x}" ]] && [[ -n "${OSTYPE+x}" ]]; then
    if [[ "${OSTYPE}" == 'cygwin' ]] || [[ "${OSTYPE}" == 'msys' ]] || [[ "${OSTYPE}" == 'win32' ]]; then
      readonly DOVE_PLATFORM='windows'
    elif [[ "${OSTYPE}" == "darwin"* ]]; then
      readonly DOVE_PLATFORM='darwin'
    elif [[ "${OSTYPE}" == 'linux-android' ]] || [[ "${OSTYPE}" == 'linux-gnu' ]]; then
      readonly DOVE_PLATFORM='linux'
    fi
  fi

  # Check `OS`
  if [[ -z "${DOVE_PLATFORM+x}" ]] && [[ -n "${OS+x}" ]] && [[ "${OS}" == 'Windows_NT' ]]; then
    readonly DOVE_PLATFORM='windows'
  fi

  # Not much else we can do :(
  if [[ -z "${DOVE_PLATFORM+x}" ]]; then
    readonly DOVE_PLATFORM='unknown'
  fi

  if [[ "${DOVE_PLATFORM}" == 'darwin' ]]; then
    readonly DOVE_PLATFORM_PRETTY='Darwin'
  elif [[ "${DOVE_PLATFORM}" == 'linux' ]]; then
    readonly DOVE_PLATFORM_PRETTY='Linux'
  elif [[ "${DOVE_PLATFORM}" == 'windows' ]]; then
    readonly DOVE_PLATFORM_PRETTY='Windows'
  elif [[ "${DOVE_PLATFORM}" == 'unknown' ]]; then
    readonly DOVE_PLATFORM_PRETTY='Unknown'
  else
    echo "ERROR: Invalid platform: '${DOVE_PLATFORM}'!"
    return 1
  fi

  # Set OS
  unset DOVE_OS
  unset DOVE_OS_PRETTY

  if [[ "${DOVE_PLATFORM}" == 'darwin' ]]; then
    readonly DOVE_OS='osx'
  elif [[ "${DOVE_PLATFORM}" == 'windows' ]]; then
    readonly DOVE_OS='windows'
  elif [[ "${DOVE_PLATFORM}" == 'linux' ]]; then
    # First, we can check for Android with `PHOENIX_HOST_PLATFORM`
    if [[ -n "${PHOENIX_HOST_PLATFORM+x}" ]] && [[ "${PHOENIX_HOST_PLATFORM}" == 'android' ]]; then
      readonly DOVE_OS='android'
    fi

    # We can also check for Android with `OSTYPE`
    if [[ -z "${DOVE_OS+x}" ]] && [[ -n "${OSTYPE+x}" ]] && [[ "${OSTYPE}" == 'linux-android' ]]; then
      readonly DOVE_OS='android'
    fi

    # Otherwise, we fall back to `/etc/os-release`
    if [[ -z "${DOVE_OS+x}" ]] && [[ -f '/etc/os-release' ]] && [[ -s '/etc/os-release' ]]; then
      source '/etc/os-release'
      if [[ -n "${ID+x}" ]]; then
        readonly DOVE_OS="${ID+x}"
      fi
    fi
  fi

  # Not much else we can do :(
  if [[ -z "${DOVE_OS+x}" ]]; then
    readonly DOVE_OS='unknown'
  fi

  if [[ "${DOVE_OS}" == 'android' ]]; then
    readonly DOVE_OS_PRETTY='Android'
  elif [[ "${DOVE_OS}" == 'fedora' ]]; then
    readonly DOVE_OS_PRETTY='Fedora'
  elif [[ "${DOVE_OS}" == 'osx' ]]; then
    readonly DOVE_OS_PRETTY='OS X'
  elif [[ "${DOVE_OS}" == 'secureblue' ]]; then
    readonly DOVE_OS_PRETTY='Secureblue'
  elif [[ "${DOVE_OS}" == 'ubuntu' ]]; then
    readonly DOVE_OS_PRETTY='Ubuntu'
  elif [[ "${DOVE_OS}" == 'windows' ]]; then
    readonly DOVE_OS_PRETTY='Windows'
  elif [[ "${DOVE_OS}" == 'unknown' ]]; then
    readonly DOVE_OS_PRETTY='Unknown'
  elif [[ "${DOVE_PLATFORM}" == 'linux' ]] && [[ -n "${ID+x}" ]]; then
    readonly DOVE_OS_PRETTY="${DOVE_OS}"
  else
    echo "ERROR: Invalid operating system: '${DOVE_OS}'!"
    return 1
  fi
}

# Set our architecture
function set_arch() {
  unset DOVE_PLATFORM_ARCH
  unset DOVE_PLATFORM_ARCH_PRETTY

  # First, if we're on OS X, we can actually try `PHOENIX_HOST_PLATFORM`
  if [[ "${DOVE_PLATFORM}" == 'darwin' ]] && [[ -n "${PHOENIX_HOST_PLATFORM+x}" ]]; then
    if [[ "${PHOENIX_HOST_PLATFORM}" == 'osx-intel' ]]; then
      readonly DOVE_PLATFORM_ARCH='x86_64'
    elif [[ "${PHOENIX_HOST_PLATFORM}" == 'osx' ]]; then
      readonly DOVE_PLATFORM_ARCH='arm64'
    fi
  fi

  if [[ -z "${DOVE_PLATFORM_ARCH+x}" ]]; then
    # Find uname
    if [[ -n "${DOVE_UNAME+x}" ]] && [[ -x "${DOVE_UNAME}" ]]; then
      local -r uname="${DOVE_UNAME}"
    elif [[ -x '/bin/uname' ]]; then
      local -r uname='/bin/uname'
    elif [[ -x '/usr/bin/uname' ]]; then
      local -r uname='/usr/bin/uname'
    else
      if ! command -v uname > /dev/null 2>&1; then
        echo "ERROR: Missing uname!" >&2
        return 1
      fi
      # It isn't a known location, so we sadly have to just fall-back to the PATH
      local -r uname="$(uname)"
    fi

    # Set architecture
    local -r arch=$("${uname}" -m)
    if [[ "${arch}" == 'aarch64' ]] || [[ "${arch}" == 'aarch64_be' ]] || [[ "${arch}" == 'arm64' ]] || [[ "${arch}" == 'armv8b' ]] ||
      [[ "${arch}" == 'armv8l' ]]; then
      readonly DOVE_PLATFORM_ARCH='arm64'
    elif [[ "${arch}" == 'amd64' ]] || [[ "${arch}" == 'x86_64' ]] || [[ "${arch}" == 'x86_64-AT386' ]]; then
      readonly DOVE_PLATFORM_ARCH='x86_64'
    elif [[ "${arch}" == 'armv4t' ]]; then
      readonly DOVE_PLATFORM_ARCH='armv4'
    elif [[ "${arch}" == 'armv5t' ]] || [[ "${arch}" == 'armv5te' ]]; then
      readonly DOVE_PLATFORM_ARCH='armv5'
    elif [[ "${arch}" == 'armv6' ]] || [[ "${arch}" == 'armv6j' ]] || [[ "${arch}" == 'armv6k' ]] || [[ "${arch}" == 'armv6kz' ]] ||
      [[ "${arch}" == 'armv6l' ]] || [[ "${arch}" == 'armv6t2' ]] || [[ "${arch}" == 'armv6z' ]] || [[ "${arch}" == 'armv6zk' ]]; then
      readonly DOVE_PLATFORM_ARCH='armv6'
    elif [[ "${arch}" == 'armv7' ]] || [[ "${arch}" == 'armv7l' ]] || [[ "${arch}" == 'armv7ve' ]]; then
      readonly DOVE_PLATFORM_ARCH='arm'
    elif [[ "${arch}" == 'i386' ]] || [[ "${arch}" == 'i386-AT38621' ]]; then
      readonly DOVE_PLATFORM_ARCH='i386'
    elif [[ "${arch}" == 'i486' ]] || [[ "${arch}" == 'i486-AT38621' ]]; then
      readonly DOVE_PLATFORM_ARCH='i486'
    elif [[ "${arch}" == 'i586' ]] || [[ "${arch}" == 'i586-AT38621' ]]; then
      readonly DOVE_PLATFORM_ARCH='i586'
    elif [[ "${arch}" == 'i686' ]] || [[ "${arch}" == 'i686-64' ]] || [[ "${arch}" == 'i686-AT386' ]] || [[ "${arch}" == 'i686-AT38621' ]] ||
      [[ "${arch}" == 'i86pc' ]] || [[ "${arch}" == 'x86' ]] || [[ "${arch}" == 'x86pc' ]]; then
      readonly DOVE_PLATFORM_ARCH='x86'
    elif [[ "${arch}" == 'ppc' ]] || [[ "${arch}" == 'ppcle' ]]; then
      readonly DOVE_PLATFORM_ARCH='ppc'
    elif [[ "${arch}" == 'ppc64' ]] || [[ "${arch}" == 'ppc64le' ]]; then
      readonly DOVE_PLATFORM_ARCH='ppc64'
    elif [[ "${arch}" == 'riscv64' ]]; then
      readonly DOVE_PLATFORM_ARCH='riscv'
    elif [[ "${arch}" == 's390' ]] || [[ "${arch}" == 's390x' ]]; then
      readonly DOVE_PLATFORM_ARCH='s390x'
    fi
  fi

  # Not much else we can do :(
  if [[ -z "${DOVE_PLATFORM_ARCH+x}" ]]; then
    readonly DOVE_PLATFORM_ARCH='unknown'
  fi

  if [[ "${DOVE_PLATFORM_ARCH}" == 'arm' ]]; then
    readonly DOVE_PLATFORM_ARCH_PRETTY='ARM'
  elif [[ "${DOVE_PLATFORM_ARCH}" == 'arm64' ]]; then
    readonly DOVE_PLATFORM_ARCH_PRETTY='ARM64'
  elif [[ "${DOVE_PLATFORM_ARCH}" == 'armv4' ]]; then
    readonly DOVE_PLATFORM_ARCH_PRETTY='ARMv4'
  elif [[ "${DOVE_PLATFORM_ARCH}" == 'armv5' ]]; then
    readonly DOVE_PLATFORM_ARCH_PRETTY='ARMv5'
  elif [[ "${DOVE_PLATFORM_ARCH}" == 'armv6' ]]; then
    readonly DOVE_PLATFORM_ARCH_PRETTY='ARMv6'
  elif [[ "${DOVE_PLATFORM_ARCH}" == 'ppc' ]]; then
    readonly DOVE_PLATFORM_ARCH_PRETTY='PPC'
  elif [[ "${DOVE_PLATFORM_ARCH}" == 'ppc64' ]]; then
    readonly DOVE_PLATFORM_ARCH_PRETTY='PPC64'
  elif [[ "${DOVE_PLATFORM_ARCH}" == 'riscv' ]]; then
    readonly DOVE_PLATFORM_ARCH_PRETTY='RISC-V'
  elif [[ "${DOVE_PLATFORM_ARCH}" == 'i386' ]] || [[ "${DOVE_PLATFORM_ARCH}" == 'i486' ]] || [[ "${DOVE_PLATFORM_ARCH}" == 'i586' ]] ||
    [[ "${DOVE_PLATFORM_ARCH}" == 's390x' ]] || [[ "${DOVE_PLATFORM_ARCH}" == 'x86' ]] || [[ "${DOVE_PLATFORM_ARCH}" == 'x86_64' ]]; then
    readonly DOVE_PLATFORM_ARCH_PRETTY="${DOVE_PLATFORM_ARCH}"
  elif [[ "${DOVE_PLATFORM_ARCH}" == 'unknown' ]]; then
    readonly DOVE_PLATFORM_ARCH_PRETTY='Unknown'
  else
    echo "ERROR: Invalid architecture: '${DOVE_PLATFORM_ARCH}'!"
    return 1
  fi
}

# Set our platform/OS
set_platform || return 1

# Set our architecture
set_arch || return 1

echo "Detected platform:         '${DOVE_PLATFORM_PRETTY}'"
echo "Detected operating system: '${DOVE_OS_PRETTY}'"
echo "Detected architecture:     '${DOVE_PLATFORM_ARCH_PRETTY}'"
