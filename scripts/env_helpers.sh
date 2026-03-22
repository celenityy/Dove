
# Set platform
if [[ "${OSTYPE}" == "darwin"* ]]; then
    readonly export DOVE_PLATFORM='darwin'
else
    readonly export DOVE_PLATFORM='linux'
fi

# Set OS
if [[ "${DOVE_PLATFORM}" == 'darwin' ]]; then
    readonly export DOVE_OS='osx'
elif [[ "${DOVE_PLATFORM}" == 'linux' ]]; then
    if [[ -f "/etc/os-release" ]]; then
        source /etc/os-release
        if [[ -n "${ID}" ]]; then
            readonly export DOVE_OS="${ID}"
        else
            readonly export DOVE_OS='unknown'
        fi
    else
        readonly export DOVE_OS='unknown'
    fi
else
    readonly export DOVE_OS='unknown'
fi
