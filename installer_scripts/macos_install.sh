#!/bin/zsh

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

## Downloaded files save in /tmp
cd /tmp

## Download and run initialization script
initialize_dove() {
	wget -nv $1
	echo
	echo
	bash $2
}

## Scripts are here
URL="https://gitlab.com/celenityy/Dove/-/raw/pages/installer_scripts/macos"

## Scripts file
SCRIPT=("dove-initialize-system.sh"
		"dove-initialize-user.sh")

echo_green_text "Welcome to the Dove installer for macOS!"
echo_red_text "Before proceeding: You MUST grant your Terminal the 'App Management' permission by navigating to 'System Settings' -> 'Privacy & Security' -> 'App Management'"
echo_red_text "This is ONLY required for initial installation, and you are strongly recommended to revoke the 'App Management' permission once you are done."
echo_green_text "If you are unable/unwilling to grant your Terminal this permission, you can follow the instructions here to copy the files manually: https://dove.celenity.dev#manual-installation."
/bin/sleep 5
open /System/Applications/'System Settings'.app
/bin/sleep 5
echo_red_text "Press enter to continue."
read

## Install Dove
echo_green_text "Adding celenity's Tap to Homebrew..."
brew tap celenity/tap https://gitlab.com/celenityy/tap || error_fn
echo

echo_green_text "Updating Homebrew cache..."
brew update && brew upgrade --force --verbose || error_fn
echo

echo_green_text "Installing dove package..."
brew install dove || error_fn
echo

echo_green_text "Downloading dove-apply.sh..."
wget -nv https://gitlab.com/celenityy/Dove/-/raw/pages/macos/Library/celenity/Dove/dove-apply.sh || error_fn
echo

echo_green_text "Changing permissions of dove-apply.sh to 744..."
sudo /bin/chmod -v 744 dove-apply.sh || error_fn
echo

echo_green_text "Creating /Library/celenity/Dove directory..."
sudo /bin/mkdir -v -p /Library/celenity/Dove || error_fn
echo

echo_green_text "Changing permissions of Library/celenity/Dove to 744..."
sudo /bin/chmod -v 744 /Library/celenity/Dove || error_fn
echo

echo_green_text "Copying dove-apply.sh to /Library/celenity/Dove/dove-apply.sh..."
sudo /bin/cp dove-apply.sh /Library/celenity/Dove/dove-apply.sh || error_fn
echo

echo_green_text "Downloading dev.celenity.dove.apply.plist..."
wget -nv https://gitlab.com/celenityy/Dove/-/raw/pages/macos/Library/LaunchDaemons/dev.celenity.dove.apply.plist || error_fn
echo

echo_green_text "Changing permissions of dev.celenity.dove.apply.plist to 644..."
sudo /bin/chmod -v 644 dev.celenity.dove.apply.plist || error_fn
echo

echo_green_text "Copying dev.celenity.dove.apply.plist to /Library/LaunchDaemons/dev.celenity.dove.apply.plist..."
sudo /bin/cp dev.celenity.dove.apply.plist /Library/LaunchDaemons/dev.celenity.dove.apply.plist || error_fn
echo

echo_green_text "Loading dev.celenity.dove.apply.plist..."
sudo /bin/launchctl load -w /Library/LaunchDaemons/dev.celenity.dove.apply.plist || error_fn
echo

echo_green_text "Downloading dove-bootstrap.js..."
wget -nv https://gitlab.com/celenityy/Dove/-/raw/pages/macos/defaults/pref/dove-bootstrap.js || error_fn
echo

echo_green_text "Downloading dove-bootstrap.cfg..."
wget -nv https://gitlab.com/celenityy/Dove/-/raw/pages/macos/dove-bootstrap.cfg || error_fn
echo

echo -e ""
echo_green_text "Where is your installation of Thunderbird located?";
echo_green_text "Your options are:";
echo_red_text "1. system - /Applications/Thunderbird.app";
echo_green_text "2. user - ~/Applications/Thunderbird.app";
read -p 'Please enter your selection: ' LOCATION
case ${LOCATION} in
	"system" | "System" | "SYSTEM" | 1)
        TARGET_SCRIPT="${SCRIPT[0]}"
		;;

	"user" | "User" | "USER" | 2)
		TARGET_SCRIPT="${SCRIPT[1]}"
		;;
esac

## Download and run choosen initializion script
initialize_dove "${URL}"/"${TARGET_SCRIPT}" "${TARGET_SCRIPT}"
