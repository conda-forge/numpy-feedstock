#!/bin/bash

set -x

cat > site.cfg <<EOF
[DEFAULT]
libraries = blas,cblas,lapack
library_dirs = $PREFIX/lib
include_dirs = $PREFIX/include
EOF

# Internal compiler error with gcc 7 and -O3
if [[ "${target_platform}" == "linux-aarch64" ]]; then
    export CFLAGS="$CFLAGS -fno-tree-vectorize -O0"
    export CPPFLAGS="$CPPFLAGS -O0"
fi

$PYTHON -m pip install --no-deps --ignore-installed -v .
