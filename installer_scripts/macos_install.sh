#! /usr/bin/env bash


## Downloaded files save in /tmp for moving
cd /tmp


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

## Install Dove
echo_green_text "Downloading dove.cfg..."
wget -nv https://dove.celenity.dev/dove.cfg || error_fn
echo

echo_green_text "Moving dove.cfg to /Applications/Thunderbird.app/Contents/Resources/dove.cfg..."
sudo mv -v dove.cfg /Applications/Thunderbird.app/Contents/Resources/dove.cfg || error_fn
echo

echo_green_text "Downloading dove.js..."
wget -nv https://dove.celenity.dev/defaults/pref/dove.js || error_fn
echo

echo_green_text "Creating /Applications/Thunderbird.app/Contents/Resources/defaults/pref directory..."
sudo mkdir -v -p /Applications/Thunderbird.app/Contents/Resources/defaults/pref || error_fn
echo

echo_green_text "Changing permissions of /Applications/Thunderbird.app/Contents/Resources/defaults/pref to 655..."
sudo chmod -v 655 /Applications/Thunderbird.app/Contents/Resources/defaults/pref || error_fn
echo

echo_green_text "Moving dove.js to /Applications/Thunderbird.app/Contents/Resources/defaults/pref/dove.js..."
sudo mv -v dove.js /Applications/Thunderbird.app/Contents/Resources/defaults/pref/dove.js || error_fn
echo

echo_green_text "Adding celenity's Tap to Homebrew..."
brew tap celenity/tap https://codeberg.org/celenity/tap || error_fn
echo

echo_green_text "Updating Homebrew cache..."
brew update && brew upgrade --force --verbose || error_fn
echo

echo_green_text "Installing dove-policies package..."
brew install dove-policies || error_fn
echo

echo_green_text "Moving Dove's policies.json from /opt/homebrew/opt/dove-policies/etc/thunderbird/distribution/policies.json to /Applications/Thunderbird.app/Contents/Resources/distribution/policies.json..."
cp /opt/homebrew/opt/dove-policies/etc/thunderbird/distribution/policies.json /Applications/Thunderbird.app/Contents/Resources/distribution/policies.json || error_fn
echo

echo_green_text "Creating a script to automatically copy Dove's policies.json from /opt/homebrew/opt/dove-policies/etc/thunderbird/distribution/policies.json to /Applications/Thunderbird.app/Contents/Resources/distribution/policies.json for updates..."
cat << 'EOF' > /usr/local/sbin/update_policies_dove.sh
#!/bin/zsh
cp /opt/homebrew/opt/dove-policies/etc/thunderbird/distribution/policies.json /Applications/Thunderbird.app/Contents/Resources/distribution/policies.json
EOF || error_fn
echo

echo_green_text "Making /usr/local/sbin/update_policies_dove.sh executable..."
sudo chmod -v +x /usr/local/sbin/update_policies_dove.sh || error_fn
echo

echo_green_text "Creating a launch agent to automatically copy Dove's policies.json from /opt/homebrew/opt/dove-policies/etc/thunderbird/distribution/policies.json to /Applications/Thunderbird.app/Contents/Resources/distribution/policies.json for updates..."
cat << 'EOF' > ~/Library/LaunchAgents/com.user.updatepoliciesdove.plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.user.updatepoliciesdove</string>
    <key>ProgramArguments</key>
    <array>
        <string>/usr/local/sbin/update_policies_dove.sh</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>StartInterval</key>
    <integer>21600</integer> <!-- 6 hours in seconds -->
</dict>
</plist>
EOF || error_fn
echo

echo_green_text "Loading  ~/Library/LaunchAgents/com.user.updatepoliciesdove.plist..."
launchctl load ~/Library/LaunchAgents/com.user.updatepoliciesdove.plist || error_fn
echo

echo_green_text "Setting a 'dove-up' alias to easily update Dove's policies..."
echo 'alias dove-up="cp /opt/homebrew/opt/dove-policies/etc/thunderbird/distribution/policies.json /Applications/Thunderbird.app/Contents/Resources/distribution/policies.json"' >> ~/.zshrc || error_fn
echo

echo_green_text "All done. :) Congratulations, you've successfully installed Dove."

echo_green_text "NOTE: Due to macOS limitations, by default, your policies will only update every 6 hours or on device boot. If you want to enforce a policies update, you can run "dove-up" after the update is downloaded download with Homebrew.\nYou can also set an alias in your ~/.zshrc to make this easier, such as:\nalias update='brew update && brew upgrade --force && dove-up'"
