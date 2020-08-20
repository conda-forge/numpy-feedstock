#!/bin/bash

set -x

# numpy distutils don't use the env variables.
if [[ ! -f $BUILD_PREFIX/bin/ranlib ]]; then
    ln -s $RANLIB $BUILD_PREFIX/bin/ranlib
    ln -s $AR $BUILD_PREFIX/bin/ar
fi

cat > site.cfg <<EOF
[DEFAULT]
library_dirs = $PREFIX/lib
include_dirs = $PREFIX/include

[lapack]
libraries = blas,cblas,lapack

[blas]
libraries = blas,cblas
EOF

export NPY_LAPACK_ORDER=lapack
export NPY_BLAS_ORDER=blas

# Internal compiler error with gcc 7
if [[ "${target_platform}" == "linux-aarch64" ]]; then
    export CC="$BUILD_PREFIX/bin/clang"
    export CXX="$BUILD_PREFIX/bin/clang++"
fi

$PYTHON -m pip install --no-deps --ignore-installed -v .
