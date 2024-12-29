#!/usr/bin/env bash

# Make presentation.sh executable
chmod +x presentation.sh

# Run the container, copy presentation.sh, and execute it
set -x
podman run --rm -it \
  -v "$PWD/presentation.sh:/presentation.sh:Z" \
  quay.io/fedora/python-312 \
  /bin/bash -c "/presentation.sh"
