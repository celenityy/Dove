
# Set platform
if [[ "${OSTYPE}" == "darwin"* ]]; then
    readonly DOVE_PLATFORM='darwin'
else
    readonly DOVE_PLATFORM='linux'
fi
export DOVE_PLATFORM

# Set OS
if [[ "${DOVE_PLATFORM}" == 'darwin' ]]; then
    readonly DOVE_OS='osx'
elif [[ "${DOVE_PLATFORM}" == 'linux' ]]; then
    if [[ -f "/etc/os-release" ]]; then
        source /etc/os-release
        if [[ -n "${ID}" ]]; then
            readonly DOVE_OS="${ID}"
        else
            readonly DOVE_OS='unknown'
        fi
    else
        readonly DOVE_OS='unknown'
    fi
else
    readonly DOVE_OS='unknown'
fi
export DOVE_OS
