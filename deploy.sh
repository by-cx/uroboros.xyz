#!/bin/sh

hugo && \
rsync -av --delete public/ my:/srv/uroboros.xyz/
