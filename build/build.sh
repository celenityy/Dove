#!/usr/bin/env bash

set -eu

source build/env.sh

mkdir -vp external/autoconfig
pushd external/autoconfig
rm -vrf *

# Set-up pip venv
if [[ -v USING_NIX_FLAKE ]]; then
    python -m venv "$PIP_ENV"
    source "$PIP_ENV/bin/activate"
    pip install --upgrade pip
    pip install lxml
fi

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
