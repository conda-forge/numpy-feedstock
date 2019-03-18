(
echo [DEFAULT]
echo library_dirs = %LIBRARY_LIB%
echo include_dirs = %LIBRARY_INC%
) > site.cfg

python -m pip install --no-deps --ignore-installed -v .
if errorlevel 1 exit 1
