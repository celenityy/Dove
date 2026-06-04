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
	echo_red_text "Something went wrong! The script failed."
	echo_red_text "Please report this (with the output message) to https://dove.celenity.dev/issues"
	echo
	exit 1
}

# launchctl
DOVE_INSTALL_LAUNCHCTL='/bin/launchctl'

# mkdir
DOVE_INSTALL_MKDIR='/bin/mkdir -vp'

# sleep
DOVE_INSTALL_SLEEP='/bin/sleep'

# sudo
DOVE_INSTALL_SUDO='/usr/bin/sudo'

# Save temporary files/downloads to /tmp
DOVE_INSTALL_TEMP='/tmp'

pushd "${DOVE_INSTALL_TEMP}"

echo_green_text "Welcome to the Dove environment variable updater for macOS!"

echo_green_text "Downloading dev.celenity.dove.env.MOZ_CRASHREPORTER.plist..."
curl --disable --no-netrc --clobber --create-dirs --delegation none --disallow-username-in-url --doh-cert-status --fail --ftp-create-dirs --ftp-ssl-control --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-proxy-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ssl-allow-beast --no-proxy-ssl-auto-client-cert --no-sessionid --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-tls-earlydata --no-xattr --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer "" --remove-on-error --show-error --ssl-reqd --tlsv1.2 --trace-time --user-agent "" --verbose --location https://gitlab.com/celenityy/Dove/-/raw/pages/osx/shared/Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER.plist --output "${DOVE_INSTALL_TEMP}/dev.celenity.dove.env.MOZ_CRASHREPORTER.plist" || error_fn
echo

echo_green_text "Changing permissions of dev.celenity.dove.env.MOZ_CRASHREPORTER.plist to 644..."
sudo chmod -v 644 dev.celenity.dove.env.MOZ_CRASHREPORTER.plist || error_fn
echo

echo_green_text "Copying dev.celenity.dove.env.MOZ_CRASHREPORTER.plist to /Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER.plist..."
sudo cp dev.celenity.dove.env.MOZ_CRASHREPORTER.plist /Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER.plist || error_fn
echo

echo_green_text "Loading dev.celenity.dove.env.MOZ_CRASHREPORTER.plist..."
"${DOVE_INSTALL_LAUNCHCTL}" load /Library/LaunchAgents/dev.celenity.dove.env.MOZ_CRASHREPORTER.plist || error_fn
echo

echo_green_text "Downloading dev.celenity.dove.env.MOZ_GFX_CRASH_TELEMETRY.plist..."
curl --disable --no-netrc --clobber --create-dirs --delegation none --disallow-username-in-url --doh-cert-status --fail --ftp-create-dirs --ftp-ssl-control --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-proxy-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ssl-allow-beast --no-proxy-ssl-auto-client-cert --no-sessionid --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-tls-earlydata --no-xattr --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer "" --remove-on-error --show-error --ssl-reqd --tlsv1.2 --trace-time --user-agent "" --verbose --location https://gitlab.com/celenityy/Dove/-/raw/pages/osx/shared/Library/LaunchAgents/dev.celenity.dove.env.MOZ_GFX_CRASH_TELEMETRY.plist --output "${DOVE_INSTALL_TEMP}/dev.celenity.dove.env.MOZ_GFX_CRASH_TELEMETRY.plist" || error_fn
echo

echo_green_text "Changing permissions of dev.celenity.dove.env.MOZ_GFX_CRASH_TELEMETRY.plist to 644..."
sudo chmod -v 644 dev.celenity.dove.env.MOZ_GFX_CRASH_TELEMETRY.plist || error_fn
echo

echo_green_text "Copying dev.celenity.dove.env.MOZ_GFX_CRASH_TELEMETRY.plist to /Library/LaunchAgents/dev.celenity.dove.env.MOZ_GFX_CRASH_TELEMETRY.plist..."
sudo cp dev.celenity.dove.env.MOZ_GFX_CRASH_TELEMETRY.plist /Library/LaunchAgents/dev.celenity.dove.env.MOZ_GFX_CRASH_TELEMETRY.plist || error_fn
echo

echo_green_text "Loading dev.celenity.dove.env.MOZ_GFX_CRASH_TELEMETRY.plist..."
"${DOVE_INSTALL_LAUNCHCTL}" load /Library/LaunchAgents/dev.celenity.dove.env.MOZ_GFX_CRASH_TELEMETRY.plist || error_fn
echo

echo_green_text "Downloading dev.celenity.dove.env.SSLKEYLOGFILE.plist..."
curl --disable --no-netrc --clobber --create-dirs --delegation none --disallow-username-in-url --doh-cert-status --fail --ftp-create-dirs --ftp-ssl-control --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-proxy-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ssl-allow-beast --no-proxy-ssl-auto-client-cert --no-sessionid --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-tls-earlydata --no-xattr --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer "" --remove-on-error --show-error --ssl-reqd --tlsv1.2 --trace-time --user-agent "" --verbose --location https://gitlab.com/celenityy/Dove/-/raw/pages/osx/shared/Library/LaunchAgents/dev.celenity.dove.env.SSLKEYLOGFILE.plist --output "${DOVE_INSTALL_TEMP}/dev.celenity.dove.env.SSLKEYLOGFILE.plist" || error_fn
echo

echo_green_text "Changing permissions of dev.celenity.dove.env.SSLKEYLOGFILE.plist to 644..."
sudo chmod -v 644 dev.celenity.dove.env.SSLKEYLOGFILE.plist || error_fn
echo

echo_green_text "Copying dev.celenity.dove.env.SSLKEYLOGFILE.plist to /Library/LaunchAgents/dev.celenity.dove.env.SSLKEYLOGFILE.plist..."
sudo cp dev.celenity.dove.env.SSLKEYLOGFILE.plist /Library/LaunchAgents/dev.celenity.dove.env.SSLKEYLOGFILE.plist || error_fn
echo

echo_green_text "Loading dev.celenity.dove.env.SSLKEYLOGFILE.plist..."
"${DOVE_INSTALL_LAUNCHCTL}" load /Library/LaunchAgents/dev.celenity.dove.env.SSLKEYLOGFILE.plist || error_fn
echo

popd

echo_green_text "All done. :) Congratulations, you've successfully updated Dove's environment variables.\n"

echo_red_text "Your system will now reboot to finalize your changes."
"${DOVE_INSTALL_SLEEP}" 5 || error_fn
echo
echo_green_text "Press enter to continue."
read

"${DOVE_INSTALL_SUDO}" /sbin/reboot
