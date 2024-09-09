#!/usr/bin/bash

set -ex

source /opt/scripts/semver.sh

# Clean out folder
find /opt/out/ -mindepth 1 -maxdepth 1 -exec rm -r -- {} +

# Setup build srcs
cd /opt
mkdir -p src

rsync -azh /opt/orig/tests/ /opt/src/tests/

rsync -azh /opt/orig/libsoba/ /opt/src/libsoba/
rsync -azh /opt/orig/bindbc-gles/ /opt/src/bindbc-gles/
rsync -azh /opt/orig/i2d-blend2d/ /opt/src/i2d-blend2d/
rsync -azh /opt/orig/i2d-cairo/ /opt/src/i2d-cairo/
rsync -azh /opt/orig/i2d-harfbuzz/ /opt/src/i2d-harfbuzz/
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
dub add-local /opt/src/bindbc-gles/    "$(semver /opt/src/bindbc-gles/)"
dub add-local /opt/src/i2d-blend2d/    "$(semver /opt/src/i2d-blend2d/)"
dub add-local /opt/src/i2d-cairo/      "$(semver /opt/src/i2d-cairo/)"
dub add-local /opt/src/i2d-harfbuzz/   "$(semver /opt/src/i2d-harfbuzz/)"
dub add-local /opt/src/inmath/         "$(semver /opt/src/inmath/)"
dub add-local /opt/src/numem/          "$(semver /opt/src/numem/)"

# Build
export DFLAGS='-g --d-debug'
export DC='/usr/bin/ldc2'

pushd src
pushd tests
    if [ ! -z "$(ls -A */ 2> /dev/null)" ]; then
        for d in * ; do
            if [ -d "$d" ]; then
                pushd $d
                echo "running $d"

                dub build || true
                ./$d || true
                popd
            fi
        done
    fi
popd
popd

pushd src
pushd libsoba

dub build || true
dub build --config="demo" || true

popd
popd

# Get results

rsync -azh /opt/src/tests/ /opt/out/tests
rsync -azh /opt/src/libsoba/ /opt/out/libsoba
