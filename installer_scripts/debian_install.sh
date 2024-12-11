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


## Find Release codename. For example, bookworm is codename of Debian 12
Release_CodeName=$(grep 'VERSION_CODENAME' /etc/os-release | cut -d'=' -f2)

if [ $(id --user) -ne 0 ]; then
	echo_red_text "You must run this script with sudo"
	echo
	exit 1
fi


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

echo_green_text "Adding Prebuilt MPR repo if not already installed..."
wget -O- -nv 'https://proget.makedeb.org/debian-feeds/prebuilt-mpr.pub' | \
	gpg --dearmor | \
	sudo tee /usr/share/keyrings/prebuilt-mpr-archive-keyring.gpg 1> /dev/null

echo "deb [signed-by=/usr/share/keyrings/prebuilt-mpr-archive-keyring.gpg]" \ 
	"https://proget.makedeb.org prebuilt-mpr ${Release_CodeName}" | \
	sudo tee /etc/apt/sources.list.d/prebuilt-mpr.list
echo

echo_green_text "Updating APT cache..."
sudo apt update || error_fn
echo

echo_green_text "Installing Makedeb if not already installed..."
sudo apt install makedeb || error_fn
echo

echo_green_text "Installing git if not already installed..."
sudo apt install git || error_fn
echo

echo_green_text "Cloning Mist..."
git clone "https://mpr.makedeb.org/mist.git" || error_fn
echo

echo_green_text "Building & Installing Mist..."
cd mist/
makedeb -s -i
echo

echo_green_text "Installing dove-policies package..."
sudo apt install dove-policies || error_fn
echo

echo_green_text "All done. Congratulations, you've successfully installed Dove.\nEnjoy :)\n"
