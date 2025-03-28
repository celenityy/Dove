#!/usr/bin/env bash

# This is a basic script used to create the .zip files you see in the 'archives' directory.
# We could just clone the entire source code - though lots of of it are completely unnecessary for packaging.
# This creates a slim .zip file only containing what we actually need.

# Script should be ran from inside the directory where you store Dove, not directly from the 'archives' or `build` folder...

echo_green_text() {
	echo -e "\033[32m$1\033[0m"
}

rm archives/dove.zip archives/dove-osx.zip

echo_green_text "Creating archives/dove.zip..."

zip -r -FS archives/dove.zip * -x 'archives/*' 'assets/*' 'build/*' 'configs/*' 'extensions/*' 'flake.*' 'installer_scripts/*' 'macos/*' 'uBlock/*' 'uninstaller_scripts/*' 'windows/*' '*.code-workspace' '.domains' '.DS_Store' '.git*' '_redirects'

echo_green_text "Creating archives/dove-osx.zip..."

zip -r -FS archives/dove-osx.zip * -x 'archives/*' 'assets/*' 'build/*' 'configs/*' 'dove.cfg' 'etc/*' 'extensions/*' 'flake.*' 'installer_scripts/*' 'macos/defaults/*' 'macos/dove-bootstrap.cfg' 'macos/Library/*' 'macos/migration/*' 'prefs/*' 'policies.json' 'uBlock/*' 'uninstaller_scripts/*' 'windows/*' '*.code-workspace' '.domains' '.DS_Store' '.git*' '_redirects'
