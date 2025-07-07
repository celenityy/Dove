#!/usr/bin/env bash

source build/env.sh

if [[ "$OSTYPE" == "darwin"* ]]; then
    # Update "mail.dove.version"
    sed -i '' "s/pref(\"mail.dove.version\", \".*\", locked);/pref(\"mail.dove.version\", \"$dove_version\", locked);/" build/dove-unified.js
    # Update "distribution.about"
    sed -i '' "s/pref(\"distribution.about\", \".*\", locked);/pref(\"distribution.about\", \"Dove for Mozilla Thunderbird - $dove_version 💜\", locked);/" build/dove-unified.js
else
    # Update "mail.dove.version"
    sed -i "s/pref(\"mail.dove.version\", \".*\", locked);/pref(\"mail.dove.version\", \"$dove_version\", locked);/" build/dove-unified.js
    # Update "distribution.about"
    sed -i "s/pref(\"distribution.about\", \".*\", locked);/pref(\"distribution.about\", \"Dove for Mozilla Thunderbird - $dove_version 💜\", locked);/" build/dove-unified.js
fi

mkdir -vp /tmp/dove

cd /tmp/dove

echo "Downloading uBlock Origin $ubo_version..."
curl --doh-cert-status --no-insecure --no-proxy-insecure --no-sessionid --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --proto -all,https --proto-default https --proto-redir -all,https --show-error -O -sSL "https://github.com/gorhill/uBlock/releases/download/$ubo_version/uBlock0_$ubo_version.thunderbird.xpi"

mv "uBlock0_$ubo_version.thunderbird.xpi" uBlock.xpi

cd "$dove_dir"

./build/fly.sh && ./build/gen_archive.sh
