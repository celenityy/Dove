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
	echo -e "\033[31mSomthing wrong! The script failed.\033[0m"
	echo
	exit 1
}


if [ $(id --user) -ne 0 ]; then
	echo_red_text "You must run this script with sudo"
	echo
	exit 1
fi


echo_green_text "Downloading mozilla.cfg"
wget -nv https://codeberg.org/celenity/Dove/raw/branch/main/mozilla.cfg || error_fn
echo


echo_green_text "Moving mozilla.cfg to /usr/lib64/thunderbird/mozilla.cfg"
sudo mv -v mozilla.cfg /usr/lib64/thunderbird/mozilla.cfg || error_fn
echo


echo_green_text "Downloading local-settings.js"
wget -nv https://codeberg.org/celenity/Dove/raw/branch/main/defaults/pref/local-settings.js || error_fn
echo


echo_green_text "Creating /usr/lib64/thunderbird/defaults/pref directory"
sudo mkdir -v -p /usr/lib64/thunderbird/defaults/pref || error_fn
echo

echo_green_text "Changing permissions of /usr/lib64/thunderbird/defaults/pref to 755"
sudo chmod -v 755 /usr/lib64/thunderbird/defaults/pref || error_fn
echo


echo_green_text "Moving local-settings.js to /usr/lib64/thunderbird/defaults/pref/local-settings.js"
sudo mv -v local-settings.js /usr/lib64/thunderbird/defaults/pref/local-settings.js || error_fn
echo


echo_green_text "Adding Dove-Policies COPR Repo to DNF"
sudo dnf copr enable retold3202/Dove-Policies || error_fn
echo

echo_green_text "Updating DNF cache"
sudo dnf update --refresh || error_fn
echo


echo_green_text "Installing dove-policies package"
sudo dnf install dove-policies || error_fn
echo


echo_gree_text "All done. Congratulations, you've successfully installed Dove.\nEnjoy :)\n"