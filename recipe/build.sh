#!/bin/bash

if [ -z "$BLAS_VARIANT" ]; then
    echo "Please set the blas variant through the BLAS_VARIANT env var"
    exit 1

# ======================================
elif [ "$BLAS_VARIANT" == "openblas" ] ; then

    cat > site.cfg <<EOF
[DEFAULT]
library_dirs = $PREFIX/lib
include_dirs = $PREFIX/include

[atlas]
atlas_libs = openblas
libraries = openblas

[openblas]
libraries = openblas
library_dirs = $PREFIX/lib
include_dirs = $PREFIX/include

EOF

# ======================================
elif [ "$BLAS_VARIANT" == "noblas" ] ; then

    cat > site.cfg <<EOF

[openblas]
libraries =

[DEFAULT]
libraries =
library_dirs =
include_dirs =

EOF

    export BLAS=None LAPACK=None ATLAS=None 

fi

$PYTHON setup.py config build install

