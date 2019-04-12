#!/bin/bash

MACHINE=`uname -m`
if [[ "${MACHINE}" == "x86_64" ]]; then
    mv numpy/distutils/environment.py numpy/distutils/fcompiler/environment.py
fi
# Let cython re-genatare this file.
rm -f numpy/random/mtrand/mtrand.c
rm -f PKG-INFO

cat > site.cfg <<EOF
[DEFAULT]
libraries = blas,cblas,lapack
library_dirs = $PREFIX/lib
include_dirs = $PREFIX/include
EOF

$PYTHON -m pip install --no-deps --ignore-installed -v .
