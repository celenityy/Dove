#!/usr/bin/env bash

cat "$phoenix_dir/build/prefs/phoenix-core.js" "$phoenix_dir/build/prefs/phoenix-desktop-common.js" "$phoenix_dir/build/prefs/extended/phoenix-extended-core.js" "$phoenix_dir/build/prefs/extended/phoenix-extended-desktop-common.js" build/prefs/dove.js > prefs/dove.js
