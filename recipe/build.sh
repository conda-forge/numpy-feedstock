#!/bin/bash

# Letting NumPy set these for us.
# This may not be the best long term strategy,
# but it works fine to get our first build.
unset LDFLAGS

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


$PYTHON setup.py config
$PYTHON setup.py build
$PYTHON setup.py install
