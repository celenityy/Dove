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
sudo rm -f /usr/lib64/thunderbird/dove.cfg || error_fn
echo

echo_green_text "Removing legacy dove.js..."
sudo rm -f /etc/thunderbird/defaults/pref/dove.js || error_fn
echo

echo_green_text "Removing legacy mozilla.cfg if installed..."
sudo rm -f /usr/lib64/thunderbird/mozilla.cfg || error_fn
echo

echo_green_text "Removing legacy local-settings.js if installed..."
sudo rm -f /usr/lib64/thunderbird/defaults/pref/local-settings.js || error_fn
echo

echo_green_text "Uninstalling legacy dove-policies..."
sudo dnf remove dove-policies || error_fn
echo

echo_green_text "Removing legacy Dove-Policies COPR Repo..."
sudo dnf copr remove celenity/dove-policies || error_fn
echo

echo_green_text "Adding celenity's COPR Repo to DNF..."
sudo dnf copr enable celenity/copr || error_fn
echo

echo_green_text "Updating DNF cache..."
sudo dnf update --refresh || error_fn
echo

echo_green_text "Installing dove package..."
sudo dnf install dove || error_fn
echo

echo_green_text "Thank you for upgrading Dove! Enjoy :)"
