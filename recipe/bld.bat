(
echo [DEFAULT]
echo library_dirs = %LIBRARY_LIB%
echo include_dirs = %LIBRARY_INC%
echo.
echo [atlas]
echo atlas_libs = libopenblas
echo libraries = libopenblas
echo.
echo [openblas]
echo libraries = libopenblas
echo library_dirs = %LIBRARY_LIB%
echo include_dirs = %LIBRARY_INC%
) > site.cfg

python setup.py build install --single-version-externally-managed --record=record.txt
if errorlevel 1 exit 1
