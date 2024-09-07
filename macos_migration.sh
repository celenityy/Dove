#!/bin/zsh

wget https://codeberg.org/celenity/Dove/raw/branch/main/mozilla.cfg

sudo mv mozilla.cfg /Applications/Firefox.app/Contents/Resources/mozilla.cfg

brew uninstall dove-policies

brew untap Magnesium1062/Dove-Policies-macOS

brew tap celenity/Dove-Policies-macOS https://codeberg.org/celenity/Dove-Policies-macOS

brew update

brew upgrade --force

brew install dove-policies

cp /opt/homebrew/opt/dove-policies/etc/thunderbird/distribution/policies.json /Applications/Thunderbird.app/Contents/Resources/distribution/policies.json

printf "Thank you for taking the time to run our migration script. Enjoy :)"