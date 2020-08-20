#!/bin/bash

set -x

# numpy distutils don't use the env variables.
if [[ ! -f $BUILD_PREFIX/bin/ranlib ]]; then
    ln -s $RANLIB $BUILD_PREFIX/bin/ranlib
    ln -s $AR $BUILD_PREFIX/bin/ar
fi

cat > site.cfg <<EOF
[DEFAULT]
libraries = blas,cblas,lapack
library_dirs = $PREFIX/lib
include_dirs = $PREFIX/include
EOF

$PYTHON -m pip install --no-deps --ignore-installed -v .
