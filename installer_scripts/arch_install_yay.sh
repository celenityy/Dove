#! /usr/bin/env bash


## Downloaded files save in /tmp for moving
cd /tmp


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


## Install Dove
echo_green_text "Downloading dove.cfg..."
wget -nv https://dove.celenity.dev/dove.cfg || error_fn
echo

echo_green_text "Moving dove.cfg to /usr/lib/thunderbird/dove.cfg..."
sudo mv -v dove.cfg /usr/lib/thunderbird/dove.cfg || error_fn
echo

echo_green_text "Downloading dove.js..."
wget -nv https://dove.celenity.dev/defaults/pref/dove.js || error_fn
echo

echo_green_text "Creating /etc/thunderbird/defaults/pref directory..."
sudo mkdir -v -p /etc/thunderbird/defaults/pref || error_fn
echo

echo_green_text "Changing permissions of /etc/thunderbird/defaults/pref to 655..."
sudo chmod -v 655 /etc/thunderbird/defaults/pref || error_fn
echo

echo_green_text "Moving dove.js to /etc/thunderbird/defaults/pref/dove.js..."
sudo mv -v dove.js /etc/thunderbird/defaults/pref/dove.js || error_fn
echo

echo_green_text "Installing dove-policies from the AUR..."
yay -S dove-policies || error_fn
echo

echo_green_text "All done. Congratulations, you've successfully installed Dove.\nEnjoy :)\n"
