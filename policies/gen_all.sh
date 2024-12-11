#!/bin/bash

# Replace ~/Projects/Phoenix with the directory where Phoenix is located
jq -s '.[0] * .[1]' policies/Policies/base-policies.json ~/Projects/Phoenix/policies/Blocklist/blocklist.json > policies/Policies/temp.json

jq -s '.[0] * .[1]' policies/Policies/temp.json ~/Projects/Phoenix/policies/Blocklist/cookies.json > policies/Policies/policies.json

rm -f policies/Policies/temp.json

# Replace ~/Projects/Dove-Policies-Debian with the directory where Dove-Policies-Debian is located, otherwise you can comment this out
cp policies/Policies/policies.json ~/Projects/Dove-Policies-Debian/dove-policies/policies.json