#!/bin/bash

# Replace ~/Projects/Phoenix with the directory where Phoenix is located
jq -s '.[0] * .[1]' build/policies/policies-spec.json ~/Projects/Phoenix/build/policies/blocklist-spec.json > build/policies/temp.json

jq -s '.[0] * .[1]' build/policies/temp.json ~/Projects/Phoenix/build/policies/cookies-spec.json > policies.json

rm -f build/policies/temp.json
