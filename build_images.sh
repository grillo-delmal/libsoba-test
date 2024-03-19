#!/usr/bin/bash

podman build \
    -f ./podman/Containerfile \
    -t localhost/libsoba_build:latest \
    .
