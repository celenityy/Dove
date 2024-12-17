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
echo_green_text "Adding celenity's Tap to Homebrew..."
brew tap celenity/tap https://codeberg.org/celenity/tap || error_fn
echo

echo_green_text "Updating Homebrew cache..."
brew update && brew upgrade --force --verbose || error_fn
echo

echo -e ""
echo -e "${brown}Where is your installation of Thunderbird located?${coloroff}";
echo -e "${brown}Your options are:${coloroff}";
echo -e "${blue}system${coloroff} - ${green}/Applications/Thunderbird.app${coloroff}";
echo -e "${red}user${coloroff}  - ${green}~/Applications/Thunderbird.app${coloroff}";
read -p 'Enter your selection: ' LOCATION
case ${LOCATION} in
	"system" | "System" | "SYSTEM")
		echo_green_text "Installing dove package..."
		brew install dove || error_fn
		echo
		;;
	"user" | "User" | "USER")
		echo_green_text "Installing dove-user package..."
		brew install dove-user || error_fn
		echo
		;;
esac
;;

echo_green_text "All done. :) Congratulations, you've successfully installed Dove."
