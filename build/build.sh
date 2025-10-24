#!/usr/bin/env bash

set -euo pipefail

source build/env.sh

# Update "mail.dove.version"
$SED -i "s/pref(\"mail.dove.version\", \".*\", locked);/pref(\"mail.dove.version\", \"$dove_version\", locked);/" build/dove-unified.js

# Update "app.support.vendor"
$SED -i "s/pref(\"app.support.vendor\", \".*\", locked);/pref(\"app.support.vendor\", \"Dove: $dove_version\", locked);/" build/dove-unified.js

# Update "distribution.about"
$SED -i "s/pref(\"distribution.about\", \".*\", locked);/pref(\"distribution.about\", \"Dove for Mozilla Thunderbird - $dove_version 💜\", locked);/" build/dove-unified.js

mkdir -vp external/uBlock
pushd external/uBlock
rm -vrf *

if [[ -n "${uBlock-}" ]]; then 
    echo "Copying uBlock Origin from ${uBlock}" 
    cp "${uBlock}" uBlock.xpi
else
    echo "Downloading uBlock Origin $ubo_version..."
    curl --doh-cert-status --no-insecure --no-proxy-insecure --no-sessionid --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --proto -all,https --proto-default https --proto-redir -all,https --show-error -o uBlock.xpi -sSL "https://github.com/celenityy/uBlock/releases/download/$ubo_version/uBlock0_$ubo_version.thunderbird.xpi"
fi

if [[ -n "${uBlockLicense-}" ]]; then
    echo "Copying uBlock Origin license from ${uBlockLicense}" 
    cp "${uBlockLicense}" LICENSE.txt
else
    echo "Downloading uBlock Origin's LICENSE..."
    curl --doh-cert-status --no-insecure --no-proxy-insecure --no-sessionid --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --proto -all,https --proto-default https --proto-redir -all,https --show-error -O -sSL https://raw.githubusercontent.com/gorhill/uBlock/refs/heads/master/LICENSE.txt
fi

popd

mkdir -vp external/autoconfig
pushd external/autoconfig
rm -vrf *

build_autoconfig() {
    cp "${autoconfig_dir}/LICENSE" ./LICENSE.txt
    mkdir v1.1
    python ${autoconfig_dir}/tools/convert.py -d v1.1 -a ${autoconfig_dir}/ispdb/*.xml
}
if [[ -n "${autoconfig_dir-}" ]]; then
    echo "Using Thunderbird's autoconfiguration database (ISPDB) repository from ${autoconfig_dir}" 
    build_autoconfig
else 
    echo "Downloading Thunderbird's autoconfiguration database (ISPDB) repository"
    curl --doh-cert-status --no-insecure --no-proxy-insecure --no-sessionid --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --proto -all,https --proto-default https --proto-redir -all,https --show-error -sSL https://github.com/thunderbird/autoconfig/archive/refs/heads/prod.tar.gz | tar zxvf -
    autoconfig_dir=./autoconfig-prod
    build_autoconfig
    rm -r autoconfig-prod
fi

popd

cd "$dove_dir"

./build/fly.sh && ./build/gen_archive.sh
