#! /usr/bin/env bash


## Downloaded files save in /tmp for moving
cd /tmp

## Colours
blue='\e[1;34m'
brown='\e[0;33m'
coloroff='\e[0m' # Colour off
cyan='\e[1;36m'
gray='\e[1;30m'
green='\e[0;32m'
purple='\e[0;35m'
red='\e[1;31m'
yellow='\e[1;33m'


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
	echo -e "\033[31mPlease report this (with the output message) to https://Dove.celenity.dev/issues\033[0m"
	echo
	exit 1
}


## Install Dove
echo_green_text "Adding celenity's OBS Repo to APT..."
echo 'deb http://download.opensuse.org/repositories/home:/celenity/Debian_12/ /' | \
	sudo tee /etc/apt/sources.list.d/home:celenity.list
echo

echo_green_text "Adding celenity's GPG key..."
wget -O-  https://download.opensuse.org/repositories/home:celenity/Debian_12/Release.key 2>/dev/null | \
	gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_celenity.gpg > /dev/null
echo

echo_green_text "Updating APT cache..."
sudo apt update || error_fn
echo

echo_green_text "Installing Dove..."
sudo apt install dove || error_fn
echo

echo_green_text "All done. :) Congratulations, you've successfully installed Dove.\n"
