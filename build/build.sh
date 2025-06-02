#!/usr/bin/env bash

source build/env.sh

if [[ "$OSTYPE" == "darwin"* ]]; then
    # Update "mail.dove.version"
    sed -i '' "s/pref(\"mail.dove.version\", \".*\", locked);/pref(\"mail.dove.version\", \"$dove_version\", locked);/" build/dove-unified.js
    # Update "distribution.about"
    sed -i '' "s/pref(\"distribution.about\", \".*\", locked);/pref(\"distribution.about\", \"Dove for Mozilla Thunderbird - $dove_version 💜\", locked);/" build/dove-unified.js
else
    # Update "mail.dove.version"
    sed -i "s/pref(\"mail.dove.version\", \".*\", locked);/pref(\"mail.dove.version\", \"$dove_version\", locked);/" build/dove-unified.js
    # Update "distribution.about"
    sed -i "s/pref(\"distribution.about\", \".*\", locked);/pref(\"distribution.about\", \"Dove for Mozilla Thunderbird - $dove_version 💜\", locked);/" build/dove-unified.js
fi

./build/fly.sh && ./build/gen_archive.sh
