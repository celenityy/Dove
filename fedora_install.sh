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


if [ $(id --user) -ne 0 ]; then
	echo_red_text "You must run this script with sudo"
	echo
	exit 1
fi


echo_green_text "Downloading dove.cfg..."
wget -nv https://dove.celenity.dev/dove.cfg || error_fn
echo


echo_green_text "Moving dove.cfg to /usr/lib64/thunderbird/dove.cfg..."
sudo mv -v dove.cfg /usr/lib64/thunderbird/dove.cfg || error_fn
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


echo_green_text "Adding Dove-Policies COPR Repo to DNF..."
sudo dnf copr enable celenity/dove-policies || error_fn
echo

echo_green_text "Updating DNF cache..."
sudo dnf update --refresh || error_fn
echo


echo_green_text "Installing dove-policies package..."
sudo dnf install dove-policies || error_fn
echo


echo_green_text "All done. Congratulations, you've successfully installed Dove.\nEnjoy :)\n"