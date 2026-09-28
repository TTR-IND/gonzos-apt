#!/bin/sh
# Install GonzOS packages on the ISO target or an existing Devuan system.
set -eu

archive_url=${GONZOS_APT_URL:-https://ttr-ind.github.io/gonzos-apt}
keyring=/usr/share/keyrings/gonzos-archive-keyring.gpg
source_file=/etc/apt/sources.list.d/gonzos.sources

if [ "$(id -u)" -ne 0 ]; then
    exec sudo "$0" "$@"
fi

apt-get update
apt-get install -y ca-certificates curl

curl -fsSL "$archive_url/gonzos-archive-keyring.gpg" -o "$keyring"

cat >"$source_file" <<EOF
Types: deb
URIs: $archive_url/
Suites: excalibur
Components: main
Architectures: amd64
Signed-By: $keyring
EOF

apt-get update
apt-get install -y detritusd gonzocache numate-settings gonzo-system-monitor numate
