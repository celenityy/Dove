
# Set platform
if [[ "${OSTYPE}" == "darwin"* ]]; then
    export DOVE_PLATFORM='darwin'
else
    export DOVE_PLATFORM='linux'
fi

# Set OS
if [[ "${DOVE_PLATFORM}" == 'darwin' ]]; then
    export DOVE_OS='osx'
elif [[ "${DOVE_PLATFORM}" == 'linux' ]]; then
    if [[ -f "/etc/os-release" ]]; then
        source /etc/os-release
        if [[ -n "${ID}" ]]; then
            export DOVE_OS="${ID}"
        else
            export DOVE_OS='unknown'
        fi
    else
        export DOVE_OS='unknown'
    fi
else
    export DOVE_OS='unknown'
fi
