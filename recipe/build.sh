#!/bin/bash

set -ex

cat > site.cfg <<EOF
[DEFAULT]
libraries = blas,cblas,lapack
library_dirs = $PREFIX/lib
include_dirs = $PREFIX/include
EOF

# CFLAGS=-ftree-vectorize -fPIC -fstack-protector-strong -fno-plt -O3 -pipe -I$PREFIX/include -fdebug-prefix-map=${SRC_DIR}=/usr/local/src/conda/${PKG_NAME}-${PKG_VERSION} -fdebug-prefix-map=${PREFIX}=/usr/local/src/conda-prefix
export CFLAGS=-I$PREFIX/include -fdebug-prefix-map=${SRC_DIR}=/usr/local/src/conda/${PKG_NAME}-${PKG_VERSION} -fdebug-prefix-map=${PREFIX}=/usr/local/src/conda-prefix

$PYTHON -m pip install --no-deps --ignore-installed -v .

set +ex
