#!/usr/bin/env bash

source build/env.sh

# Update "mail.dove.version"
$SED -i "s/pref(\"mail.dove.version\", \".*\", locked);/pref(\"mail.dove.version\", \"$dove_version\", locked);/" build/dove-unified.js

# Update "app.support.vendor"
$SED -i "s/pref(\"app.support.vendor\", \".*\", locked);/pref(\"app.support.vendor\", \"Dove: $dove_version\", locked);/" build/dove-unified.js

# Update "distribution.about"
$SED -i "s/pref(\"distribution.about\", \".*\", locked);/pref(\"distribution.about\", \"Dove for Mozilla Thunderbird - $dove_version 💜\", locked);/" build/dove-unified.js

mkdir -vp external/uBlock
pushd "external/uBlock"
rm -vrf *

echo "Downloading uBlock Origin $ubo_version..."
curl --doh-cert-status --no-insecure --no-proxy-insecure --no-sessionid --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --proto -all,https --proto-default https --proto-redir -all,https --show-error -O -sSL "https://github.com/gorhill/uBlock/releases/download/$ubo_version/uBlock0_$ubo_version.thunderbird.xpi"

mv -vf "uBlock0_$ubo_version.thunderbird.xpi" uBlock.xpi

echo "Downloading uBlock Origin's LICENSE..."
curl --doh-cert-status --no-insecure --no-proxy-insecure --no-sessionid --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --proto -all,https --proto-default https --proto-redir -all,https --show-error -O -sSL https://raw.githubusercontent.com/gorhill/uBlock/refs/heads/master/LICENSE.txt

popd

pushd "external/autoconfig"
rm -vrf *
echo "Downloading Thunderbird's autoconfiguration database (ISPDB) LICENSE..."
curl --doh-cert-status --no-insecure --no-proxy-insecure --no-sessionid --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --proto -all,https --proto-default https --proto-redir -all,https --show-error -O -sSL https://raw.githubusercontent.com/thunderbird/autoconfig/refs/heads/master/LICENSE
mv -vf LICENSE LICENSE.txt
popd

mkdir -vp external/autoconfig/v1.1
pushd "external/autoconfig/v1.1"
echo "Downloading Thunderbird's latest autoconfiguration files..."
wget -r -np -nH --cut-dirs=3 -R index.html -e robots=off https://autoconfig.thunderbird.net/v1.1/
rm -vf index.html*
popd

cd "$dove_dir"

./build/fly.sh && ./build/gen_archive.sh
