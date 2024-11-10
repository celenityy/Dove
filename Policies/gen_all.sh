#!/bin/bash

# Replace {pdir} with the directory where Phoenix is located
jq -s '.[0] * .[1]' base/base-policies.json {pdir}/policies/Blocklist/blocklist.json > Linux/Policies/temp.json

jq -s '.[0] * .[1]' Linux/Policies/temp.json {pdir}/policies/Blocklist/cookies.json > Linux/Policies/policies.json

rm -f /Linux/Policies/temp.json

jq -s '.[0] * .[1]' Linux/Policies/policies.json policies-specific.json > policies.json

jq -s '.[0] * .[1]' policies.json Personal/policies-specific.json > Personal/policies.json

# Replace {fedir} with the directory where Dove-Policies-Fedora is located, otherwise you can comment this out
cp Linux/Policies/policies.json {fedir}/policies.json

# Replace {dedir} with the directory where Dove-Policies-Debian is located, otherwise you can comment this out
cp Linux/Policies/policies.json {dedir}/dove-policies/policies.json