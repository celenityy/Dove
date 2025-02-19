#!/bin/bash

# Replace ~/Projects/Phoenix with the directory where Phoenix is located

cat ~/Projects/Phoenix/build/prefs/phoenix-core.js ~/Projects/Phoenix/build/prefs/phoenix-desktop-common.js ~/Projects/Phoenix/build/prefs/extended/phoenix-extended-core.js ~/Projects/Phoenix/build/prefs/extended/phoenix-extended-desktop-common.js build/prefs/dove.js > prefs/dove.js

python3 build/convert.py prefs/dove.js dove.cfg

awk '!/NO-OSX/' dove.cfg > macos/dove.cfg
