#! /usr/bin/env bash

wget https://codeberg.org/Magnesium1062/Dove/raw/branch/master/mozilla.cfg

sudo mv mozilla.cfg /usr/lib64/thunderbird/mozilla.cfg

wget https://codeberg.org/Magnesium1062/Dove/raw/branch/main/defaults/pref/local-settings.js

sudo mkdir -p /usr/lib64/thunderbird/defaults/pref

sudo chmod 755 /usr/lib64/thunderbird/defaults/pref

sudo mv local-settings.js /usr/lib64/thunderbird/defaults/pref/local-settings.js

sudo dnf copr enable retold3202/Dove-Policies && sudo dnf update --refresh && sudo dnf install dove-policies

printf "All done. Congratulations, you've successfully installed Dove.\nEnjoy :)\n"
