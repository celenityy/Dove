#!/bin/zsh

set -euo pipefail

# Functions
echo_red_text() {
	echo -e "\033[31m$1\033[0m"
}

echo_green_text() {
	echo -e "\033[32m$1\033[0m"
}

error_fn() {
	echo
	echo_red_text "\033[31mSomething went wrong! The script failed.\033[0m"
	echo_red_text "\033[31mPlease report this (with the output message) to https://dove.celenity.dev/issues\033[0m"
	echo
	exit 1
}

# launchctl
DOVE_UNINSTALL_LAUNCHCTL='/bin/launchctl'

# open
DOVE_UNINSTALL_OPEN='/usr/bin/open'

# rm
DOVE_UNINSTALL_RM='/bin/rm -f'

# sleep
DOVE_UNINSTALL_SLEEP='/bin/sleep'

# sudo
DOVE_UNINSTALL_SUDO='/usr/bin/sudo'

# Save temporary files/downloads to /tmp
DOVE_UNINSTALL_TEMP='/tmp'

pushd "${DOVE_UNINSTALL_TEMP}"

echo_green_text "Welcome to the Dove Uninstaller for macOS!"
echo_red_text "Sorry to see you go :("
echo_red_text "Before proceeding: You MUST grant your Terminal the 'App Management' permission by navigating to 'System Settings' -> 'Privacy & Security' -> 'App Management'"
echo_red_text "You are strongly recommended to revoke the 'App Management' permission once you are done."
echo_green_text "If you are unable/unwilling to grant your Terminal this permission, you can remove the files manually as laid out here: https://dove.celenity.dev#manual-installation."
"${DOVE_UNINSTALL_SLEEP}" 5
"${DOVE_UNINSTALL_OPEN}" /System/Applications/'System Settings'.app
"${DOVE_UNINSTALL_SLEEP}" 5
echo_red_text "Press enter to continue."
read

## Uninstall Dove
echo_green_text "Unloading dev.celenity.dove.env.MOZ_CRASHREPORTER.plist..."
"${DOVE_UNINSTALL_LAUNCHCTL}" unload /Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER.plist || error_fn
echo

echo_green_text "Removing dev.celenity.dove.env.MOZ_CRASHREPORTER.plist..."
"${DOVE_UNINSTALL_SUDO}" "${DOVE_UNINSTALL_RM}" /Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER.plist || error_fn
echo

echo_green_text "Unloading dev.celenity.dove.env.MOZ_CRASHREPORTER_DISABLE.plist..."
"${DOVE_UNINSTALL_LAUNCHCTL}" unload /Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER_DISABLE.plist || error_fn
echo

echo_green_text "Removing dev.celenity.dove.env.MOZ_CRASHREPORTER_DISABLE.plist..."
"${DOVE_UNINSTALL_SUDO}" "${DOVE_UNINSTALL_RM}" /Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER_DISABLE.plist || error_fn
echo

echo_green_text "Unloading dev.celenity.dove.env.MOZ_CRASHREPORTER_NO_REPORT.plist..."
"${DOVE_UNINSTALL_LAUNCHCTL}" unload /Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER_NO_REPORT.plist || error_fn
echo

echo_green_text "Removing dev.celenity.dove.env.MOZ_CRASHREPORTER_NO_REPORT.plist..."
"${DOVE_UNINSTALL_SUDO}" "${DOVE_UNINSTALL_RM}" /Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER_NO_REPORT.plist || error_fn
echo

echo_green_text "Unloading dev.celenity.dove.env.MOZ_CRASHREPORTER_URL.plist..."
"${DOVE_UNINSTALL_LAUNCHCTL}" unload /Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER_URL.plist || error_fn
echo_green_text "Unloading dev.celenity.dove.env.MOZ_CRASHREPORTER_DISABLE.plist..."
"${DOVE_UNINSTALL_LAUNCHCTL}" unload /Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER_DISABLE.plist || error_fn
echo

echo_green_text "Removing dev.celenity.dove.env.MOZ_CRASHREPORTER_DISABLE.plist..."
"${DOVE_UNINSTALL_SUDO}" "${DOVE_UNINSTALL_RM}" /Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER_DISABLE.plist || error_fn
echo

echo_green_text "Unloading dev.celenity.dove.env.MOZ_CRASHREPORTER_NO_REPORT.plist..."
"${DOVE_UNINSTALL_LAUNCHCTL}" unload /Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER_NO_REPORT.plist || error_fn
echo

echo_green_text "Removing dev.celenity.dove.env.MOZ_CRASHREPORTER_NO_REPORT.plist..."
"${DOVE_UNINSTALL_SUDO}" "${DOVE_UNINSTALL_RM}" /Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER_NO_REPORT.plist || error_fn
echo

echo_green_text "Unloading dev.celenity.dove.env.MOZ_CRASHREPORTER_URL.plist..."
"${DOVE_UNINSTALL_LAUNCHCTL}" unload /Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER_URL.plist || error_fn
echo

echo_green_text "Removing dev.celenity.dove.env.MOZ_CRASHREPORTER_URL.plist..."
"${DOVE_UNINSTALL_SUDO}" "${DOVE_UNINSTALL_RM}" /Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER_URL.plist || error_fn
echo

echo_green_text "Unloading dev.celenity.dove.env.MOZ_CRASHREPORTER_DISABLE.plist..."
"${DOVE_UNINSTALL_LAUNCHCTL}" unload /Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER_DISABLE.plist || error_fn
echo

echo_green_text "Removing dev.celenity.dove.env.MOZ_CRASHREPORTER_DISABLE.plist..."
"${DOVE_UNINSTALL_SUDO}" "${DOVE_UNINSTALL_RM}" /Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER_DISABLE.plist || error_fn
echo

echo_green_text "Unloading dev.celenity.dove.env.MOZ_CRASHREPORTER_NO_REPORT.plist..."
"${DOVE_UNINSTALL_LAUNCHCTL}" unload /Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER_NO_REPORT.plist || error_fn
echo

echo_green_text "Removing dev.celenity.dove.env.MOZ_CRASHREPORTER_NO_REPORT.plist..."
"${DOVE_UNINSTALL_SUDO}" "${DOVE_UNINSTALL_RM}" /Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER_NO_REPORT.plist || error_fn
echo

echo_green_text "Unloading dev.celenity.dove.env.MOZ_CRASHREPORTER_URL.plist..."
"${DOVE_UNINSTALL_LAUNCHCTL}" unload /Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER_URL.plist || error_fn
echo

echo_green_text "Removing dev.celenity.dove.env.MOZ_CRASHREPORTER_URL.plist..."
"${DOVE_UNINSTALL_SUDO}" "${DOVE_UNINSTALL_RM}" /Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER_URL.plist || error_fn
echo

echo_green_text "Unloading dev.celenity.dove.env.MOZ_CRASHREPORTER_DISABLE.plist..."
"${DOVE_UNINSTALL_LAUNCHCTL}" unload /Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER_DISABLE.plist || error_fn
echo

echo_green_text "Removing dev.celenity.dove.env.MOZ_CRASHREPORTER_DISABLE.plist..."
"${DOVE_UNINSTALL_SUDO}" "${DOVE_UNINSTALL_RM}" /Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER_DISABLE.plist || error_fn
echo

echo_green_text "Unloading dev.celenity.dove.env.MOZ_CRASHREPORTER_NO_REPORT.plist..."
"${DOVE_UNINSTALL_LAUNCHCTL}" unload /Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER_NO_REPORT.plist || error_fn
echo

echo_green_text "Removing dev.celenity.dove.env.MOZ_CRASHREPORTER_NO_REPORT.plist..."
"${DOVE_UNINSTALL_SUDO}" "${DOVE_UNINSTALL_RM}" /Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER_NO_REPORT.plist || error_fn
echo

echo_green_text "Unloading dev.celenity.dove.env.MOZ_CRASHREPORTER_URL.plist..."
"${DOVE_UNINSTALL_LAUNCHCTL}" unload /Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER_URL.plist || error_fn
echo

echo_green_text "Removing dev.celenity.dove.env.MOZ_CRASHREPORTER_URL.plist..."
"${DOVE_UNINSTALL_SUDO}" "${DOVE_UNINSTALL_RM}" -f /Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER_URL.plist || error_fn
echo

echo_green_text "Unloading dev.celenity.dove.env.MOZ_DISABLE_ASAN_REPORTER.plist..."
"${DOVE_UNINSTALL_LAUNCHCTL}" unload /Library/LaunchAgents/dev.celenity.dove.env.MOZ_DISABLE_ASAN_REPORTER.plist || error_fn
echo

echo_green_text "Removing dev.celenity.dove.env.MOZ_DISABLE_ASAN_REPORTER.plist..."
"${DOVE_UNINSTALL_SUDO}" "${DOVE_UNINSTALL_RM}" /Library/LaunchAgents/dev.celenity.dove.env.MOZ_DISABLE_ASAN_REPORTER.plist || error_fn
echo

echo_green_text "Unloading dev.celenity.dove.env.SSLKEYLOGFILE.plist..."
"${DOVE_UNINSTALL_LAUNCHCTL}" unload /Library/LaunchAgents/dev.celenity.dove.env.SSLKEYLOGFILE.plist || error_fn
echo

echo_green_text "Removing dev.celenity.dove.env.SSLKEYLOGFILE.plist..."
"${DOVE_UNINSTALL_SUDO}" "${DOVE_UNINSTALL_RM}" /Library/LaunchAgents/dev.celenity.dove.env.SSLKEYLOGFILE.plist || error_fn
echo

echo_green_text "Removing the /Library/celenity/Dove directory..."
"${DOVE_UNINSTALL_SUDO}" "${DOVE_UNINSTALL_RM}" -r /Library/celenity/Dove || error_fn
echo

echo_green_text "Removing org.mozilla.thunderbird.plist..."
"${DOVE_UNINSTALL_SUDO}" "${DOVE_UNINSTALL_RM}" /Library/Preferences/org.mozilla.thunderbird.plist || error_fn
echo
"${DOVE_UNINSTALL_SUDO}" "${DOVE_UNINSTALL_RM}" "${HOME}/Library/Preferences/org.mozilla.thunderbird.plist" || error_fn
echo

echo -e ""
echo_green_text "Are you using an Apple Silicon (M-series chip) or Intel device?";
echo_green_text "Your options are:";
echo_red_text "1. Silicon";
echo_green_text "2. Intel";
read "DEVICETYPE?Please enter your selection: "
case ${DEVICETYPE} in
	"apple" | "Apple" | "APPLE" | "silicon" | "Silicon" | "SILICON" | 1)
		echo_green_text "Uninstalling dove..."
		brew uninstall dove || error_fn
		echo

        echo_green_text "Unloading dev.celenity.dove.apply.plist..."
		"${DOVE_UNINSTALL_SUDO}" "${DOVE_UNINSTALL_LAUNCHCTL}" unload -w /Library/LaunchDaemons/dev.celenity.dove.apply.plist || error_fn
		echo

		echo_green_text "Removing dev.celenity.dove.apply.plist..."
		"${DOVE_UNINSTALL_SUDO}" "${DOVE_UNINSTALL_RM}" /Library/LaunchDaemons/dev.celenity.dove.apply.plist || error_fn
		echo
		;;

	"intel" | "Intel" | "INTEL" | 2)
		echo_green_text "Uninstalling dove-intel..."
		brew uninstall dove-intel || error_fn
		echo

		echo_green_text "Unloading dev.celenity.dove.apply.intel.plist..."
		"${DOVE_UNINSTALL_SUDO}" "${DOVE_UNINSTALL_LAUNCHCTL}" unload -w /Library/LaunchDaemons/dev.celenity.dove.apply.intel.plist || error_fn
		echo

		echo_green_text "Removing dev.celenity.dove.apply.intel.plist..."
		"${DOVE_UNINSTALL_SUDO}" "${DOVE_UNINSTALL_RM}" /Library/LaunchDaemons/dev.celenity.dove.apply.intel.plist || error_fn
		echo
		;;
esac

echo -e ""
echo_green_text "Where is your installation of Thunderbird located?";
echo_green_text "Your options are:";
echo_red_text "1. system - /Applications/Thunderbird.app";
echo_green_text "2. user - ${HOME}/Applications/Thunderbird.app";
read "LOCATION?Please enter your selection: "
case ${LOCATION} in
	"system" | "System" | "SYSTEM" | 1)
        echo_green_text "Removing dove.js..."
        "${DOVE_UNINSTALL_SUDO}" "${DOVE_UNINSTALL_RM}" /Applications/Thunderbird.app/Contents/Resources/defaults/pref/dove.js || error_fn
        echo

        echo_green_text "Removing dove.cfg..."
        "${DOVE_UNINSTALL_SUDO}" "${DOVE_UNINSTALL_RM}" /Applications/Thunderbird.app/Contents/Resources/dove.cfg || error_fn
        echo
		;;

	"user" | "User" | "USER" | 2)
		echo_green_text "Removing dove.js..."
        "${DOVE_UNINSTALL_RM}" "${HOME}/Applications/Thunderbird.app/Contents/Resources/defaults/pref/dove.js" || error_fn
        echo

        echo_green_text "Removing dove.cfg..."
        "${DOVE_UNINSTALL_RM}" "${HOME}/Applications/Thunderbird.app/Contents/Resources/dove.cfg" || error_fn
        echo
		;;
esac

read "RESULT?Would you also like to remove celenity's Homebrew Tap? [Y/n] "
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

popd

echo_red_text "You must now revoke the 'App Management' permission from your Terminal by navigating to 'System Settings' -> 'Privacy & Security' -> 'App Management'"
echo_green_text "PLEASE SELECT 'Later' WHEN IT ASKS YOU TO QUIT AND RE-OPEN YOUR TERMINAL..."
"${DOVE_UNINSTALL_SLEEP}" 5
"${DOVE_UNINSTALL_OPEN}" /System/Applications/'System Settings'.app
"${DOVE_UNINSTALL_SLEEP}" 5
echo_green_text "Press enter to continue once you are finished."
read

echo_green_text "Thanks for giving Dove a shot. Sorry to see you go :(." 
echo_green_text "Please leave feedback on how we can improve! https://dove.celenity.dev/issues"

echo_red_text "Your system will now reboot to finalize your uninstallation."
"${DOVE_UNINSTALL_SLEEP}" 5
echo_green_text "Press enter to continue."
read

"${DOVE_UNINSTALL_SUDO}" /sbin/reboot
