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
echo_green_text "Uninstalling dove if installed..."
brew uninstall dove || error_fn
echo

echo_green_text "Uninstalling dove-user if installed..."
brew uninstall dove-user || error_fn
echo

read -p  $'\e[32mWould you also like to remove celenity''s Homebrew Tap? [Y/n] \e[0m' RESULT
echo

case ${RESULT} in

		"y" | "yes" | "YES" | "Y")
			echo_green_text "Removing celenity's Tap..."
			brew untap celenity/tap || error_fn
			echo

			echo_green_text "Updating Homebrew cache..."
			brew update && brew upgrade --force --verbose || error_fn
			echo
			;;
		
		"n" | "no" | "N" | "NO")
			;;
esac

echo_green_text "Thanks for giving Dove a shot. Sorry to see you go :(. Please leave feedback on how we can improve! https://dove.celenity.dev/issues"
