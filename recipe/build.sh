#!/bin/bash

set -x

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

if [[ "${target_platform}" == "osx-64" ]] && [[ "${py}" -gte 38 ]]; then
    export CFLAGS="${CFLAGS} -fno-lto"
    export CXXFLAGS="${CXXFLAGS} -fno-lto"    
fi

$PYTHON -m pip install --no-deps --ignore-installed -v .
