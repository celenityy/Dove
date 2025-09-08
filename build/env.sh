#!/usr/bin/env bash

# Where Phoenix is located
if [ -z ${phoenix_dir+x} ]; then 
    # default value if unset
    export phoenix_dir=~/Projects/Phoenix
fi

# Version of Dove you'd like to build
export dove_version=2025.08.06.1

# Version of uBlock Origin
export ubo_version=1.66.0

# Where `Dove` (this repo) is located
export dove_dir=$(dirname $(dirname "$(realpath "$0")"))

# Where the `linux` directory is located
export dove_linux_dir="$dove_dir/linux"

# Where the `linux-flatpak` directory is located
export dove_linux_flatpak_dir="$dove_dir/linux-flatpak"

# Where the `macos` directory is located
export dove_osx_dir="$dove_dir/macos"

# Where the `macos-intel` directory is located
export dove_osx_intel_dir="$dove_dir/macos-intel"

# Where the `windows` directory is located
export dove_windows_dir="$dove_dir/windows"

# Use GNU Sed on macOS instead of the built-in sed, due to differences in syntax
if [[ "$OSTYPE" == "darwin"* ]]; then
    SED=gsed
else
    SED=sed
fi
