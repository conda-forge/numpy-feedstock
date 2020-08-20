(
echo [DEFAULT]
echo library_dirs = %LIBRARY_LIB%
echo include_dirs = %LIBRARY_INC%
echo [lapack]
echo libraries = blas,cblas,lapack
echo [blas]
echo libraries = blas,cblas
) > site.cfg

set "NPY_LAPACK_ORDER=lapack"
set "NPY_BLAS_ORDER=blas"

%PYTHON% -m pip install --no-deps --ignore-installed -v .
if errorlevel 1 exit 1

XCOPY %RECIPE_DIR%\f2py.bat %SCRIPTS% /s /e
if errorlevel 1 exit 1

del %SCRIPTS%\f2py.exe
if errorlevel 1 exit 1
