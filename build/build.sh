#!/usr/bin/env bash

source build/env.sh

# Update `mail.dove.version`
sed -i "s/pref(\"mail.dove.version\", \".*\", locked);/pref(\"mail.dove.version\", \"$dove_version\", locked);/" build/prefs/dove.js

./build/gen_dove.sh && ./build/gen_macos.sh && ./build/gen_policies.sh && ./build/gen_archive.sh
