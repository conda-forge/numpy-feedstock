#!/bin/bash

cp $PREFIX/lib/python$PY_VER/${_CONDA_PYTHON_SYSCONFIGDATA_NAME}.py .
rm -rf $PREFIX/lib/python$PY_VER/_sysconfigdata*
cp ${_CONDA_PYTHON_SYSCONFIGDATA_NAME}.py $PREFIX/lib/python$PY_VER/
$BUILD_PREFIX/bin/python -m crossenv $PREFIX/bin/python --sysroot $CONDA_BUILD_SYSROOT $BUILD_PREFIX/venv
cp venv/cross/bin/python $PREFIX/bin/python
rm -rf venv/cross

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
libraries = lapack,blas

[blas]
libraries = cblas,blas
EOF

export NPY_LAPACK_ORDER=lapack
export NPY_BLAS_ORDER=blas

$PYTHON -m pip install --no-deps --ignore-installed -v .
