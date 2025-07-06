#!/usr/bin/env bash

# This is a basic script used to create the .zip files you see in the 'archives' directory.
# We could just clone the entire source code - though lots of of it are completely unnecessary for packaging.
# This creates a slim .zip file only containing what we actually need.

# Script should be ran from inside the directory where you store Dove, not directly from the 'archives' or `build` folder...

echo_green_text() {
	echo -e "\033[32m$1\033[0m"
}

rm -rf archives/*

cd "$dove_linux_dir"

echo_green_text "Creating archives/dove-linux.zip..."

zip -r -FS "$dove_dir/archives/dove-linux.zip" *

cd "$dove_osx_dir"

echo_green_text "Creating archives/dove-osx.zip..."

zip -r -FS "$dove_dir/archives/dove-osx.zip" * -x 'Library/*'

cd "$dove_osx_intel_dir"

echo_green_text "Creating archives/dove-osx-intel.zip..."

zip -r -FS "$dove_dir/archives/dove-osx-intel.zip" * -x 'Library/*'

cd "$dove_windows_dir"

echo_green_text "Creating archives/dove-windows.zip..."

zip -r -FS "$dove_dir/archives/dove-windows.zip" *

cd "$dove_dir"
