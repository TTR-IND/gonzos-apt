# GonzOS APT archive

This repository is the future signed APT archive for GonzOS packages. It is
separate from the application source repositories: users will add this archive
to APT, not the individual GitHub source repositories.

The intended published layout is:

```
dists/excalibur/InRelease
dists/excalibur/main/binary-amd64/Packages.xz
pool/main/
```

`conf/distributions` is configured for the `excalibur` suite and the `main`
component. The archive must be signed before it is published.

## First setup

1. Create the matching GitHub repository, `TTR-IND/gonzos-apt`.
2. Add this local repository as its `origin` and push `main`.
3. Create a dedicated OpenPGP archive-signing key; keep its private half out
   of Git and export only the public key for users and the ISO.
4. Add the private signing key to GitHub Actions secrets when the publish
   workflow is configured.

Do not put application source trees or private keys in this repository.

## Local publishing

On the archive host, install `reprepro`, configure the signing key as GPG's
default signing key, then add a built source-package upload:

```sh
./scripts/include-package.sh /path/to/package_version_amd64.changes
```

The command creates or refreshes `dists/` and `pool/`. Those are the static
files GitHub Pages or a future GonzOS package server must serve over HTTPS.
