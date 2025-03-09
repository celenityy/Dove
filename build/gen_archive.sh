#!/usr/bin/env bash

# This is a basic script used to create the .zip files you see in the 'archives' directory.
# We could just clone the entire source code - though lots of of it are completely unnecessary for packaging.
# This creates a slim .zip file only containing what we actually need.

# Script should be ran from inside the directory where you store Dove, not directly from the 'archives' or `build` folder...

rm archives/dove.zip

zip -R archives/dove.zip 'dove.cfg' 'etc/*' 'etc/profile.d/*' 'policies.json' 'prefs/*' 'COPYING' 'README.md' -x 'build/*' '.code-workspace' '.domains' '.DS_Store' '.git*' 'gitlab-ci.yml' '_redirects'

zip -R archives/dove-osx.zip 'macos/dove.cfg' 'macos/org.mozilla.thunderbird.plist' 'COPYING' 'README.md' -x 'build/*' 'windows/*' '.code-workspace' '.domains' '.DS_Store' '.git*' 'gitlab-ci.yml' '_redirects'
