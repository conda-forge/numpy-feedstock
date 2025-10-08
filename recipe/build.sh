#!/bin/bash
set -ex

# necessary for cross-compilation to point to the right env
export PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig

mkdir builddir

if [[ $target_platform == "osx-arm64" ]]; then
    # currently cannot properly detect long double format
    # on osx-arm64 when cross-compiling, see
    # https://github.com/numpy/numpy/pull/24414
    sed -i.bak "s@\[properties\]@[properties]\nlongdouble_format = 'IEEE_DOUBLE_LE'@g" ${CONDA_PREFIX}/meson_cross_file.txt
fi

# meson-python already sets up a -Dbuildtype=release argument to meson, so
# we need to strip --buildtype out of MESON_ARGS or fail due to redundancy
MESON_ARGS_REDUCED="$(echo $MESON_ARGS | sed 's/--buildtype release //g')"

# -wnx flags mean: --wheel --no-isolation --skip-dependency-check
$PYTHON -m build -w -n -x \
    -Cbuilddir=builddir \
    -Csetup-args=-Dblas=blas \
    -Csetup-args=-Dlapack=lapack \
    -Csetup-args=${MESON_ARGS_REDUCED// / -Csetup-args=} \
    || (cat builddir/meson-logs/meson-log.txt && exit 1)

$PYTHON -m pip install dist/numpy*.whl
