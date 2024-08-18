#!/bin/zsh

wget https://codeberg.org/Magnesium1062/Dove/raw/branch/main/mozilla.cfg

sudo mv mozilla.cfg /Applications/Thunderbird.app/Contents/Resources/mozilla.cfg

wget https://codeberg.org/Magnesium1062/Dove/raw/branch/main/defaults/pref/local-settings.js

sudo mkdir -p /Applications/Thunderbird.app/Contents/Resources/defaults/pref

sudo chmod 755 /Applications/Thunderbird.app/Contents/Resources/defaults/pref

sudo mv local-settings.js /Applications/Thunderbird.app/Contents/Resources/defaults/pref/local-settings.js

brew tap Magnesium1062/Dove-Policies-macOS https://codeberg.org/Magnesium1062/Dove-Policies-macOS

brew update

brew install dove-policies

cp /opt/homebrew/opt/dove-policies/etc/thunderbird/distribution/policies.json /Applications/Thunderbird.app/Contents/Resources/distribution/policies.json

echo 'alias dove-up="cp /opt/homebrew/opt/dove-policies/etc/thunderbird/distribution/policies.json /Applications/Thunderbird.app/Contents/Resources/distribution/policies.json"' >> ~/.zshrc

printf "All done. :) Congratulations, you've successfully installed Dove."

printf "IMPORTANT: Make sure to run the command "dove-up" after you update your policies.\nYou can set an alias in your ~/.zshrc to make this easier, such as:\nalias update='brew update && brew upgrade --force && dove-up'"