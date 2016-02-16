#!/usr/bin/env bash

tmpdir=$(dirname $(mktemp -u))

cd $tmpdir
curl -Ls "$LIBDOGMA_URL" | tar xJ
cd libdogma-1.2.0
./configure --enable-debug
make
sudo make install
