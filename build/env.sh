#!/usr/bin/env bash

# Where Phoenix is located
if [ -z ${phoenix_dir+x} ]; then 
    # default value if unset
    export phoenix_dir=~/Projects/Phoenix
fi

# Version of Dove you'd like to build
export dove_version=2025.06.02.1

# Where `Dove` (this repo) is located
export dove_dir=$(dirname $(dirname "$(realpath "$0")"))

# Where the `linux` directory is located
export dove_linux_dir="$dove_dir/linux"

# Where the `macos` directory is located
export dove_osx_dir="$dove_dir/macos"

# Where the `windows` directory is located
export dove_windows_dir="$dove_dir/windows"
