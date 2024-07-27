#!/usr/bin/bash

set -ex

source /opt/scripts/semver.sh

# Clean out folder
find /opt/out/ -mindepth 1 -maxdepth 1 -exec rm -r -- {} +

# Setup build srcs
cd /opt
mkdir -p src

rsync -azh /opt/orig/i2d-harfbuzz/ /opt/src/i2d-harfbuzz/
rsync -azh /opt/orig/i2d-cairo/ /opt/src/i2d-cairo/
rsync -azh /opt/orig/app3/ /opt/src/app3/


# Apply patches
if [ ! -z "./patches" ]; then
    pushd patches
    if [ ! -z "$(ls -A */ 2> /dev/null)" ]; then
        for d in */ ; do
            if [ ! -z "$(ls -A $d 2> /dev/null)" ]; then
                if [ ! -z "$(ls -A /opt/src/${d} 2> /dev/null)" ]; then
                    for p in ${d}*.patch; do
                        echo "patch /opt/patches/$p"
                        (cd /opt/src/${d}; patch -p1 < /opt/patches/$p)
                    done
                fi
            fi
        done
    fi
    popd
fi

dub add-local /opt/src/i2d-harfbuzz/        "$(semver /opt/src/i2d-harfbuzz/)"
dub add-local /opt/src/i2d-cairo/      "$(semver /opt/src/i2d-cairo/)"

# Build
pushd src
pushd app3

export DFLAGS='-g --d-debug'
export DC='/usr/bin/ldc2'
dub build
./app

popd
popd

# Get results

rsync -azh /opt/src/app3/ /opt/out/app3