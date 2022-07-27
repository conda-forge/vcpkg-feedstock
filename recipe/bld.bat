setlocal EnableDelayedExpansion
setlocal enableextensions

IF NOT EXIST %LIBRARY_PREFIX%\share\vcpkg MKDIR %LIBRARY_PREFIX%\share\vcpkg
if errorlevel 1 exit 1

MOVE %SRC_DIR%\ports %LIBRARY_PREFIX%\share\vcpkg\
if errorlevel 1 exit 1

MOVE %SRC_DIR%\scripts %LIBRARY_PREFIX%\share\vcpkg\
if errorlevel 1 exit 1

MOVE %SRC_DIR%\triplets %LIBRARY_PREFIX%\share\vcpkg\
if errorlevel 1 exit 1

MOVE %SRC_DIR%\versions %LIBRARY_PREFIX%\share\vcpkg\
if errorlevel 1 exit 1

COPY %SRC_DIR%\.vcpkg-root %LIBRARY_PREFIX%\share\vcpkg\.vcpkg-root
if errorlevel 1 exit 1

COPY %SRC_DIR%\LICENSE.txt %LIBRARY_PREFIX%\share\vcpkg\LICENSE.txt
if errorlevel 1 exit 1

:: Copy the [de]activate scripts to %PREFIX%\etc\conda\[de]activate.d.
:: This will allow them to be run on environment activation.
for %%F in (activate deactivate) DO (
    if not exist %PREFIX%\etc\conda\%%F.d mkdir %PREFIX%\etc\conda\%%F.d
    copy %RECIPE_DIR%\%%F.bat %PREFIX%\etc\conda\%%F.d\%PKG_NAME%_%%F.bat
    :: Copy unix shell activation scripts, needed by Windows Bash users
    copy %RECIPE_DIR%\%%F.sh %PREFIX%\etc\conda\%%F.d\%PKG_NAME%_%%F.sh
)
if errorlevel 1 exit 1
