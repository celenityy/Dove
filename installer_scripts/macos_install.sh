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

echo_green_text "Welcome to the Dove installer for macOS!"
echo_red_text "Before proceeding: You MUST grant your Terminal the 'App Management' permission by navigating to 'System Settings' -> 'Privacy & Security' -> 'App Management'"
echo_green_text "PLEASE SELECT 'Quit & Re-open' WHEN PROMPTED, AND RE-RUN THIS SCRIPT..."
echo_red_text "This is ONLY required for initial installation, and you are strongly recommended to revoke the 'App Management' permission once you are done."
echo_green_text "If you are unable/unwilling to grant your Terminal this permission, you can follow the instructions here to copy the files manually: https://dove.celenity.dev#manual-installation."
/bin/sleep 5
/usr/bin/open /System/Applications/'System Settings'.app
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

echo_green_text "Downloading dev.celenity.dove.env.MOZ_CRASHREPORTER_DISABLE.plist..."
curl --cert-status --doh-cert-status --no-insecure --no-proxy-insecure --no-sessionid --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --proto -all,https --proto-default https --proto-redir -all,https --show-error -O -sSL https://gitlab.com/celenityy/Dove/-/raw/pages/macos/Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER_DISABLE.plist || error_fn
echo

echo_green_text "Changing permissions of dev.celenity.dove.env.MOZ_CRASHREPORTER_DISABLE.plist to 644..."
sudo /bin/chmod -v 644 dev.celenity.dove.env.MOZ_CRASHREPORTER_DISABLE.plist || error_fn
echo

echo_green_text "Copying dev.celenity.dove.env.MOZ_CRASHREPORTER_DISABLE.plist to /Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER_DISABLE.plist..."
sudo /bin/cp dev.celenity.dove.env.MOZ_CRASHREPORTER_DISABLE.plist /Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER_DISABLE.plist || error_fn
echo

echo_green_text "Loading dev.celenity.dove.env.MOZ_CRASHREPORTER_DISABLE.plist..."
/bin/launchctl load /Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER_DISABLE.plist || error_fn
echo

echo_green_text "Downloading dev.celenity.dove.env.MOZ_CRASHREPORTER_NO_REPORT.plist..."
curl --cert-status --doh-cert-status --no-insecure --no-proxy-insecure --no-sessionid --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --proto -all,https --proto-default https --proto-redir -all,https --show-error -O -sSL https://gitlab.com/celenityy/Dove/-/raw/pages/macos/Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER_NO_REPORT.plist || error_fn
echo

echo_green_text "Changing permissions of dev.celenity.dove.env.MOZ_CRASHREPORTER_NO_REPORT.plist to 644..."
sudo /bin/chmod -v 644 dev.celenity.dove.env.MOZ_CRASHREPORTER_NO_REPORT.plist || error_fn
echo

echo_green_text "Copying dev.celenity.dove.env.MOZ_CRASHREPORTER_NO_REPORT.plist to /Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER_NO_REPORT.plist..."
sudo /bin/cp dev.celenity.dove.env.MOZ_CRASHREPORTER_NO_REPORT.plist /Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER_NO_REPORT.plist || error_fn
echo

echo_green_text "Loading dev.celenity.dove.env.MOZ_CRASHREPORTER_NO_REPORT.plist..."
/bin/launchctl load /Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER_NO_REPORT.plist || error_fn
echo

echo_green_text "Downloading dev.celenity.dove.env.MOZ_CRASHREPORTER_URL.plist..."
curl --cert-status --doh-cert-status --no-insecure --no-proxy-insecure --no-sessionid --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --proto -all,https --proto-default https --proto-redir -all,https --show-error -O -sSL https://gitlab.com/celenityy/Dove/-/raw/pages/macos/Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER_URL.plist || error_fn
echo

echo_green_text "Changing permissions of dev.celenity.dove.env.MOZ_CRASHREPORTER_URL.plist to 644..."
sudo /bin/chmod -v 644 dev.celenity.dove.env.MOZ_CRASHREPORTER_URL.plist || error_fn
echo

echo_green_text "Copying dev.celenity.dove.env.MOZ_CRASHREPORTER_URL.plist to /Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER_URL.plist..."
sudo /bin/cp dev.celenity.dove.env.MOZ_CRASHREPORTER_URL.plist /Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER_URL.plist || error_fn
echo

echo_green_text "Loading dev.celenity.dove.env.MOZ_CRASHREPORTER_URL.plist..."
/bin/launchctl load /Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER_URL.plist || error_fn
echo

echo_green_text "Creating /Library/celenity/Dove directory..."
sudo /bin/mkdir -v -p /Library/celenity/Dove || error_fn
echo

echo_green_text "Changing permissions of Library/celenity/Dove to 744..."
sudo /bin/chmod -v 744 /Library/celenity/Dove || error_fn
echo

echo -e ""
echo_green_text "Are you using an Apple Silicon (M-series chip) or Intel device?";
echo_green_text "Your options are:";
echo_red_text "1. Silicon";
echo_green_text "2. Intel";
read "DEVICETYPE?Please enter your selection: "
case ${DEVICETYPE} in
	"apple" | "Apple" | "APPLE" | "silicon" | "Silicon" | "SILICON" | 1)
        echo_green_text "Downloading dove-apply.sh..."
		curl --cert-status -O -sSL https://gitlab.com/celenityy/Dove/-/raw/pages/macos/Library/celenity/Dove/dove-apply.sh || error_fn
		echo

		echo_green_text "Changing permissions of dove-apply.sh to 744..."
		sudo /bin/chmod -v 744 dove-apply.sh || error_fn
		echo

		echo_green_text "Copying dove-apply.sh to /Library/celenity/Dove/dove-apply.sh..."
		sudo /bin/cp dove-apply.sh /Library/celenity/Dove/dove-apply.sh || error_fn
		echo

		echo_green_text "Downloading dev.celenity.dove.apply.plist..."
		curl --cert-status -O -sSL https://gitlab.com/celenityy/Dove/-/raw/pages/macos/Library/LaunchDaemons/dev.celenity.dove.apply.plist || error_fn
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

		echo -e ""
		echo_green_text "Where is your installation of Thunderbird located?";
		echo_green_text "Your options are:";
		echo_red_text "1. system - /Applications/Thunderbird.app";
		echo_green_text "2. user - ${HOME}/Applications/Thunderbird.app";
		read "LOCATION?Please enter your selection: "
		case ${LOCATION} in
			"system" | "System" | "SYSTEM" | 1)
				## Ensure Thunderbird isn't quarantined so we don't break it...
				# https://support.mozilla.org/kb/deploying-firefox-customizations-macos
				sudo /usr/bin/xattr -v -r -d com.apple.quarantine /Applications/Thunderbird.app

				echo_green_text "Creating /Applications/Thunderbird.app/Contents/Resources/defaults/pref directory..."
				sudo /bin/mkdir -v -p /Applications/Thunderbird.app/Contents/Resources/defaults/pref || error_fn
				echo

				echo_green_text "Changing permissions of /Applications/Thunderbird.app/Contents/Resources/defaults/pref to 755..."
				sudo /bin/chmod -R -v 755 /Applications/Thunderbird.app/Contents/Resources/defaults/pref || error_fn
				echo

				echo_green_text "Creating a symlink from /opt/homebrew/opt/dove/defaults/pref/dove.js to /Applications/Thunderbird.app/Contents/Resources/defaults/pref/dove.js..."
				sudo /bin/ln -s /opt/homebrew/opt/dove/defaults/pref/dove.js /Applications/Thunderbird.app/Contents/Resources/defaults/pref/dove.js || error_fn
				echo

				echo_green_text "Creating a symlink from /opt/homebrew/opt/dove/macos/dove.cfg to /Applications/Thunderbird.app/Contents/Resources/dove.cfg.."
				sudo /bin/ln -s /opt/homebrew/opt/dove/macos/dove.cfg /Applications/Thunderbird.app/Contents/Resources/dove.cfg || error_fn
				echo
				;;

			"user" | "User" | "USER" | 2)
				## Ensure Thunderbird isn't quarantined so we don't break it...
				# https://support.mozilla.org/kb/deploying-firefox-customizations-macos
				/usr/bin/xattr -v -r -d com.apple.quarantine "${HOME}/Applications/Thunderbird.app"

				echo_green_text "Creating ${HOME}/Applications/Thunderbird.app/Contents/Resources/defaults/pref directory..."
				/bin/mkdir -v -p "${HOME}/Applications/Thunderbird.app/Contents/Resources/defaults/pref" || error_fn
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
		echo_green_text "Downloading dove-apply-intel.sh..."
		curl --cert-status -O -sSL https://gitlab.com/celenityy/Dove/-/raw/pages/macos/Library/celenity/Dove/dove-apply-intel.sh || error_fn
		echo

		echo_green_text "Changing permissions of dove-apply-intel.sh to 744..."
		sudo /bin/chmod -v 744 dove-apply-intel.sh || error_fn
		echo

		echo_green_text "Copying dove-apply-intel.sh to /Library/celenity/Dove/dove-apply-intel.sh..."
		sudo /bin/cp dove-apply-intel.sh /Library/celenity/Dove/dove-apply-intel.sh || error_fn
		echo

		echo_green_text "Downloading dev.celenity.dove.apply.intel.plist..."
		curl --cert-status -O -sSL https://gitlab.com/celenityy/Dove/-/raw/pages/macos/Library/LaunchDaemons/dev.celenity.dove.apply.intel.plist || error_fn
		echo

		echo_green_text "Changing permissions of dev.celenity.dove.apply.intel.plist to 644..."
		sudo /bin/chmod -v 644 dev.celenity.dove.apply.intel.plist || error_fn
		echo

		echo_green_text "Copying dev.celenity.dove.apply.intel.plist to /Library/LaunchDaemons/dev.celenity.dove.apply.intel.plist..."
		sudo /bin/cp dev.celenity.dove.apply.intel.plist /Library/LaunchDaemons/dev.celenity.dove.apply.intel.plist || error_fn
		echo

		echo_green_text "Loading dev.celenity.dove.apply.intel.plist..."
		sudo /bin/launchctl load -w /Library/LaunchDaemons/dev.celenity.dove.apply.intel.plist || error_fn
		echo

		echo -e ""
		echo_green_text "Where is your installation of Thunderbird located?";
		echo_green_text "Your options are:";
		echo_red_text "1. system - /Applications/Thunderbird.app";
		echo_green_text "2. user - ${HOME}/Applications/Thunderbird.app";
		read "LOCATION?Please enter your selection: "
		case ${LOCATION} in
			"system" | "System" | "SYSTEM" | 1)
				## Ensure Thunderbird isn't quarantined so we don't break it...
				# https://support.mozilla.org/kb/deploying-firefox-customizations-macos
				sudo /usr/bin/xattr -v -r -d com.apple.quarantine /Applications/Thunderbird.app

				echo_green_text "Creating /Applications/Thunderbird.app/Contents/Resources/defaults/pref directory..."
				sudo /bin/mkdir -v -p /Applications/Thunderbird.app/Contents/Resources/defaults/pref || error_fn
				echo

				echo_green_text "Changing permissions of /Applications/Thunderbird.app/Contents/Resources/defaults/pref to 755..."
				sudo /bin/chmod -R -v 755 /Applications/Thunderbird.app/Contents/Resources/defaults/pref || error_fn
				echo

				echo_green_text "Creating a symlink from /usr/local/opt/dove/defaults/pref/dove.js to /Applications/Thunderbird.app/Contents/Resources/defaults/pref/dove.js..."
				sudo /bin/ln -s /usr/local/opt/dove/defaults/pref/dove.js /Applications/Thunderbird.app/Contents/Resources/defaults/pref/dove.js || error_fn
				echo

				echo_green_text "Creating a symlink from /usr/local/opt/dove/macos/dove.cfg to /Applications/Thunderbird.app/Contents/Resources/dove.cfg.."
				sudo /bin/ln -s /usr/local/opt/dove/macos/dove.cfg /Applications/Thunderbird.app/Contents/Resources/dove.cfg || error_fn
				echo
				;;

			"user" | "User" | "USER" | 2)
				## Ensure Thunderbird isn't quarantined so we don't break it...
				# https://support.mozilla.org/kb/deploying-firefox-customizations-macos
				/usr/bin/xattr -v -r -d com.apple.quarantine "${HOME}/Applications/Thunderbird.app"

				echo_green_text "Creating ${HOME}/Applications/Thunderbird.app/Contents/Resources/defaults/pref directory..."
				/bin/mkdir -v -p "${HOME}/Applications/Thunderbird.app/Contents/Resources/defaults/pref" || error_fn
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
echo_green_text "PLEASE SELECT "Later" WHEN IT ASKS YOU TO QUIT AND RE-OPEN YOUR TERMINAL..."
/bin/sleep 5
/usr/bin/open /System/Applications/'System Settings'.app
/bin/sleep 5
echo_green_text "Press enter to continue once you are finished."
read

echo_green_text "All done. Congratulations, you've successfully installed Dove.\nEnjoy :)\n"

echo_red_text "Your system will now reboot to finalize your installation."
/bin/sleep 5
echo_green_text "Press enter to continue."
read

sudo /sbin/reboot
