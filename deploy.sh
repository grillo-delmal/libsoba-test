#!/usr/bin/bash

set -e

mkdir -p $(pwd)/build_out
mkdir -p $(pwd)/patches

if [ "$EUID" -ne 0 ]; then
    ./build_images.sh
    podman unshare chown $UID:$UID -R $(pwd)/build_out
fi

podman run -ti --rm \
    -v $(pwd)/build_out:/opt/out/:Z \
    -v $(pwd)/patches:/opt/patches/:ro,Z \
    -v $(pwd)/scripts:/opt/scripts/:ro,Z \
    -v $(pwd)/.git:/opt/.git/:ro,Z \
    -v $(pwd)/src/tests:/opt/orig/tests/:ro,Z \
    -v $(pwd)/src/libsoba:/opt/orig/libsoba/:ro,Z \
    -v $(pwd)/src/bindbc-gles:/opt/orig/bindbc-gles/:ro,Z \
    -v $(pwd)/src/i2d-blend2d:/opt/orig/i2d-blend2d/:ro,Z \
    -v $(pwd)/src/i2d-cairo:/opt/orig/i2d-cairo/:ro,Z \
    -v $(pwd)/src/i2d-harfbuzz:/opt/orig/i2d-harfbuzz/:ro,Z \
    -v $(pwd)/src/inmath:/opt/orig/inmath/:ro,Z \
    -v $(pwd)/src/numem:/opt/orig/numem/:ro,Z \
    libsoba_build:latest \
    /opt/scripts/build.sh

if [ "$EUID" -ne 0 ]; then
    podman unshare chown 0:0 -R $(pwd)/build_out
fi
