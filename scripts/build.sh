#!/usr/bin/bash

set -ex

source /opt/scripts/semver.sh

# Clean out folder
find /opt/out/ -mindepth 1 -maxdepth 1 -exec rm -r -- {} +

# Setup build srcs
cd /opt
mkdir -p src
rsync -azh /opt/orig/libsoba/ /opt/src/libsoba/
rsync -azh /opt/orig/i2d-cairo/ /opt/src/i2d-cairo/

# Apply patches
if [ ! -z "./patches" ]; then
    pushd patches
    if [ ! -z "$(ls -A */ 2> /dev/null)" ]; then
        for d in */ ; do
            for p in ${d}*.patch; do
                echo "patch /opt/patches/$p"
                (cd /opt/src/${d}; patch -p1 < /opt/patches/$p)
            done
        done
    fi
    popd
fi

dub add-local /opt/src/i2d-cairo/        "$(semver /opt/src/i2d-cairo/)"

# Build

pushd src
pushd libsoba
dub build \
    --config=gl \

popd
popd


# Get results

rsync -azh /opt/src/libsoba/out/ /opt/out/libsoba/
