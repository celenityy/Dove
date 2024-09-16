#! /usr/bin/env bash


cd /tmp


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

echo_green_text "Downloading mozilla.cfg"
wget -nv https://dove.celenity.dev/mozilla.cfg || error_fn
echo


echo_green_text "Moving mozilla.cfg to /usr/lib/thunderbird/mozilla.cfg"
sudo mv -v mozilla.cfg /usr/lib/firefox/thunderbird.cfg || error_fn
echo


echo_green_text "Downloading local-settings.js"
wget -nv https://dove.celenity.dev/defaults/pref/local-settings.js || error_fn
echo


echo_green_text "Creating /usr/lib/thunderbird/defaults/pref directory"
sudo mkdir -v -p /usr/lib/thunderbird/defaults/pref || error_fn
echo

echo_green_text "Changing permissions of /usr/lib/thunderbird/defaults/pref to 755"
sudo chmod -v 755 /usr/lib/thunderbird/defaults/pref || error_fn
echo


echo_green_text "Moving local-settings.js to /usr/lib/thunderbird/defaults/pref/local-settings.js"
sudo mv -v local-settings.js /usr/lib/thunderbird/defaults/pref/local-settings.js || error_fn
echo


echo_green_text "Installing dove-policies from the AUR"
paru -S dove-policies || error_fn
echo


echo_green_text "All done. Congratulations, you've successfully installed Dove.\nEnjoy :)\n"
