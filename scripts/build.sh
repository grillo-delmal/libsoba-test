#!/usr/bin/bash

set -ex

source /opt/scripts/semver.sh

# Clean out folder
find /opt/out/ -mindepth 1 -maxdepth 1 -exec rm -r -- {} +

# Setup build srcs
cd /opt
mkdir -p src

rsync -azh /opt/orig/app/ /opt/src/app/
rsync -azh /opt/orig/app2/ /opt/src/app2/

rsync -azh /opt/orig/libsoba/ /opt/src/libsoba/
rsync -azh /opt/orig/i2d-cairo/ /opt/src/i2d-cairo/
rsync -azh /opt/orig/inmath/ /opt/src/inmath/
rsync -azh /opt/orig/numem/ /opt/src/numem/


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

dub add-local /opt/src/libsoba/        "$(semver /opt/src/libsoba/)"
dub add-local /opt/src/i2d-cairo/      "$(semver /opt/src/i2d-cairo/)"
dub add-local /opt/src/inmath/         "$(semver /opt/src/inmath/)"
dub add-local /opt/src/numem/          "$(semver /opt/src/numem/)"

# Build
pushd src
pushd app

export DFLAGS='-g --d-debug'
export DC='/usr/bin/ldc2'

dub build
./app

popd
popd

pushd src
pushd libsoba

export DFLAGS='-g --d-debug'
export DC='/usr/bin/ldc2'

dub build

popd
popd

pushd src
pushd app2

export DFLAGS='-g --d-debug'
export DC='/usr/bin/ldc2'

#dub build

popd
popd


# Get results

rsync -azh /opt/src/app/ /opt/out/app
rsync -azh /opt/src/app2/ /opt/out/app2
rsync -azh /opt/src/libsoba/ /opt/out/libsoba
