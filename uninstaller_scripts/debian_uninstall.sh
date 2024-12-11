#! /usr/bin/env bash


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


## Uninstall Dove
echo_green_text "Removing dove.cfg..."
sudo rm -f /usr/lib/thunderbird/dove.cfg || error_fn
echo

echo_green_text "Removing dove.js..."
sudo rm -f /etc/thunderbird/defaults/pref/dove.js || error_fn
echo

echo_green_text "Removing legacy mozilla.cfg if installed..."
sudo rm -f /usr/lib/thunderbird/mozilla.cfg || error_fn
echo

echo_green_text "Removing legacy local-settings.js if installed..."
sudo rm -f /usr/lib/thunderbird/defaults/pref/local-settings.js || error_fn
echo

echo_green_text "Uninstalling dove-policies..."
sudo apt remove dove-policies || error_fn
echo

read -p  $'\e[32mDo you want remove Prebuilt MPR Repo? [Y/n] \e[0m' RESULT
echo

case ${RESULT} in

		"y" | "yes" | "YES" | "Y")
			echo_green_text "Removing Prebuilt MPR Repo"
			sudo rm -v /etc/apt/sources.list.d/prebuilt-mpr.list || error_fn
			echo

			echo_green_text "Removing GPG keyof Prebuilt MPR Repo"
			sudo rm -v /usr/share/keyrings/prebuilt-mpr-archive-keyring.gpg || error_fn
			echo
			;;
		
		"n" | "no" | "N" | "NO")
			;;
esac

echo_green_text "Updating APT cache..."
sudo apt update || error_fn
echo

echo_green_text "Thanks for giving Dove a shot. Sorry to see you go :(. Please leave feedback on how we can improve! https://dove.celenity.dev/issues"
