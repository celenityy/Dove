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

echo_green_text "Welcome to the Dove migration script for macOS (Intel)!"
echo_red_text "Before proceeding: You MUST grant your Terminal the 'App Management' permission by navigating to 'System Settings' -> 'Privacy & Security' -> 'App Management'"
echo_green_text "PLEASE SELECT 'Quit & Re-open' WHEN PROMPTED, AND RE-RUN THIS SCRIPT..."
echo_red_text "This is ONLY required for initial installation, and you are strongly recommended to revoke the 'App Management' permission once you are done."
echo_green_text "If you are unable/unwilling to grant your Terminal this permission, you can follow the instructions here to copy the files manually: https://dove.celenity.dev#manual-installation."
/bin/sleep 5
/usr/bin/open /System/Applications/'System Settings'.app
/bin/sleep 5
echo_red_text "Press enter to continue."
read

echo_green_text "Downloading dev.celenity.dove.env.MOZ_CRASHREPORTER.plist..."
curl --cert-status --doh-cert-status --no-insecure --no-proxy-insecure --no-sessionid --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --proto -all,https --proto-default https --proto-redir -all,https --show-error -O -sSL https://gitlab.com/celenityy/Dove/-/raw/pages/macos/Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER.plist || error_fn
echo

echo_green_text "Changing permissions of dev.celenity.dove.env.MOZ_CRASHREPORTER.plist to 644..."
sudo /bin/chmod -v 644 dev.celenity.dove.env.MOZ_CRASHREPORTER.plist || error_fn
echo

echo_green_text "Copying dev.celenity.dove.env.MOZ_CRASHREPORTER.plist to /Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER.plist..."
sudo /bin/cp dev.celenity.dove.env.MOZ_CRASHREPORTER.plist /Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER.plist || error_fn
echo

echo_green_text "Loading dev.celenity.dove.env.MOZ_CRASHREPORTER.plist..."
/bin/launchctl load /Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER.plist || error_fn
echo

echo_green_text "Downloading dev.celenity.dove.env.MOZ_DISABLE_ASAN_REPORTER.plist..."
curl --cert-status --doh-cert-status --no-insecure --no-proxy-insecure --no-sessionid --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --proto -all,https --proto-default https --proto-redir -all,https --show-error -O -sSL https://gitlab.com/celenityy/Dove/-/raw/pages/macos/Library/LaunchAgents/dev.celenity.dove.env.MOZ_DISABLE_ASAN_REPORTER.plist || error_fn
echo

echo_green_text "Changing permissions of dev.celenity.dove.env.MOZ_DISABLE_ASAN_REPORTER.plist to 644..."
sudo /bin/chmod -v 644 dev.celenity.dove.env.MOZ_DISABLE_ASAN_REPORTER.plist || error_fn
echo

echo_green_text "Copying dev.celenity.dove.env.MOZ_DISABLE_ASAN_REPORTER.plist to /Library/LaunchAgents/dev.celenity.dove.env.MOZ_DISABLE_ASAN_REPORTER.plist..."
sudo /bin/cp dev.celenity.dove.env.MOZ_DISABLE_ASAN_REPORTER.plist /Library/LaunchAgents/dev.celenity.dove.env.MOZ_DISABLE_ASAN_REPORTER.plist || error_fn
echo

echo_green_text "Loading dev.celenity.dove.env.MOZ_DISABLE_ASAN_REPORTER.plist..."
/bin/launchctl load /Library/LaunchAgents/dev.celenity.dove.env.MOZ_DISABLE_ASAN_REPORTER.plist || error_fn
echo

echo_green_text "Downloading dev.celenity.dove.env.SSLKEYLOGFILE.plist..."
curl --cert-status --doh-cert-status --no-insecure --no-proxy-insecure --no-sessionid --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --proto -all,https --proto-default https --proto-redir -all,https --show-error -O -sSL https://gitlab.com/celenityy/Dove/-/raw/pages/macos/Library/LaunchAgents/dev.celenity.dove.env.SSLKEYLOGFILE.plist || error_fn
echo

echo_green_text "Changing permissions of dev.celenity.dove.env.SSLKEYLOGFILE.plist to 644..."
sudo /bin/chmod -v 644 dev.celenity.dove.env.SSLKEYLOGFILE.plist || error_fn
echo

echo_green_text "Copying dev.celenity.dove.env.SSLKEYLOGFILE.plist to /Library/LaunchAgents/dev.celenity.dove.env.SSLKEYLOGFILE.plist..."
sudo /bin/cp dev.celenity.dove.env.SSLKEYLOGFILE.plist /Library/LaunchAgents/dev.celenity.dove.env.SSLKEYLOGFILE.plist || error_fn
echo

echo_green_text "Loading dev.celenity.dove.env.SSLKEYLOGFILE.plist..."
/bin/launchctl load /Library/LaunchAgents/dev.celenity.dove.env.SSLKEYLOGFILE.plist || error_fn
echo

echo_green_text "Removing /Library/celenity/Dove/dove-apply-intel.sh..."
sudo /bin/rm -f /Library/celenity/Dove/dove-apply-intel.sh || error_fn
echo

echo_green_text "Downloading dove-apply-intel.sh..."
curl --cert-status --doh-cert-status --no-insecure --no-proxy-insecure --no-sessionid --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --proto -all,https --proto-default https --proto-redir -all,https --show-error -O -sSL https://gitlab.com/celenityy/Dove/-/raw/pages/macos-intel/Library/celenity/Dove/dove-apply-intel.sh || error_fn
echo

echo_green_text "Changing permissions of dove-apply-intel.sh to 744..."
sudo /bin/chmod -v 744 dove-apply-intel.sh || error_fn
echo

echo_green_text "Copying dove-apply-intel.sh to /Library/celenity/Dove/dove-apply-intel.sh..."
sudo /bin/cp dove-apply-intel.sh /Library/celenity/Dove/dove-apply-intel.sh || error_fn
echo

echo_green_text "Uninstalling dove..."
brew uninstall dove || error_fn
echo

echo_green_text "Installing dove-intel..."
brew install dove-intel || error_fn
echo

echo -e ""
echo_green_text "Where is your installation of Thunderbird located?";
echo_green_text "Your options are:";
echo_red_text "1. system - /Applications/Thunderbird.app";
echo_green_text "2. user - ${HOME}/Applications/Thunderbird.app";
read "LOCATION?Please enter your selection: "
case ${LOCATION} in
	"system" | "System" | "SYSTEM" | 1)
		echo_green_text "Removing dove.js..."
		sudo /bin/rm -f /Applications/Thunderbird.app/Contents/Resources/defaults/pref/dove.js || error_fn
		echo

		echo_green_text "Removing dove.cfg..."
		sudo /bin/rm -f /Applications/Thunderbird.app/Contents/Resources/dove.cfg || error_fn
		echo

		echo_green_text "Creating a symlink from /usr/local/opt/dove-intel/defaults/pref/dove.js to /Applications/Thunderbird.app/Contents/Resources/defaults/pref/dove.js..."
		sudo /bin/ln -s /usr/local/opt/dove-intel/defaults/pref/dove.js /Applications/Thunderbird.app/Contents/Resources/defaults/pref/dove.js || error_fn
		echo

		echo_green_text "Creating a symlink from /usr/local/opt/dove-intel/dove.cfg to /Applications/Thunderbird.app/Contents/Resources/dove.cfg.."
		sudo /bin/ln -s /usr/local/opt/dove-intel/dove.cfg /Applications/Thunderbird.app/Contents/Resources/dove.cfg || error_fn
		echo
		;;

	"user" | "User" | "USER" | 2)
		echo_green_text "Removing dove.js..."
		/bin/rm -f "${HOME}/Applications/Thunderbird.app/Contents/Resources/defaults/pref/dove.js" || error_fn
		echo

		echo_green_text "Removing dove.cfg..."
		/bin/rm -f "${HOME}/Applications/Thunderbird.app/Contents/Resources/dove.cfg" || error_fn
		echo

		echo_green_text "Creating a symlink from /usr/local/opt/dove-intel/defaults/pref/dove.js to "${HOME}/Applications/Thunderbird.app/Contents/Resources/defaults/pref/dove.js"..."
		/bin/ln -s /usr/local/opt/dove-intel/defaults/pref/dove.js "${HOME}/Applications/Thunderbird.app/Contents/Resources/defaults/pref/dove.js" || error_fn
		echo

		echo_green_text "Creating a symlink from /usr/local/opt/dove-intel/dove.cfg to "${HOME}/Applications/Thunderbird.app/Contents/Resources/dove.cfg".."
		/bin/ln -s /usr/local/opt/dove-intel/dove.cfg "${HOME}/Applications/Thunderbird.app/Contents/Resources/dove.cfg" || error_fn
		echo
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
