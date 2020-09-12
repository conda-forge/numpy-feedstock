#!/bin/bash

if [[ -f $BUILD_PREFIX/bin/python ]]; then
  $BUILD_PREFIX/bin/python -m crossenv $PREFIX/bin/python \
      --sysroot $CONDA_BUILD_SYSROOT \
      --without-pip $BUILD_PREFIX/venv \
      --sysconfigdata-file $PREFIX/lib/python$PY_VER/${_CONDA_PYTHON_SYSCONFIGDATA_NAME}.py
  cp $BUILD_PREFIX/venv/cross/bin/python $PREFIX/bin/python
  rm -rf $BUILD_PREFIX/venv/cross
fi

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
