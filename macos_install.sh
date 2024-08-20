#!/bin/zsh

wget https://codeberg.org/Magnesium1062/Dove/raw/branch/main/mozilla.cfg

sudo mv mozilla.cfg /Applications/Thunderbird.app/Contents/Resources/mozilla.cfg

wget https://codeberg.org/Magnesium1062/Dove/raw/branch/main/defaults/pref/local-settings.js

sudo mkdir -p /Applications/Thunderbird.app/Contents/Resources/defaults/pref

sudo chmod 755 /Applications/Thunderbird.app/Contents/Resources/defaults/pref

sudo mv local-settings.js /Applications/Thunderbird.app/Contents/Resources/defaults/pref/local-settings.js

brew tap Magnesium1062/Dove-Policies-macOS https://codeberg.org/Magnesium1062/Dove-Policies-macOS

brew update

brew upgrade --force

brew install dove-policies

cp /opt/homebrew/opt/dove-policies/etc/thunderbird/distribution/policies.json /Applications/Thunderbird.app/Contents/Resources/distribution/policies.json

cat << 'EOF' > /usr/local/sbin/update_policies_dove.sh
#!/bin/zsh
cp /opt/homebrew/opt/dove-policies/etc/thunderbird/distribution/policies.json /Applications/Thunderbird.app/Contents/Resources/distribution/policies.json
EOF

sudo chmod +x /usr/local/sbin/update_policies_dove.sh

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
EOF

launchctl load ~/Library/LaunchAgents/com.user.updatepoliciesdove.plist

echo 'alias dove-up="cp /opt/homebrew/opt/dove-policies/etc/thunderbird/distribution/policies.json /Applications/Thunderbird.app/Contents/Resources/distribution/policies.json"' >> ~/.zshrc

printf "All done. :) Congratulations, you've successfully installed Dove."

printf "NOTE: Due to macOS limitations, by default, your policies will only update every 6 hours or on device boot. If you want to enforce a policies update, you can run "dove-up" after the update is downloaded download with Homebrew.\nYou can also set an alias in your ~/.zshrc to make this easier, such as:\nalias update='brew update && brew upgrade --force && dove-up'"