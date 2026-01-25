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

# curl flags
DOVE_INSTALL_CURL_FLAGS='-q --disable --no-netrc -j -e "" -A "" -S --clobber --create-dirs --delegation none --disallow-username-in-url --doh-cert-status --ftp-create-dirs --ftp-ssl-control --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-proxy-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ntlm --no-proxy-ssl-allow-beast --no-proxy-ssl-auto-client-cert --no-sessionid --no-skip-existing --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-tls-earlydata --no-xattr --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer "" --remove-on-error --show-error --ssl-reqd --trace-time --user-agent "" --verbose'

# chmod
DOVE_INSTALL_CHMOD='/bin/chmod -v'

# cp
DOVE_INSTALL_CP='/bin/cp'

# curl
DOVE_INSTALL_CURL="curl ${DOVE_INSTALL_CURL_FLAGS} -O -sSL"

# launchctl
DOVE_INSTALL_LAUNCHCTL='/bin/launchctl'

# ln
DOVE_INSTALL_LN='/bin/ln -s'

# mkdir
DOVE_INSTALL_MKDIR='/bin/mkdir -vp'

# open
DOVE_INSTALL_OPEN='/usr/bin/open'

# sleep
DOVE_INSTALL_SLEEP='/bin/sleep'

# sudo
DOVE_INSTALL_SUDO='/usr/bin/sudo'

# xattr
DOVE_INSTALL_XATTR='/usr/bin/xattr -v -r -d com.apple.quarantine'

# Save temporary files/downloads to /tmp
DOVE_INSTALL_TEMP='/tmp'

pushd "${DOVE_INSTALL_TEMP}"

echo_green_text "Welcome to the Dove installer for macOS!"
echo_red_text "Before proceeding: You MUST grant your Terminal the 'App Management' permission by navigating to 'System Settings' -> 'Privacy & Security' -> 'App Management'"
echo_green_text "PLEASE SELECT 'Quit & Re-open' WHEN PROMPTED, AND RE-RUN THIS SCRIPT..."
echo_red_text "This is ONLY required for initial installation, and you are strongly recommended to revoke the 'App Management' permission once you are done."
echo_green_text "If you are unable/unwilling to grant your Terminal this permission, you can follow the instructions here to copy the files manually: https://dove.celenity.dev#manual-installation."
"${DOVE_INSTALL_SLEEP}" 5
"${DOVE_INSTALL_OPEN}" /System/Applications/'System Settings'.app
"${DOVE_INSTALL_SLEEP}" 5
echo_red_text "Press enter to continue."
read

## Install Dove
echo_green_text "Adding celenity's Tap to Homebrew..."
brew tap celenity/tap https://gitlab.com/celenityy/tap || error_fn
echo

echo_green_text "Updating Homebrew cache..."
brew update && brew upgrade --force --verbose || error_fn
echo

echo_green_text "Downloading dev.celenity.dove.env.MOZ_CRASHREPORTER.plist..."
"${DOVE_INSTALL_CURL}" https://gitlab.com/celenityy/Dove/-/raw/pages/macos/Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER.plist || error_fn
echo

echo_green_text "Changing permissions of dev.celenity.dove.env.MOZ_CRASHREPORTER.plist to 644..."
"${DOVE_INSTALL_SUDO}" "${DOVE_INSTALL_CHMOD}" 644 dev.celenity.dove.env.MOZ_CRASHREPORTER.plist || error_fn
echo

echo_green_text "Copying dev.celenity.dove.env.MOZ_CRASHREPORTER.plist to /Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER.plist..."
"${DOVE_INSTALL_SUDO}" "${DOVE_INSTALL_CP}" dev.celenity.dove.env.MOZ_CRASHREPORTER.plist /Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER.plist || error_fn
echo

echo_green_text "Loading dev.celenity.dove.env.MOZ_CRASHREPORTER.plist..."
"${DOVE_INSTALL_LAUNCHCTL}" load /Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER.plist || error_fn
echo

echo_green_text "Downloading dev.celenity.dove.env.MOZ_CRASHREPORTER_DISABLE.plist..."
"${DOVE_INSTALL_CURL}" https://gitlab.com/celenityy/Dove/-/raw/pages/macos/Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER_DISABLE.plist || error_fn
echo

echo_green_text "Changing permissions of dev.celenity.dove.env.MOZ_CRASHREPORTER_DISABLE.plist to 644..."
"${DOVE_INSTALL_SUDO}" "${DOVE_INSTALL_CHMOD}" 644 dev.celenity.dove.env.MOZ_CRASHREPORTER_DISABLE.plist || error_fn
echo

echo_green_text "Copying dev.celenity.dove.env.MOZ_CRASHREPORTER_DISABLE.plist to /Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER_DISABLE.plist..."
"${DOVE_INSTALL_SUDO}" "${DOVE_INSTALL_CP}" dev.celenity.dove.env.MOZ_CRASHREPORTER_DISABLE.plist /Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER_DISABLE.plist || error_fn
echo

echo_green_text "Loading dev.celenity.dove.env.MOZ_CRASHREPORTER_DISABLE.plist..."
"${DOVE_INSTALL_LAUNCHCTL}" load /Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER_DISABLE.plist || error_fn
echo

echo_green_text "Downloading dev.celenity.dove.env.MOZ_CRASHREPORTER_NO_REPORT.plist..."
"${DOVE_INSTALL_CURL}" https://gitlab.com/celenityy/Dove/-/raw/pages/macos/Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER_NO_REPORT.plist || error_fn
echo

echo_green_text "Changing permissions of dev.celenity.dove.env.MOZ_CRASHREPORTER_NO_REPORT.plist to 644..."
"${DOVE_INSTALL_SUDO}" "${DOVE_INSTALL_CHMOD}" 644 dev.celenity.dove.env.MOZ_CRASHREPORTER_NO_REPORT.plist || error_fn
echo

echo_green_text "Copying dev.celenity.dove.env.MOZ_CRASHREPORTER_NO_REPORT.plist to /Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER_NO_REPORT.plist..."
"${DOVE_INSTALL_SUDO}" "${DOVE_INSTALL_CP}" dev.celenity.dove.env.MOZ_CRASHREPORTER_NO_REPORT.plist /Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER_NO_REPORT.plist || error_fn
echo

echo_green_text "Loading dev.celenity.dove.env.MOZ_CRASHREPORTER_NO_REPORT.plist..."
"${DOVE_INSTALL_LAUNCHCTL}" load /Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER_NO_REPORT.plist || error_fn
echo

echo_green_text "Downloading dev.celenity.dove.env.MOZ_CRASHREPORTER_URL.plist..."
"${DOVE_INSTALL_CURL}" https://gitlab.com/celenityy/Dove/-/raw/pages/macos/Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER_URL.plist || error_fn
echo

echo_green_text "Changing permissions of dev.celenity.dove.env.MOZ_CRASHREPORTER_URL.plist to 644..."
"${DOVE_INSTALL_SUDO}" "${DOVE_INSTALL_CHMOD}" 644 dev.celenity.dove.env.MOZ_CRASHREPORTER_URL.plist || error_fn
echo

echo_green_text "Copying dev.celenity.dove.env.MOZ_CRASHREPORTER_URL.plist to /Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER_URL.plist..."
"${DOVE_INSTALL_SUDO}" "${DOVE_INSTALL_CP}" dev.celenity.dove.env.MOZ_CRASHREPORTER_URL.plist /Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER_URL.plist || error_fn
echo

echo_green_text "Loading dev.celenity.dove.env.MOZ_CRASHREPORTER_URL.plist..."
"${DOVE_INSTALL_LAUNCHCTL}" load /Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER_URL.plist || error_fn
echo

echo_green_text "Downloading dev.celenity.dove.env.MOZ_DISABLE_ASAN_REPORTER.plist..."
"${DOVE_INSTALL_CURL}" https://gitlab.com/celenityy/Dove/-/raw/pages/macos/Library/LaunchAgents/dev.celenity.dove.env.MOZ_DISABLE_ASAN_REPORTER.plist || error_fn
echo

echo_green_text "Changing permissions of dev.celenity.dove.env.MOZ_DISABLE_ASAN_REPORTER.plist to 644..."
"${DOVE_INSTALL_SUDO}" "${DOVE_INSTALL_CHMOD}" 644 dev.celenity.dove.env.MOZ_DISABLE_ASAN_REPORTER.plist || error_fn
echo

echo_green_text "Copying dev.celenity.dove.env.MOZ_DISABLE_ASAN_REPORTER.plist to /Library/LaunchAgents/dev.celenity.dove.env.MOZ_DISABLE_ASAN_REPORTER.plist..."
"${DOVE_INSTALL_SUDO}" "${DOVE_INSTALL_CP}" dev.celenity.dove.env.MOZ_DISABLE_ASAN_REPORTER.plist /Library/LaunchAgents/dev.celenity.dove.env.MOZ_DISABLE_ASAN_REPORTER.plist || error_fn
echo

echo_green_text "Loading dev.celenity.dove.env.MOZ_DISABLE_ASAN_REPORTER.plist..."
"${DOVE_INSTALL_LAUNCHCTL}" load /Library/LaunchAgents/dev.celenity.dove.env.MOZ_DISABLE_ASAN_REPORTER.plist || error_fn
echo

echo_green_text "Downloading dev.celenity.dove.env.SSLKEYLOGFILE.plist..."
"${DOVE_INSTALL_CURL}" https://gitlab.com/celenityy/Dove/-/raw/pages/macos/Library/LaunchAgents/dev.celenity.dove.env.SSLKEYLOGFILE.plist || error_fn
echo

echo_green_text "Changing permissions of dev.celenity.dove.env.SSLKEYLOGFILE.plist to 644..."
"${DOVE_INSTALL_SUDO}" "${DOVE_INSTALL_CHMOD}" 644 dev.celenity.dove.env.SSLKEYLOGFILE.plist || error_fn
echo

echo_green_text "Copying dev.celenity.dove.env.SSLKEYLOGFILE.plist to /Library/LaunchAgents/dev.celenity.dove.env.SSLKEYLOGFILE.plist..."
"${DOVE_INSTALL_SUDO}" "${DOVE_INSTALL_CP}" dev.celenity.dove.env.SSLKEYLOGFILE.plist /Library/LaunchAgents/dev.celenity.dove.env.SSLKEYLOGFILE.plist || error_fn
echo

echo_green_text "Loading dev.celenity.dove.env.SSLKEYLOGFILE.plist..."
"${DOVE_INSTALL_LAUNCHCTL}" load /Library/LaunchAgents/dev.celenity.dove.env.SSLKEYLOGFILE.plist || error_fn
echo

echo_green_text "Creating /Library/celenity/Dove directory..."
"${DOVE_INSTALL_SUDO}" "${DOVE_INSTALL_MKDIR}" /Library/celenity/Dove || error_fn
echo

echo_green_text "Changing permissions of Library/celenity/Dove to 744..."
"${DOVE_INSTALL_SUDO}" "${DOVE_INSTALL_CHMOD}" 744 /Library/celenity/Dove || error_fn
echo

echo -e ""
echo_green_text "Are you using an Apple Silicon (M-series chip) or Intel device?";
echo_green_text "Your options are:";
echo_red_text "1. Silicon";
echo_green_text "2. Intel";
read "DEVICETYPE?Please enter your selection: "
case ${DEVICETYPE} in
	"apple" | "Apple" | "APPLE" | "silicon" | "Silicon" | "SILICON" | 1)
		echo_green_text "Installing dove package..."
		brew install dove || error_fn
		echo

        echo_green_text "Downloading dove-apply.sh..."
		curl --cert-status -O -sSL https://gitlab.com/celenityy/Dove/-/raw/pages/macos/Library/celenity/Dove/dove-apply.sh || error_fn
		echo

		echo_green_text "Changing permissions of dove-apply.sh to 744..."
		"${DOVE_INSTALL_SUDO}" "${DOVE_INSTALL_CHMOD}" 744 dove-apply.sh || error_fn
		echo

		echo_green_text "Copying dove-apply.sh to /Library/celenity/Dove/dove-apply.sh..."
		"${DOVE_INSTALL_SUDO}" "${DOVE_INSTALL_CP}" dove-apply.sh /Library/celenity/Dove/dove-apply.sh || error_fn
		echo
		echo_green_text "Copying dove-apply.sh to /Library/celenity/Dove/dove-apply.sh..."
		"${DOVE_INSTALL_SUDO}" "${DOVE_INSTALL_CP}" dove-apply.sh /Library/celenity/Dove/dove-apply.sh || error_fn
		echo

		echo_green_text "Downloading dev.celenity.dove.apply.plist..."
		curl --cert-status -O -sSL https://gitlab.com/celenityy/Dove/-/raw/pages/macos/Library/LaunchDaemons/dev.celenity.dove.apply.plist || error_fn
		echo

		echo_green_text "Changing permissions of dev.celenity.dove.apply.plist to 644..."
		"${DOVE_INSTALL_SUDO}" "${DOVE_INSTALL_CHMOD}" 644 dev.celenity.dove.apply.plist || error_fn
		echo
		echo_green_text "Changing permissions of dev.celenity.dove.apply.plist to 644..."
		"${DOVE_INSTALL_SUDO}" "${DOVE_INSTALL_CHMOD}" 644 dev.celenity.dove.apply.plist || error_fn
		echo

		echo_green_text "Copying dev.celenity.dove.apply.plist to /Library/LaunchDaemons/dev.celenity.dove.apply.plist..."
		"${DOVE_INSTALL_SUDO}" "${DOVE_INSTALL_CP}" dev.celenity.dove.apply.plist /Library/LaunchDaemons/dev.celenity.dove.apply.plist || error_fn
		echo
		echo_green_text "Copying dev.celenity.dove.apply.plist to /Library/LaunchDaemons/dev.celenity.dove.apply.plist..."
		"${DOVE_INSTALL_SUDO}" "${DOVE_INSTALL_CP}" dev.celenity.dove.apply.plist /Library/LaunchDaemons/dev.celenity.dove.apply.plist || error_fn
		echo

		echo_green_text "Loading dev.celenity.dove.apply.plist..."
		"${DOVE_INSTALL_SUDO}" "${DOVE_INSTALL_LAUNCHCTL}" load -w /Library/LaunchDaemons/dev.celenity.dove.apply.plist || error_fn
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
				"${DOVE_INSTALL_SUDO}" "${DOVE_INSTALL_XATTR}" /Applications/Thunderbird.app

				echo_green_text "Creating /Applications/Thunderbird.app/Contents/Resources/defaults/pref directory..."
				"${DOVE_INSTALL_SUDO}" "${DOVE_INSTALL_MKDIR}" /Applications/Thunderbird.app/Contents/Resources/defaults/pref || error_fn
				echo

				echo_green_text "Changing permissions of /Applications/Thunderbird.app/Contents/Resources/defaults/pref to 755..."
				"${DOVE_INSTALL_SUDO}" "${DOVE_INSTALL_CHMOD}" -R 755 /Applications/Thunderbird.app/Contents/Resources/defaults/pref || error_fn
				echo

				echo_green_text "Creating a symlink from /opt/homebrew/opt/dove/defaults/pref/dove.js to /Applications/Thunderbird.app/Contents/Resources/defaults/pref/dove.js..."
				"${DOVE_INSTALL_SUDO}" "${DOVE_INSTALL_LS}" /opt/homebrew/opt/dove/defaults/pref/dove.js /Applications/Thunderbird.app/Contents/Resources/defaults/pref/dove.js || error_fn
				echo

				echo_green_text "Creating a symlink from /opt/homebrew/opt/dove/macos/dove.cfg to /Applications/Thunderbird.app/Contents/Resources/dove.cfg.."
				"${DOVE_INSTALL_SUDO}" "${DOVE_INSTALL_LS}" /opt/homebrew/opt/dove/macos/dove.cfg /Applications/Thunderbird.app/Contents/Resources/dove.cfg || error_fn
				echo
				;;

			"user" | "User" | "USER" | 2)
				## Ensure Thunderbird isn't quarantined so we don't break it...
				# https://support.mozilla.org/kb/deploying-firefox-customizations-macos
				"${DOVE_INSTALL_XATTR}" "${HOME}/Applications/Thunderbird.app"

				echo_green_text "Creating ${HOME}/Applications/Thunderbird.app/Contents/Resources/defaults/pref directory..."
				"${DOVE_INSTALL_MKDIR}" "${HOME}/Applications/Thunderbird.app/Contents/Resources/defaults/pref" || error_fn
				echo

				echo_green_text "Creating a symlink from /opt/homebrew/opt/dove/defaults/pref/dove.js to "${HOME}/Applications/Thunderbird.app/Contents/Resources/defaults/pref/dove.js"..."
				"${DOVE_INSTALL_LS}" /opt/homebrew/opt/dove/defaults/pref/dove.js "${HOME}/Applications/Thunderbird.app/Contents/Resources/defaults/pref/dove.js" || error_fn
				echo

				echo_green_text "Creating a symlink from /opt/homebrew/opt/dove/macos/dove.cfg to "${HOME}/Applications/Thunderbird.app/Contents/Resources/dove.cfg".."
				"${DOVE_INSTALL_LS}" /opt/homebrew/opt/dove/macos/dove.cfg "${HOME}/Applications/Thunderbird.app/Contents/Resources/dove.cfg" || error_fn
				echo
				;;
		esac
		;;

	"intel" | "Intel" | "INTEL" | 2)
		echo_green_text "Installing dove-intel package..."
		brew install dove-intel || error_fn
		echo

		echo_green_text "Downloading dove-apply-intel.sh..."
		curl --cert-status -O -sSL https://gitlab.com/celenityy/Dove/-/raw/pages/macos-intel/Library/celenity/Dove/dove-apply-intel.sh || error_fn
		echo

		echo_green_text "Changing permissions of dove-apply-intel.sh to 744..."
		"${DOVE_INSTALL_SUDO}" "${DOVE_INSTALL_CHMOD}" 744 dove-apply-intel.sh || error_fn
		echo

		echo_green_text "Copying dove-apply-intel.sh to /Library/celenity/Dove/dove-apply-intel.sh..."
		"${DOVE_INSTALL_SUDO}" "${DOVE_INSTALL_CP}" dove-apply-intel.sh /Library/celenity/Dove/dove-apply-intel.sh || error_fn
		echo

		echo_green_text "Downloading dev.celenity.dove.apply.intel.plist..."
		curl --cert-status -O -sSL https://gitlab.com/celenityy/Dove/-/raw/pages/macos-intel/Library/LaunchDaemons/dev.celenity.dove.apply.intel.plist || error_fn
		echo

		echo_green_text "Changing permissions of dev.celenity.dove.apply.intel.plist to 644..."
		"${DOVE_INSTALL_SUDO}" "${DOVE_INSTALL_CHMOD}" 644 dev.celenity.dove.apply.intel.plist || error_fn
		echo

		echo_green_text "Copying dev.celenity.dove.apply.intel.plist to /Library/LaunchDaemons/dev.celenity.dove.apply.intel.plist..."
		"${DOVE_INSTALL_SUDO}" "${DOVE_INSTALL_CP}" dev.celenity.dove.apply.intel.plist /Library/LaunchDaemons/dev.celenity.dove.apply.intel.plist || error_fn
		echo

		echo_green_text "Loading dev.celenity.dove.apply.intel.plist..."
		"${DOVE_INSTALL_SUDO}" "${DOVE_INSTALL_LAUNCHCTL}" load -w /Library/LaunchDaemons/dev.celenity.dove.apply.intel.plist || error_fn
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
				"${DOVE_INSTALL_SUDO}" "${DOVE_INSTALL_XATTR}" /Applications/Thunderbird.app

				echo_green_text "Creating /Applications/Thunderbird.app/Contents/Resources/defaults/pref directory..."
				"${DOVE_INSTALL_SUDO}" "${DOVE_INSTALL_MKDIR}" /Applications/Thunderbird.app/Contents/Resources/defaults/pref || error_fn
				echo

				echo_green_text "Changing permissions of /Applications/Thunderbird.app/Contents/Resources/defaults/pref to 755..."
				"${DOVE_INSTALL_SUDO}" "${DOVE_INSTALL_CHMOD}" -R 755 /Applications/Thunderbird.app/Contents/Resources/defaults/pref || error_fn
				echo

				echo_green_text "Creating a symlink from /usr/local/opt/dove-intel/defaults/pref/dove.js to /Applications/Thunderbird.app/Contents/Resources/defaults/pref/dove.js..."
				"${DOVE_INSTALL_SUDO}" "${DOVE_INSTALL_LS}" /usr/local/opt/dove-intel/defaults/pref/dove.js /Applications/Thunderbird.app/Contents/Resources/defaults/pref/dove.js || error_fn
				echo

				echo_green_text "Creating a symlink from /usr/local/opt/dove-intel/dove.cfg to /Applications/Thunderbird.app/Contents/Resources/dove.cfg.."
				"${DOVE_INSTALL_SUDO}" "${DOVE_INSTALL_LS}" /usr/local/opt/dove-intel/dove.cfg /Applications/Thunderbird.app/Contents/Resources/dove.cfg || error_fn
				echo
				;;

			"user" | "User" | "USER" | 2)
				## Ensure Thunderbird isn't quarantined so we don't break it...
				# https://support.mozilla.org/kb/deploying-firefox-customizations-macos
				"${DOVE_INSTALL_XATTR}" "${HOME}/Applications/Thunderbird.app"

				echo_green_text "Creating ${HOME}/Applications/Thunderbird.app/Contents/Resources/defaults/pref directory..."
				"${DOVE_INSTALL_MKDIR}" "${HOME}/Applications/Thunderbird.app/Contents/Resources/defaults/pref" || error_fn
				echo

				echo_green_text "Creating a symlink from /usr/local/opt/dove-intel/defaults/pref/dove.js to "${HOME}/Applications/Thunderbird.app/Contents/Resources/defaults/pref/dove.js"..."
				"${DOVE_INSTALL_LS}" /usr/local/opt/dove-intel/defaults/pref/dove.js "${HOME}/Applications/Thunderbird.app/Contents/Resources/defaults/pref/dove.js" || error_fn
				echo

				echo_green_text "Creating a symlink from /usr/local/opt/dove-intel/dove.cfg to "${HOME}/Applications/Thunderbird.app/Contents/Resources/dove.cfg".."
				"${DOVE_INSTALL_LS}" /usr/local/opt/dove-intel/dove.cfg "${HOME}/Applications/Thunderbird.app/Contents/Resources/dove.cfg" || error_fn
				echo
				;;
		esac
		;;
esac

popd

echo_red_text "You must now revoke the 'App Management' permission from your Terminal by navigating to 'System Settings' -> 'Privacy & Security' -> 'App Management'"
echo_green_text "PLEASE SELECT "Later" WHEN IT ASKS YOU TO QUIT AND RE-OPEN YOUR TERMINAL..."
"${DOVE_INSTALL_SLEEP}" 5
"${DOVE_INSTALL_OPEN}" /System/Applications/'System Settings'.app
"${DOVE_INSTALL_SLEEP}" 5
echo_green_text "Press enter to continue once you are finished."
read

echo_green_text "All done. Congratulations, you've successfully installed Dove.\nEnjoy :)\n"

echo_red_text "Your system will now reboot to finalize your installation."
"${DOVE_INSTALL_SLEEP}" 5
echo_green_text "Press enter to continue."
read

"${DOVE_INSTALL_SUDO}" /sbin/reboot
