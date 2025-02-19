#!/bin/bash

# Replace ~/Projects/Phoenix with the directory where Phoenix is located

jq -s '.[0] * .[1]' ~/Projects/Phoenix/build/policies/policies-core.json ~/Projects/Phoenix/build/policies/blocklist-spec.json > build/policies/temp1.json

jq -s '.[0] * .[1]' build/policies/temp1.json ~/Projects/Phoenix/build/policies/cookies-spec.json > build/policies/temp2.json

rm -f build/policies/temp1.json

jq -s '.[0] * .[1]' build/policies/temp2.json build/policies/policies-dove.json > policies.json

rm -f build/policies/temp2.json

python3 build/convert_json_to_plist.py policies.json macos/org.mozilla.thunderbird.plist
