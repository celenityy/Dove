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

## Ensure Thunderbird isn't quarantined so we don't break it...
# https://support.mozilla.org/kb/deploying-firefox-customizations-macos
sudo xattr -v -r -d com.apple.quarantine /Applications/Thunderbird.app

echo_green_text "Changing permissions of dove-bootstrap.js to 644..."
sudo /bin/chmod -v 644 dove-bootstrap.js || error_fn
echo

echo_green_text "Changing permissions of dove-bootstrap.cfg to 644..."
sudo /bin/chmod -v 644 dove-bootstrap.cfg || error_fn
echo

echo_green_text "Creating /Applications/Thunderbird.app/Contents/Resources/defaults/pref directory..."
sudo /bin/mkdir -v -p /Applications/Thunderbird.app/Contents/Resources/defaults/pref || error_fn
echo

echo_green_text "Copying dove-bootstrap.js to /Applications/Thunderbird.app/Contents/Resources/defaults/pref/dove-bootstrap.js..."
sudo /bin/cp dove-bootstrap.js /Applications/Thunderbird.app/Contents/Resources/defaults/pref/dove-bootstrap.js || error_fn
echo

echo_green_text "Copying dove-bootstrap.cfg to /Applications/Thunderbird.app/Contents/Resources/dove-bootstrap.cfg.."
sudo /bin/cp dove-bootstrap.cfg /Applications/Thunderbird.app/Contents/Resources/dove-bootstrap.cfg || error_fn
echo

echo_red_text "You must now revoke the 'App Management' permission from your Terminal by navigating to 'System Settings' -> 'Privacy & Security' -> 'App Management'"
echo_green_text "PLEASE SELECT "Later" WHEN IT ASKS YOU TO QUIT AND RE-OPEN YOUR TERMINAL..."
/bin/sleep 5
open /System/Applications/'System Settings'.app
/bin/sleep 5
echo_green_text "Press enter to continue once you are finished."
read

echo_green_text "All done. Congratulations, you've successfully installed Dove.\nEnjoy :)\n"

echo_red_text "Your system will now reboot to finalize your installation."
/bin/sleep 5
echo_green_text "Press enter to continue."
read

sudo reboot
