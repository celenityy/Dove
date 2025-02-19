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
echo -e ""
echo_green_text "Is Thunderbird installed as a standard package, or as a Flatpak?";
echo_green_text "Your options are:";
echo_red_text "1. Standard package";
echo_green_text "2. Flatpak (System)";
read -p 'Please enter your selection: ' LOCATION
case ${LOCATION} in
	"standard" | "Standard" | "STANDARD" | 1)
        echo_green_text "Removing Dove package..."
		sudo apt remove dove || error_fn
		echo
		;;

	"flatpak" | "Flatpak" | "FLATPAK" | 2)
		echo_green_text "Removing Dove-flatpak package..."
		sudo apt remove dove-flatpak || error_fn
		echo
		;;
esac

echo -e "\033[32mWould you also like to remove celenity's OBS Repo? [Y/n] \033[0m"
read RESULT
echo

case ${RESULT} in

		"y" | "yes" | "YES" | "Y")
			echo_green_text "Removing celenity's OBS..."
			sudo rm /etc/apt/sources.list.d/home:celenity.list || error_fn
			echo

			echo_green_text "Remoing celenity's GPG key..."
			sudo rm /etc/apt/trusted.gpg.d/home_celenity.gpg || error_fn

			echo_green_text "Updating APT cache..."
			sudo apt update || error_fn
			echo
			;;
		
		"n" | "no" | "N" | "NO")
			;;
esac

echo_green_text "Thanks for giving Phoenix a shot. Sorry to see you go :(. Please leave feedback on how we can improve! https://dove.celenity.dev/issues"
