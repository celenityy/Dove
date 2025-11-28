#!/usr/bin/env bash

set -e

# This is a basic script used to create the .zip files you see in the 'archives' directory.
# We could just clone the entire source code - though lots of of it are completely unnecessary for packaging.
# This creates a slim .zip file only containing what we actually need.

# Script should be ran from inside the directory where you store Dove, not directly from the 'archives' or `build` folder...

echo_green_text() {
	echo -e "\033[32m$1\033[0m"
}

rm -rf archives/*

if [[ "$OSTYPE" == "darwin"* ]]; then
    /usr/sbin/dot_clean -mv "$dove_linux_dir"
fi

cd "$dove_linux_dir"

echo_green_text "Creating archives/dove-linux.zip..."

zip -r -FS "$dove_dir/archives/dove-linux.zip" *

if [[ "$OSTYPE" == "darwin"* ]]; then
    /usr/sbin/dot_clean -mv "$dove_linux_flatpak_dir"
fi

cd "$dove_linux_flatpak_dir"

echo_green_text "Creating archives/dove-flatpak.zip..."

zip -r -FS "$dove_dir/archives/dove-flatpak.zip" *

if [[ "$OSTYPE" == "darwin"* ]]; then
    /usr/sbin/dot_clean -mv "$dove_osx_dir"
fi

cd "$dove_osx_dir"

echo_green_text "Creating archives/dove-osx.zip..."

zip -r -FS "$dove_dir/archives/dove-osx.zip" * -x 'Library/*'

if [[ "$OSTYPE" == "darwin"* ]]; then
    /usr/sbin/dot_clean -mv "$dove_osx_intel_dir"
fi

cd "$dove_osx_intel_dir"

echo_green_text "Creating archives/dove-osx-intel.zip..."

zip -r -FS "$dove_dir/archives/dove-osx-intel.zip" * -x 'Library/*'

if [[ "$OSTYPE" == "darwin"* ]]; then
    /usr/sbin/dot_clean -mv "$dove_windows_dir"
fi

cd "$dove_windows_dir"

echo_green_text "Creating archives/dove-windows.zip..."

zip -r -FS "$dove_dir/archives/dove-windows.zip" *

cd "$dove_dir"
