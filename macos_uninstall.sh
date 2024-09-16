#!/bin/zsh

sudo rm -f /Applications/Thunderbird.app/Contents/Resources/mozilla.cfg

sudo rm -f /Applications/Thunderbird.app/Contents/Resources/defaults/pref/local-settings.js

sudo launchctl unload -w  ~/Library/LaunchAgents/com.user.updatepoliciesdove.plist

sudo rm -f ~/Library/LaunchAgents/com.user.updatepoliciesdove.plist

sudo rm -f /usr/local/sbin/update_policies_dove.sh

sudo rm -f /Applications/Thunderbird.app/Contents/Resources/distribution/policies.json

brew uninstall dove-policies

brew untap celenity/Dove-Policies-macOS

brew update

printf "Thanks for giving Dove a shot. Sorry to see you go :(. Please leave feedback on how we can improve! https://dove.celenity.dev/issues"