#!/bin/bash

set -x

# numpy distutils don't use the env variables.
ln -s $RANLIB $BUILD_PREFIX/bin/ranlib
ln -s $AR $BUILD_PREFIX/bin/ar

cat > site.cfg <<EOF
[DEFAULT]
libraries = blas,cblas,lapack
library_dirs = $PREFIX/lib
include_dirs = $PREFIX/include
EOF

# Internal compiler error with gcc 7
if [[ "${target_platform}" == "linux-aarch64" ]]; then
    export CC="$BUILD_PREFIX/bin/clang"
    export CXX="$BUILD_PREFIX/bin/clang++"
fi

$PYTHON -m pip install --no-deps --ignore-installed -v .
