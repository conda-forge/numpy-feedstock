@echo on

mkdir builddir

:: workaround an issue in vendored meson of numpy
if "%is_freethreading%=="yes" (
  copy %PREFIX%\libs\python313t.lib %PREFIX%\libs\python313.lib
)

:: -wnx flags mean: --wheel --no-isolation --skip-dependency-check
%PYTHON% -m build -w -n -x ^
    -Cbuilddir=builddir ^
    -Csetup-args=-Dblas=blas ^
    -Csetup-args=-Dlapack=lapack
if %ERRORLEVEL% neq 0 exit 1

:: `pip install dist\numpy*.whl` does not work on windows,
:: so use a loop; there's only one wheel in dist/ anyway
for /f %%f in ('dir /b /S .\dist') do (
    pip install %%f
    if %ERRORLEVEL% neq 0 exit 1
)

if "%IS_FREETHREADING%=="yes" (
  del %PREFIX%\libs\python313.lib
)

