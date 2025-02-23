#!/bin/bash

jq -s '.[0] * .[1]' "$phoenix_dir/build/policies/policies-core.json" "$phoenix_dir/build/policies/blocklist-spec.json" > build/policies/temp1.json

jq -s '.[0] * .[1]' build/policies/temp1.json "$phoenix_dir/build/policies/cookies-spec.json" > build/policies/temp2.json

rm -f build/policies/temp1.json

jq -s '.[0] * .[1]' build/policies/temp2.json build/policies/policies-dove.json > policies.json

rm -f build/policies/temp2.json

python3 build/convert_json_to_plist.py policies.json macos/org.mozilla.thunderbird.plist
