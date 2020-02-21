#!/usr/bin/env bash
set -euxo pipefail

pandoc "README.md" \
       --from=markdown+emoji \
       --to=revealjs \
       --incremental \
       --standalone \
       --output=index.html \
       --variable=revealjs-url:assets/reveal.js-3.9.2 \
       --variable=theme:beige \
       --variable=mouseWheel:false \
       --variable=width:1920 \
       --variable=height:1080 \
