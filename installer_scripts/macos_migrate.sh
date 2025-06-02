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

echo_green_text "Welcome to the Dove migration script for macOS!"
echo_red_text "Before proceeding: You MUST grant your Terminal the 'App Management' permission by navigating to 'System Settings' -> 'Privacy & Security' -> 'App Management'"
echo_green_text "PLEASE SELECT 'Quit & Re-open' WHEN PROMPTED, AND RE-RUN THIS SCRIPT..."
echo_red_text "This is ONLY required for initial installation, and you are strongly recommended to revoke the 'App Management' permission once you are done."
echo_green_text "If you are unable/unwilling to grant your Terminal this permission, you can follow the instructions here to copy the files manually: https://dove.celenity.dev#manual-installation."
/bin/sleep 5
/usr/bin/open /System/Applications/'System Settings'.app
/bin/sleep 5
echo_red_text "Press enter to continue."
read

echo -e ""
echo_green_text "Are you using an Apple Silicon (M-series chip) or Intel device?";
echo_green_text "Your options are:";
echo_red_text "1. Silicon";
echo_green_text "2. Intel";
read "DEVICETYPE?Please enter your selection: "
case ${DEVICETYPE} in
	"apple" | "Apple" | "APPLE" | "silicon" | "Silicon" | "SILICON" | 1)
		echo -e ""
		echo_green_text "Where is your installation of Thunderbird located?";
		echo_green_text "Your options are:";
		echo_red_text "1. system - /Applications/Thunderbird.app";
		echo_green_text "2. user - ${HOME}/Applications/Thunderbird.app";
		read "LOCATION?Please enter your selection: "
		case ${LOCATION} in
			"system" | "System" | "SYSTEM" | 1)
				echo_green_text "Removing dove-bootstrap.js..."
				sudo /bin/rm -f /Applications/Thunderbird.app/Contents/Resources/defaults/pref/dove-bootstrap.js || error_fn
				echo

				echo_green_text "Removing dove-bootstrap.cfg..."
				sudo /bin/rm -f /Applications/Thunderbird.app/Contents/Resources/dove-bootstrap.cfg || error_fn
				echo

				echo_green_text "Creating a symlink from /opt/homebrew/opt/dove/defaults/pref/dove.js to /Applications/Thunderbird.app/Contents/Resources/defaults/pref/dove.js..."
				sudo /bin/ln -s /opt/homebrew/opt/dove/defaults/pref/dove.js /Applications/Thunderbird.app/Contents/Resources/defaults/pref/dove.js || error_fn
				echo

				echo_green_text "Creating a symlink from /opt/homebrew/opt/dove/macos/dove.cfg to /Applications/Thunderbird.app/Contents/Resources/dove.cfg.."
				sudo /bin/ln -s /opt/homebrew/opt/dove/macos/dove.cfg /Applications/Thunderbird.app/Contents/Resources/dove.cfg || error_fn
				echo
				;;

			"user" | "User" | "USER" | 2)
				echo_green_text "Removing dove-bootstrap.js..."
				/bin/rm -f "${HOME}/Applications/Thunderbird.app/Contents/Resources/defaults/pref/dove-bootstrap.js" || error_fn
				echo

				echo_green_text "Removing dove-bootstrap.cfg..."
				/bin/rm -f "${HOME}/Applications/Thunderbird.app/Contents/Resources/dove-bootstrap.cfg" || error_fn
				echo

				echo_green_text "Creating a symlink from /opt/homebrew/opt/dove/defaults/pref/dove.js to "${HOME}/Applications/Thunderbird.app/Contents/Resources/defaults/pref/dove.js"..."
				/bin/ln -s /opt/homebrew/opt/dove/defaults/pref/dove.js "${HOME}/Applications/Thunderbird.app/Contents/Resources/defaults/pref/dove.js" || error_fn
				echo

				echo_green_text "Creating a symlink from /opt/homebrew/opt/dove/macos/dove.cfg to "${HOME}/Applications/Thunderbird.app/Contents/Resources/dove.cfg".."
				/bin/ln -s /opt/homebrew/opt/dove/macos/dove.cfg "${HOME}/Applications/Thunderbird.app/Contents/Resources/dove.cfg" || error_fn
				echo
				;;
		esac
		;;

	"intel" | "Intel" | "INTEL" | 2)
		echo -e ""
		echo_green_text "Where is your installation of Thunderbird located?";
		echo_green_text "Your options are:";
		echo_red_text "1. system - /Applications/Thunderbird.app";
		echo_green_text "2. user - ${HOME}/Applications/Thunderbird.app";
		read "LOCATION?Please enter your selection: "
		case ${LOCATION} in
			"system" | "System" | "SYSTEM" | 1)
				echo_green_text "Removing dove-bootstrap.js..."
				sudo /bin/rm -f /Applications/Thunderbird.app/Contents/Resources/defaults/pref/dove-bootstrap.js || error_fn
				echo

				echo_green_text "Removing dove-bootstrap.cfg..."
				sudo /bin/rm -f /Applications/Thunderbird.app/Contents/Resources/dove-bootstrap.cfg || error_fn
				echo

				echo_green_text "Creating a symlink from /usr/local/opt/dove/defaults/pref/dove.js to /Applications/Thunderbird.app/Contents/Resources/defaults/pref/dove.js..."
				sudo /bin/ln -s /usr/local/opt/dove/defaults/pref/dove.js /Applications/Thunderbird.app/Contents/Resources/defaults/pref/dove.js || error_fn
				echo

				echo_green_text "Creating a symlink from /usr/local/opt/dove/macos/dove.cfg to /Applications/Thunderbird.app/Contents/Resources/dove.cfg.."
				sudo /bin/ln -s /usr/local/opt/dove/macos/dove.cfg /Applications/Thunderbird.app/Contents/Resources/dove.cfg || error_fn
				echo
				;;

			"user" | "User" | "USER" | 2)
				echo_green_text "Removing dove-bootstrap.js..."
				/bin/rm -f "${HOME}/Applications/Thunderbird.app/Contents/Resources/defaults/pref/dove-bootstrap.js" || error_fn
				echo

				echo_green_text "Removing dove-bootstrap.cfg..."
				/bin/rm -f "${HOME}/Applications/Thunderbird.app/Contents/Resources/dove-bootstrap.cfg" || error_fn
				echo

				echo_green_text "Creating a symlink from /usr/local/opt/dove/defaults/pref/dove.js to "${HOME}/Applications/Thunderbird.app/Contents/Resources/defaults/pref/dove.js"..."
				/bin/ln -s /usr/local/opt/dove/defaults/pref/dove.js "${HOME}/Applications/Thunderbird.app/Contents/Resources/defaults/pref/dove.js" || error_fn
				echo

				echo_green_text "Creating a symlink from /usr/local/opt/dove/macos/dove.cfg to "${HOME}/Applications/Thunderbird.app/Contents/Resources/dove.cfg".."
				/bin/ln -s /usr/local/opt/dove/macos/dove.cfg "${HOME}/Applications/Thunderbird.app/Contents/Resources/dove.cfg" || error_fn
				echo
				;;
		esac
		;;
esac

echo_red_text "You must now revoke the 'App Management' permission from your Terminal by navigating to 'System Settings' -> 'Privacy & Security' -> 'App Management'"
echo_green_text "PLEASE SELECT 'Later' WHEN IT ASKS YOU TO QUIT AND RE-OPEN YOUR TERMINAL..."
/bin/sleep 5
/usr/bin/open /System/Applications/'System Settings'.app
/bin/sleep 5
echo_green_text "Press enter to continue once you are finished."
read

echo_green_text "All done. :) Thank you for taking the time to migrate Dove.\nYour patience and support is invaluable.\n"
