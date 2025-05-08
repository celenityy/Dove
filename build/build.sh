#!/usr/bin/env bash

source build/env.sh

if [[ "$OSTYPE" == "darwin"* ]]; then
    # Update "mail.dove.version"
    sed -i '' "s/pref(\"mail.dove.version\", \".*\", locked);/pref(\"mail.dove.version\", \"$dove_version\", locked);/" build/prefs/dove.js
    # Update "distribution.about"
    sed -i '' "s/pref(\"distribution.about\", \".*\", locked);/pref(\"distribution.about\", \"Dove for Mozilla Thunderbird - $dove_version 💜\", locked);/" build/prefs/dove.js
else
    # Update "mail.dove.version"
    sed -i "s/pref(\"mail.dove.version\", \".*\", locked);/pref(\"mail.dove.version\", \"$dove_version\", locked);/" build/prefs/dove.js
    # Update "distribution.about"
    sed -i "s/pref(\"distribution.about\", \".*\", locked);/pref(\"distribution.about\", \"Dove for Mozilla Thunderbird - $dove_version 💜\", locked);/" build/prefs/dove.js
fi

./build/gen_dove.sh && ./build/gen_macos.sh && ./build/gen_policies.sh && ./build/gen_archive.sh
