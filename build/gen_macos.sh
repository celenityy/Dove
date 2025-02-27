#!/usr/bin/env bash

python3 build/convert.py prefs/dove.js build/configs/dove-spec.cfg

awk '!/NO-OSX/' build/configs/dove-spec.cfg > macos/dove.cfg
