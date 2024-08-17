#! /usr/bin/env bash

wget https://codeberg.org/Magnesium1062/Dove/raw/branch/master/mozilla.cfg

sudo mv mozilla.cfg /Applications/Thunderbird.app/Contents/Resources/mozilla.cfg

wget https://codeberg.org/Magnesium1062/Dove/raw/branch/main/defaults/pref/local-settings.js

sudo mkdir -p /Applications/Thunderbird.app/Contents/Resources/defaults/pref

sudo chmod 755 /Applications/Thunderbird.app/Contents/Resources/defaults/pref

sudo mv local-settings.js /Applications/Thunderbird.app/Contents/Resources/defaults/pref/local-settings.js

echo "Make sure to install your policies & enjoy :D"