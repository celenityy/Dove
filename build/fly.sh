#!/usr/bin/env bash

# Welcome to the Dove Unified build script!
# This script should be ran from inside the directory where you store Dove, not directly from the 'archives' or `build` folder...

export DOVE_LICENSE="COPYING"
export DOVE_README="README.md"

export PHOENIX_UNIFIED_PREFS="$phoenix_dir/build/phoenix-unified.js"
export DOVE_UNIFIED_PREFS="build/dove-unified.js"

export DOVE_LINUX_PREFS="linux/defaults/pref/dove.js"
export DOVE_OSX_INTEL_PREFS="unused/macos-intel/dove.js"
export DOVE_OSX_PREFS="unused/macos/dove.js"
export DOVE_WINDOWS_PREFS="unused/windows/dove.js"

export DOVE_BOOTSTRAP="build/dove-bootstrap.js"

export DOVE_OSX_BOOTSTRAP="macos/defaults/pref/dove.js"
export DOVE_OSX_INTEL_BOOTSTRAP="macos-intel/defaults/pref/dove.js"
export DOVE_WINDOWS_BOOTSTRAP="windows/defaults/pref/dove.js"

export DOVE_USER_PREF_CFG="build/dove-user-pref.cfg"

export DOVE_LINUX_USER_PREF_CFG="linux/dove.cfg"

export DOVE_LINUX_CFG="unused/linux/dove.cfg"
export DOVE_OSX_CFG="macos/macos/dove.cfg"
export DOVE_OSX_INTEL_CFG="macos-intel/dove.cfg"
export DOVE_WINDOWS_CFG="windows/dove.cfg"

export PHOENIX_EXTENDED_UNIFIED_PREFS="$phoenix_dir/build/phoenix-extended-unified.js"

export PHOENIX_UNIFIED_POLICIES="$phoenix_dir/build/policies/phoenix-unified.json"

export PHOENIX_BLOCKLIST_POLICIES="$phoenix_dir/build/policies/blocklist.json"
export PHOENIX_COOKIES_POLICIES="$phoenix_dir/build/policies/cookies.json"

export PHOENIX_UNIFIED_LINUX_POLICIES="$phoenix_dir/build/policies/phoenix-linux-unified.json"
export PHOENIX_UNIFIED_OSX_INTEL_POLICIES="$phoenix_dir/build/policies/phoenix-osx-intel-unified.json"
export PHOENIX_UNIFIED_OSX_POLICIES="$phoenix_dir/build/policies/phoenix-osx-unified.json"
export PHOENIX_UNIFIED_OSX_SILICON_POLICIES="$phoenix_dir/build/policies/phoenix-osx-silicon-unified.json"
export PHOENIX_UNIFIED_WINDOWS_POLICIES="$phoenix_dir/build/policies/phoenix-windows-unified.json"

export DOVE_UNIFIED_POLICIES="build/policies/dove-unified.json"

export DOVE_UNIFIED_LINUX_POLICIES="build/policies/dove-linux.json"
export DOVE_UNIFIED_OSX_INTEL_POLICIES="build/policies/dove-osx-intel.json"
export DOVE_UNIFIED_OSX_POLICIES="build/policies/dove-osx.json"
export DOVE_UNIFIED_OSX_SILICON_POLICIES="build/policies/dove-osx-silicon.json"
export DOVE_UNIFIED_WINDOWS_POLICIES="build/policies/dove-windows.json"

export DOVE_POLICIES="unused/policies/dove.json"

export DOVE_LINUX_POLICIES="linux/policies/policies.json"
export DOVE_WINDOWS_POLICIES="windows/distribution/policies.json"

export DOVE_OSX_INTEL_POLICIES_JSON="unused/macos-intel/policies.json"
export DOVE_OSX_INTEL_POLICIES_PLIST="macos-intel/org.mozilla.thunderbird.plist"
export DOVE_OSX_POLICIES_JSON="unused/macos/policies.json"
export DOVE_OSX_POLICIES_PLIST="macos/macos/org.mozilla.thunderbird.plist"

mkdir -vp /tmp/dove

# GNU/LINUX

# Copy license
cp "$DOVE_LICENSE" "$dove_linux_dir"/

# Copy README
cp "$DOVE_README" "$dove_linux_dir"/

# Remove lines containing [INTEL-OSX-ONLY], [NO-LINUX], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
grep -vE 'INTEL-OSX-ONLY|NO-LINUX|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "$DOVE_USER_PREF_CFG" > "$DOVE_LINUX_USER_PREF_CFG"
echo "Created $DOVE_LINUX_USER_PREF_CFG"

# Remove lines containing [ANDROID-ONLY], [INTEL-OSX-ONLY], [NO-LINUX], [NO-MAIL], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
grep -vE 'ANDROID-ONLY|INTEL-OSX-ONLY|NO-LINUX|NO-MAIL|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "$PHOENIX_UNIFIED_PREFS" > /tmp/dove/linux-temp1.js
echo "Created /tmp/dove/linux-temp1.js"

# Remove lines containing [ANDROID-ONLY], [INTEL-OSX-ONLY], [NO-LINUX], [NO-MAIL], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
grep -vE 'ANDROID-ONLY|INTEL-OSX-ONLY|NO-LINUX|NO-MAIL|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "$PHOENIX_EXTENDED_UNIFIED_PREFS" > /tmp/dove/linux-temp2.js
echo "Created /tmp/dove/linux-temp2.js"

# Remove lines containing [INTEL-OSX-ONLY], [NO-LINUX], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
grep -vE 'INTEL-OSX-ONLY|NO-LINUX|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "$DOVE_UNIFIED_PREFS" > /tmp/dove/linux-temp3.js
echo "Created /tmp/dove/linux-temp3.js"

cat /tmp/dove/linux-temp1.js /tmp/dove/linux-temp2.js /tmp/dove/linux-temp3.js > "$DOVE_LINUX_PREFS"

python3 build/convert.py "$DOVE_LINUX_PREFS" "$DOVE_LINUX_CFG"

# MACOS

# Copy license
cp "$DOVE_LICENSE" "$dove_osx_dir"/

# Copy README
cp "$DOVE_README" "$dove_osx_dir"/

# Remove lines containing [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-OSX], [NO-SILICON-OSX], and [WINDOWS-ONLY]
grep -vE 'INTEL-OSX-ONLY|LINUX-ONLY|NO-OSX|NO-SILICON-OSX|WINDOWS-ONLY' "$DOVE_BOOTSTRAP" > "$DOVE_OSX_BOOTSTRAP"
echo "Created $DOVE_OSX_BOOTSTRAP"

# Remove lines containing [ANDROID-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-MAIL], [NO-OSX], [NO-SILICON-OSX], and [WINDOWS-ONLY]
grep -vE 'ANDROID-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-MAIL|NO-OSX|NO-SILICON-OSX|WINDOWS-ONLY' "$PHOENIX_UNIFIED_PREFS" > /tmp/dove/osx-temp1.js
echo "Created /tmp/dove/osx-temp1.js"

# Remove lines containing [ANDROID-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-MAIL], [NO-OSX], [NO-SILICON-OSX], and [WINDOWS-ONLY]
grep -vE 'ANDROID-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-MAIL|NO-OSX|NO-SILICON-OSX|WINDOWS-ONLY' "$PHOENIX_EXTENDED_UNIFIED_PREFS" > /tmp/dove/osx-temp2.js
echo "Created /tmp/dove/osx-temp2.js"

# Remove lines containing [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-OSX], [NO-SILICON-OSX], and [WINDOWS-ONLY]
grep -vE 'INTEL-OSX-ONLY|LINUX-ONLY|NO-OSX|NO-SILICON-OSX|WINDOWS-ONLY' "$DOVE_UNIFIED_PREFS" > /tmp/dove/osx-temp3.js
echo "Created /tmp/dove/osx-temp3.js"

cat /tmp/dove/osx-temp1.js /tmp/dove/osx-temp2.js /tmp/dove/osx-temp3.js > "$DOVE_OSX_PREFS"

python3 build/convert.py "$DOVE_OSX_PREFS" /tmp/dove/dove-osx-tmp.cfg

# Add "user" prefs
cat /tmp/dove/dove-osx-tmp.cfg "$DOVE_USER_PREF_CFG" > "$DOVE_OSX_CFG"

# MACOS (INTEL)

# Copy license
cp "$DOVE_LICENSE" "$dove_osx_intel_dir"/

# Copy README
cp "$DOVE_README" "$dove_osx_intel_dir"/

# Remove lines containing [LINUX-ONLY], [NO-INTEL-OSX], [NO-OSX], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
grep -vE 'LINUX-ONLY|NO-INTEL-OSX|NO-OSX|SILICON-OSX-ONLY|WINDOWS-ONLY' "$DOVE_BOOTSTRAP" > "$DOVE_OSX_INTEL_BOOTSTRAP"
echo "Created $DOVE_OSX_INTEL_BOOTSTRAP"

# Remove lines containing [ANDROID-ONLY], [LINUX-ONLY], [NO-INTEL-OSX], [NO-MAIL], [NO-OSX], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
grep -vE 'ANDROID-ONLY|LINUX-ONLY|NO-INTEL-OSX|NO-MAIL|NO-OSX|SILICON-OSX-ONLY|WINDOWS-ONLY' "$PHOENIX_UNIFIED_PREFS" > /tmp/dove/osx-intel-temp1.js
echo "Created /tmp/dove/osx-intel-temp1.js"

# Remove lines containing [ANDROID-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-MAIL], [NO-OSX], [NO-SILICON-OSX], and [WINDOWS-ONLY]
grep -vE 'ANDROID-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-MAIL|NO-OSX|NO-SILICON-OSX|WINDOWS-ONLY' "$PHOENIX_EXTENDED_UNIFIED_PREFS" > /tmp/dove/osx-intel-temp2.js
echo "Created /tmp/dove/osx-intel-temp2.js"

# Remove lines containing [LINUX-ONLY], [NO-INTEL-OSX], [NO-OSX], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
grep -vE 'LINUX-ONLY|NO-INTEL-OSX|NO-OSX|SILICON-OSX-ONLY|WINDOWS-ONLY' "$DOVE_UNIFIED_PREFS" > /tmp/dove/osx-intel-temp3.js
echo "Created /tmp/dove/osx-intel-temp3.js"

cat /tmp/dove/osx-intel-temp1.js /tmp/dove/osx-intel-temp2.js /tmp/dove/osx-intel-temp3.js > "$DOVE_OSX_INTEL_PREFS"

python3 build/convert.py "$DOVE_OSX_INTEL_PREFS" /tmp/dove/dove-osx-intel-tmp.cfg

# Add "user" prefs
cat /tmp/dove/dove-osx-tmp.cfg "$DOVE_USER_PREF_CFG" > "$DOVE_OSX_INTEL_CFG"

# WINDOWS

# Copy license
cp "$DOVE_LICENSE" "$dove_windows_dir"/

# Copy README
cp "$DOVE_README" "$dove_windows_dir"/

# Remove lines containing [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-WINDOWS], [OSX-ONLY], and [SILICON-OSX-ONLY]
grep -vE 'INTEL-OSX-ONLY|LINUX-ONLY|NO-WINDOWS|OSX-ONLY|SILICON-OSX-ONLY' "$DOVE_BOOTSTRAP" > "$DOVE_WINDOWS_BOOTSTRAP"
echo "Created $DOVE_WINDOWS_BOOTSTRAP"

# Remove lines containing [ANDROID-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-MAIL], [NO-WINDOWS], [OSX-ONLY], and [SILICON-OSX-ONLY]
grep -vE 'ANDROID-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-MAIL|NO-WINDOWS|OSX-ONLY|SILICON-OSX-ONLY' "$PHOENIX_UNIFIED_PREFS" > /tmp/dove/windows-temp1.js
echo "Created /tmp/dove/windows-temp1.js"

# Remove lines containing [ANDROID-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-MAIL], [NO-WINDOWS], [OSX-ONLY], and [SILICON-OSX-ONLY]
grep -vE 'ANDROID-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-MAIL|NO-WINDOWS|OSX-ONLY|SILICON-OSX-ONLY' "$PHOENIX_EXTENDED_UNIFIED_PREFS" > /tmp/dove/windows-temp2.js
echo "Created /tmp/dove/windows-temp2.js"

# Remove lines containing [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-WINDOWS], [OSX-ONLY], and [SILICON-OSX-ONLY]
grep -vE 'INTEL-OSX-ONLY|LINUX-ONLY|NO-WINDOWS|OSX-ONLY|SILICON-OSX-ONLY' "$DOVE_UNIFIED_PREFS" > /tmp/dove/windows-temp3.js
echo "Created /tmp/dove/windows-temp3.js"

cat /tmp/dove/windows-temp1.js /tmp/dove/windows-temp2.js /tmp/dove/windows-temp3.js > "$DOVE_WINDOWS_PREFS"

python3 build/convert.py "$DOVE_WINDOWS_PREFS" /tmp/dove/dove-windows-tmp.cfg

# Add "user" prefs
cat /tmp/dove/dove-windows-tmp.cfg "$DOVE_USER_PREF_CFG" > "$DOVE_WINDOWS_CFG"

# POLICIES

jq -s '.[0] * .[1]' "$PHOENIX_UNIFIED_POLICIES" "$PHOENIX_BLOCKLIST_POLICIES" > /tmp/dove/temp1.json

jq -s '.[0] * .[1]' /tmp/dove/temp1.json "$PHOENIX_COOKIES_POLICIES" > /tmp/dove/temp2.json

jq -s '.[0] * .[1]' /tmp/dove/temp2.json "$DOVE_UNIFIED_POLICIES" > "$DOVE_POLICIES"

jq -s '.[0] * .[1]' "$DOVE_POLICIES" "$PHOENIX_UNIFIED_LINUX_POLICIES" > /tmp/dove/temp3.json

jq -s '.[0] * .[1]' /tmp/dove/temp3.json "$DOVE_UNIFIED_LINUX_POLICIES" > "$DOVE_LINUX_POLICIES"

jq -s '.[0] * .[1]' "$DOVE_POLICIES" "$PHOENIX_UNIFIED_OSX_POLICIES" > /tmp/dove/temp4.json

jq -s '.[0] * .[1]' /tmp/dove/temp4.json "$PHOENIX_UNIFIED_OSX_SILICON_POLICIES" > /tmp/dove/temp5.json

jq -s '.[0] * .[1]' /tmp/dove/temp5.json "$DOVE_UNIFIED_OSX_SILICON_POLICIES" > "$DOVE_OSX_POLICIES_JSON"

jq -s '.[0] * .[1]' /tmp/dove/temp4.json "$PHOENIX_UNIFIED_OSX_INTEL_POLICIES" > /tmp/dove/temp6.json

jq -s '.[0] * .[1]' /tmp/dove/temp6.json "$DOVE_UNIFIED_OSX_INTEL_POLICIES" > "$DOVE_OSX_INTEL_POLICIES_JSON"

jq -s '.[0] * .[1]' "$DOVE_POLICIES" "$PHOENIX_UNIFIED_WINDOWS_POLICIES" > /tmp/dove/temp7.json

jq -s '.[0] * .[1]' /tmp/dove/temp7.json "$DOVE_UNIFIED_WINDOWS_POLICIES" > "$DOVE_WINDOWS_POLICIES"

rm -rf /tmp/dove

python3 build/convert_json_to_plist.py "$DOVE_OSX_INTEL_POLICIES_JSON" "$DOVE_OSX_INTEL_POLICIES_PLIST" 
python3 build/convert_json_to_plist.py "$DOVE_OSX_POLICIES_JSON" "$DOVE_OSX_POLICIES_PLIST"
