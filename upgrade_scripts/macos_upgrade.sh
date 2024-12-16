#! /usr/bin/env bash


## Functions
echo_red_text() {
	echo -e "\033[31m$1\033[0m"
}

echo_green_text() {
	echo -e "\033[32m$1\033[0m"
}

error_fn() {
	echo
	echo -e "\033[31mSomething went wrong! The script failed.\033[0m"
	echo -e "\033[31mPlease report this (with the output message) to https://dove.celenity.dev/issues\033[0m"
	echo
	exit 1
}


## Upgrade Dove
echo_green_text "Removing legacy dove.cfg..."
sudo rm -f /Applications/Thunderbird.app/Contents/Resources/dove.cfg || error_fn
echo

echo_green_text "Removing legacy dove.js..."
sudo rm -f /Applications/Thunderbird.app/Contents/Resources/defaults/pref/dove.js || error_fn
echo

echo_green_text "Removing legacy mozilla.cfg if installed..."
sudo rm -f /Applications/Thunderbird.app/Contents/Resources/mozilla.cfg || error_fn
echo

echo_green_text "Removing legacy local-settings.js if installed..."
sudo rm -f /Applications/Thunderbird.app/Contents/Resources/defaults/pref/local-settings.js || error_fn
echo

echo_green_text "Unloading ~/Library/LaunchAgents/com.user.updatepoliciesdove.plist..."
sudo launchctl unload -w  ~/Library/LaunchAgents/com.user.updatepoliciesdove.plist || error_fn
echo

echo_green_text "Removing ~/Library/LaunchAgents/com.user.updatepoliciesdove.plist..."
sudo rm -f ~/Library/LaunchAgents/com.user.updatepoliciesdove.plist || error_fn
echo

echo_green_text "Removing /usr/local/sbin/update_policies_dove.sh..."
sudo rm -f /usr/local/sbin/update_policies_dove.sh || error_fn
echo

echo_green_text "Removing legacy policies.json..."
sudo rm -f /Applications/Thunderbird.app/Contents/Resources/distribution/policies.json || error_fn
echo

echo_green_text "Uninstalling legacy dove-policies..."
brew uninstall dove-policies || error_fn
echo

echo_green_text "Removing legacy Dove-Policies-macOS Tap from Homebrew if installed..."
brew untap celenity/Dove-Policies-macOS || error_fn
echo

echo_green_text "Adding celenity's Tap to Homebrew..."
brew tap celenity/tap https://codeberg.org/celenity/tap || error_fn
echo

echo_green_text "Updating Homebrew cache..."
brew update || error_fn
echo

echo_green_text "Installing dove package..."
brew install dove || error_fn
echo

echo_green_text "Thank you for upgrading Dove! Enjoy :)"
