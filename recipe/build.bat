@echo on

mkdir builddir

:: help meson find Python.h
set "INCLUDEPY=%PREFIX:\=/%/include/python"

sed -i 's/@PREFIX@/%PREFIX%/g' %RECIPE_DIR%\build-details-win.json
type %RECIPE_DIR%\build-details-win.json

:: -wnx flags mean: --wheel --no-isolation --skip-dependency-check
%PYTHON% -m build -w -n -x ^
    -Cbuilddir=builddir ^
    -Csetup-args=--python.build-config=%RECIPE_DIR%\build-details-win.json"
    -Csetup-args=-Dblas=blas ^
    -Csetup-args=-Dlapack=lapack
type %SRC_DIR%\builddir\meson-logs\meson-log.txt
if %ERRORLEVEL% neq 0 exit 1

:: `pip install dist\numpy*.whl` does not work on windows,
:: so use a loop; there's only one wheel in dist/ anyway
for /f %%f in ('dir /b /S .\dist') do (
    pip install %%f
    if %ERRORLEVEL% neq 0 exit 1
)
