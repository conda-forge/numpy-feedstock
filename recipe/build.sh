#!/bin/bash

mv numpy/distutils/environment.py numpy/distutils/fcompiler/environment.py

# Let cython re-generate this file.
rm -f numpy/random/mtrand/mtrand.c
rm -f PKG-INFO

cat > site.cfg <<EOF
[DEFAULT]
library_dirs = $PREFIX/lib
include_dirs = $PREFIX/include
EOF

$PYTHON -m pip install --no-deps --ignore-installed -v .
