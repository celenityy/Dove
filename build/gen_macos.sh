#!/usr/bin/env bash

python3 build/convert.py prefs/dove.js configs/dove.cfg

awk '!/NO-OSX/' configs/dove.cfg > macos/dove.cfg
