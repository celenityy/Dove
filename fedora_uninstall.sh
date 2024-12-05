#! /usr/bin/env bash


echo_red_text() {
	echo -e "\033[31m$1\033[0m"
}


echo_green_text() {
	echo -e "\033[32m$1\033[0m"
}

error_fn() {
	echo
	echo -e "\033[31mSomething went wrong! The script failed.\033[0m"
	echo
	exit 1
}

## Uninstall Dove
echo_green_text "Removing dove.cfg..."
sudo rm -f /usr/lib/thunderbird/dove.cfg || error_fn
echo

echo_green_text "Removing dove.js..."
sudo rm -f /etc/thunderbird/defaults/pref/dove.js || error_fn
echo

echo_green_text "Removing legacy mozilla.cfg if installed..."
sudo rm -f /usr/lib64/thunderbird/mozilla.cfg || error_fn
echo

echo_green_text "Removing legacy local-settings.js if installed..."
sudo rm -f /usr/lib64/thunderbird/defaults/pref/local-settings.js || error_fn
echo

echo_green_text "Uninstalling dove-policies..."
sudo dnf remove dove-policies || error_fn
echo

echo_green_text "Removing Dove-Policies COPR Repo..."
sudo dnf copr remove celenity/dove-policies || error_fn
echo

echo_green_text "Updating DNF cache..."
sudo dnf update --refresh || error_fn
echo


echo_green_text "Thanks for giving Dove a shot. Sorry to see you go :(. Please leave feedback on how we can improve! https://dove.celenity.dev/issues"
