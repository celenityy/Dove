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

echo_green_text "Removing mozilla.cfg"
sudo rm -f /usr/lib/thunderbird/mozilla.cfg || error_fn
echo


echo_green_text "Removing local-settings.js"
sudo rm -f /usr/lib/thunderbird/defaults/pref/local-settings.js || error_fn
echo


echo_green_text "Uninstalling dove-policies"
yay -Rcns dove-policies || error_fn
echo


echo_green_text "Thanks for giving Dove a shot. Sorry to see you go :(. Please leave feedback on how we can improve! https://dove.celenity.dev/issues"
