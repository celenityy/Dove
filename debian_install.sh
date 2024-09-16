#! /usr/bin/env bash


cd /tmp


echo_red_text() {
	echo -e "\033[31m$1\033[0m"
}


echo_green_text() {
	echo -e "\033[32m$1\033[0m"
}

error_fn() {
	echo
	echo -e "\033[31mSomething went wrong! The script failed.\033[0m"
	echo
	exit 1
}


if [ $(id --user) -ne 0 ]; then
	echo_red_text "You must run this script with sudo"
	echo
	exit 1
fi


echo_green_text "Downloading mozilla.cfg"
wget -nv https://dove.celenity.dev/mozilla.cfg || error_fn
echo


echo_green_text "Moving mozilla.cfg to /usr/lib/thunderbird/mozilla.cfg"
sudo mv -v mozilla.cfg /usr/lib/thunderbird/mozilla.cfg || error_fn
echo


echo_green_text "Downloading local-settings.js"
wget -nv https://dove.celenity.dev/defaults/pref/local-settings.js || error_fn
echo


echo_green_text "Creating /usr/lib/thunderbird/defaults/pref directory"
sudo mkdir -v -p /usr/lib/thunderbird/defaults/pref || error_fn
echo

echo_green_text "Changing permissions of /usr/lib/thunderbird/defaults/pref to 755"
sudo chmod -v 755 /usr/lib/thunderbird/defaults/pref || error_fn
echo


echo_green_text "Moving local-settings.js to /usr/lib/thunderbird/defaults/pref/local-settings.js"
sudo mv -v local-settings.js /usr/lib/thunderbird/defaults/pref/local-settings.js || error_fn
echo


echo_green_text "Installing the lsb-release dependency if not already installed"
sudo apt install lsb-release || error_fn
echo

echo_green_text "Adding Prebuilt MPR repo if not already installed"
curl -q 'https://proget.makedeb.org/debian-feeds/prebuilt-mpr.pub' | gpg --dearmor | sudo tee /usr/share/keyrings/prebuilt-mpr-archive-keyring.gpg 1> /dev/null
echo "deb [signed-by=/usr/share/keyrings/prebuilt-mpr-archive-keyring.gpg] https://proget.makedeb.org prebuilt-mpr $(lsb_release -cs)" | sudo tee /etc/apt/sources.list.d/prebuilt-mpr.list
echo

echo_green_text "Updating APT cache"
sudo apt update || error_fn
echo


echo_green_text "Installing dove-policies package"
sudo apt install dove-policies || error_fn
echo


echo_green_text "All done. Congratulations, you've successfully installed Dove.\nEnjoy :)\n"
