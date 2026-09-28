#!/bin/sh
# Include one signed build upload in the local GonzOS Excalibur archive.
set -eu

if [ "$#" -ne 1 ]; then
    echo "usage: $0 /path/to/package_version_arch.changes" >&2
    exit 64
fi

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
changes_file=$1

if ! command -v reprepro >/dev/null 2>&1; then
    echo "reprepro is required; install it on the archive builder first" >&2
    exit 69
fi

if [ ! -f "$changes_file" ]; then
    echo "changes file not found: $changes_file" >&2
    exit 66
fi

exec reprepro -b "$repo_dir" include excalibur "$changes_file"
